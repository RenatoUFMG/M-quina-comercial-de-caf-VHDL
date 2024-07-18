LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Somador is
    generic
    (
        DATA_WIDTH : natural:= 14
    );
    port
    (
        clock: in std_logic;
        a: in std_logic_vector ((DATA_WIDTH-1) downto 0); 
        b: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        soma: out std_logic_vector ((DATA_WIDTH-1) downto 0)
    );
end Somador;
architecture sum of Somador is
begin
    process (clock) is
	 
    begin
        if (rising_edge(clock)) then
            soma <= std_logic_vector(unsigned(a) + unsigned(b));
        end if;
    end process;
end sum;x
