library ieee;
use ieee.std_logic_1164.all;

entity ModeController is
port (
	clk 	: in std_logic;
	bm		: in std_logic;
	m		: out std_logic
);
end ModeController;

architecture hardware of ModeController is
	type states is (DEFAULT, WAIT_DEFAULT, SAVE, WAIT_SAVE);
	signal state : states;
begin
	process (clk)
	begin
		if (clk'event and clk='1') then
			case state is
				when DEFAULT =>
					if bm = '0' then
						state <= DEFAULT;
						m <= '0';
					else
						state <= WAIT_DEFAULT;
						m <= '0';
					end if;
				when WAIT_DEFAULT =>
					if bm = '1' then
						state <= WAIT_DEFAULT;
						m <= '0';
					else
						state <= SAVE;
						m <= '1';
					end if;
				when SAVE =>
					if bm = '0' then
						state <= SAVE;
						m <= '1';
					else
						state <= WAIT_SAVE;
						m <= '1';
					end if;
				when WAIT_SAVE =>
					if bm = '1' then
						state <= WAIT_SAVE;
						m <= '1';
					else
						state <= DEFAULT;
						m <= '0';
					end if;
				when others =>
					state <= DEFAULT;
					m <= '0';
			end case;
		end if;
	end process;
end architecture;