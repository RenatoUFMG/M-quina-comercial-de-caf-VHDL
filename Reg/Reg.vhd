LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity Reg is

	generic
	(
		DATA_WIDTH : natural:= 14
	);
	port
	( 
		clock: in std_logic;
		load: in std_logic;
    reset: in std_logic;
		D: in std_logic_vector ((DATA_WIDTH-1) downto 0);
	  Q: out std_logic_vector ((DATA_WIDTH-1) downto 0)
	 );
end Reg;

architecture RTL of Reg is
begin
	process(clock, load, reset)
	begin
      if (reset = '1') then
          Q <= (others => '0');
		elsif (rising_edge(clock) and load = '1') then
			Q <= D;
		end if;
	end process;
end RTL;
