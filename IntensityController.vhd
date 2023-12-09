library ieee;
use ieee.std_logic_1164.all;

entity IntensityController is
port (
	clk 	: in std_logic;
	m 		: in std_logic;
	bi 	: in std_logic;
	rst 	: in std_logic;
	Q		: in std_logic;
	
	d		: out std_logic;
	en		: out std_logic;
	s		: out bit_vector (1 downto 0)
);
end IntensityController;

architecture hardware of IntensityController is
	type states is (OFF_STATE, LOW_STATE, WAIT_LOW_STATE, NORMAL_STATE, WAIT_NORMAL_STATE, HIGH_STATE, WAIT_HIGH_STATE);
	signal state : states;

begin
	process (clk, rst)
	begin
		if rst = '1' then
			state <= OFF_STATE;
			d <= '0';
			en <= '0';
		elsif (clk'event and clk='1') then
			case state is 
				when OFF_STATE =>
					if bi = '0' then
						state <= OFF_STATE;
						d <= '0';
						en <= '0';
					else
						state <= LOW_STATE;
						d <= '1';
						en <= '0';
					end if;
				when LOW_STATE =>
					if bi = '0' then
						state <= LOW_STATE;
						d <= '1';
						en <= '0';
					else
						state <= WAIT_LOW_STATE;
						d <= '1';
						en <= '0';
					end if;
				when WAIT_LOW_STATE =>
					if bi = '1' then
						state <= WAIT_LOW_STATE;
						d <= '1';
						en <= '0';
					else
						state <= NORMAL_STATE;
						d <= '1';
						en <= '0';
					end if;
				when NORMAL_STATE =>
					if bi = '0' then
						state <= NORMAL_STATE;
						d <= '1';
						en <= '0';
					else
						state <= WAIT_NORMAL_STATE;
						d <= '1';
						en <= '0';
					end if;
				when WAIT_NORMAL_STATE =>
					if bi = '1' then
						state <= WAIT_NORMAL_STATE;
						d <= '1';
						en <= '0';
					else
						state <= HIGH_STATE;
						d <= '1';
						en <= '1';
					end if;
				when HIGH_STATE =>
					if bi = '0' or (m = '1' and Q = '0') then
						state <= HIGH_STATE;
						d <= '1';
						en <= '1';
					elsif m = '1' and Q = '1' then
						state <= NORMAL_STATE;
						d <= '1';
						en <= '0';
					else
						state <= WAIT_HIGH_STATE;
						d <= '1';
						en <= '0';
					end if;
				when WAIT_HIGH_STATE =>
					if bi = '1' then
						state <= WAIT_HIGH_STATE;
						d <= '1';
						en <= '0';
					else
						state <= OFF_STATE;
						d <= '0';
						en <= '0';
					end if;
				when others =>
					state <= OFF_STATE;
					d <= '0';
					en <= '0';
				end case;
			end if;
	end process;
with state select
	s <= 	"00" when OFF_STATE,
			"01" when LOW_STATE,
			"01" when WAIT_LOW_STATE,
			"10" when NORMAL_STATE,
			"10" when WAIT_NORMAL_STATE,
			"11" when HIGH_STATE,
			"11" when WAIT_HIGH_STATE;
end architecture;