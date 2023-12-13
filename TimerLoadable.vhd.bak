library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TimerLoadable is
    Port (
        clk	: in std_logic;					-- Clock (Recomendado: 1 us)
        en 	: in std_logic;					-- Habilitar/desabilitar timer
        X 	: in unsigned(8 downto 0);		-- Valor a se contar
        Q 	: out std_logic					-- Tempo limite
    );
end TimerLoadable;

architecture Behavioral of TimerLoadable is
    signal counter : unsigned(8 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                if counter = X then
                    Q <= '1';
                    counter <= (others => '0'); -- Resetar temporizador
                else
                    Q <= '0';
                    counter <= counter + 1;
                end if;
            else
                Q <= '0';
            end if;
        end if;
    end process;
end Behavioral;