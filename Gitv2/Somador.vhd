LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Somador is
    generic
    (
        DATA_WIDTH : natural:= 4
    );
    port
    (
        clock: in std_logic;
        a: in std_logic_vector ((DATA_WIDTH-1) downto 0); 
        b: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        load: in std_logic;
        soma: out std_logic_vector ((DATA_WIDTH-1) downto 0);
		reset : in std_logic
    );
end Somador;
architecture sum of Somador is
begin
   process (clock, reset, a, b) is 
   begin
		if (reset = '1') then
			soma <= (others => '0');
		elsif (rising_edge(clock) and load = '1') then
			soma <= std_logic_vector(unsigned(a) + unsigned(b));
      end if;
    end process;
end sum;