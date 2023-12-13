library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DigitalFan is
    Port (
        clk 	: in  std_logic;    					-- Clock compartilhado
        bm  	: in  std_logic;    					-- Alternar entre modos de economia de energia e padrao
        bi  	: in  std_logic;    					-- Alternar entre as velocidades do ventilador
        rst 	: in  std_logic;    					-- Desliga o ventilador
		  q		: out std_logic;						-- Estouro do temporizador
		  mode 	: out std_logic;						-- Modo atual do ventilador
		  v		: out bit_vector (1 downto 0)		-- Velocidade atual do ventilador
    );
end DigitalFan;

architecture Behavioral of DigitalFan is

	 -- Controlador do modo do ventilador (SAVE ou DEFAULT)
	 component ModeController 
		  Port (
				clk : in  std_logic;
				bm  : in  std_logic;
				m   : out std_logic
		  );
	 end component;

	 -- Controlador da intensidade do ventilador (OFF, LOW, NORMAL, HIGH)
    component IntensityController
        Port (
            clk : in  std_logic;
            m   : in  std_logic;
            bi  : in  std_logic;
            rst : in  std_logic;
            Q   : in std_logic;
				v	 : out bit_vector (1 downto 0);
            en  : out std_logic
        );
    end component;

	 -- Temporizador com load X (8-bit)
    component TimerLoadable
        Port (
				clk	: in std_logic;					-- Clock (Recomendado: 1 us)
				en 	: in std_logic;					-- Habilitar/desabilitar temporizador
				X 		: in unsigned(8 downto 0);		-- Valor a se contar
				Q 		: out std_logic					-- Acusa termino da contagem
        );
    end component;

    -- Conexões
    signal m_out : std_logic;							-- Avisa ao IntensityController qual o modo atual 
	 signal v_out : bit_vector (1 downto 0); 		-- Retorna a velocidade atual
    signal timer_en : std_logic;						-- IntensityController habilita/desabilita contagem
	 signal q_controller : std_logic;				-- Temporizador avisa ao IntensityController o termino da contagem

begin

    ModeCtrl : ModeController
        port map (
            clk => clk,
            bm  => bm,
            m   => m_out
        );

    IntensityCtrl : IntensityController
        port map (
            clk 	=> clk,
            m   	=> m_out,
            bi  	=> bi,
            rst 	=> rst,
            Q   	=> q_controller,
				v		=> v,
            en  	=> timer_en
        );

    TimerLoad : TimerLoadable
        port map (
            clk => clk,
            X   => "000000110",
            en  => timer_en,
            Q   => q_controller
        );
	
	 -- Saidas do sistema
	 q 	<= q_controller;	-- Estouro do temporizador
	 mode <= m_out;			-- Modo atual do ventilador

end Behavioral;