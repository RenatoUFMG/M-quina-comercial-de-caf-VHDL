LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity Mux is
	port
	( 
		clock: in std_logic;
		load: in std_logic;
      	reset: in std_logic;
        tmp1, tmp2, tmp3: in std_logic_vector(7 downto 0);
		D: in std_logic_vector (1 downto 0);
	   	Q: out std_logic_vector (7 downto 0)
	);
end Mux;
architecture mux of Mux is
begin
    process(reset, clock, tmp1, tmp2, tmp3, D, Q)
    begin
        if reset = '1' then
            Q <= "0000";
        elsif (clock'event and clock = '1') then
            if load = '1' then
                case D is
                    when "01" => Q <= "0101";
                    when "10" => Q <= "1010";
                    when "11" => Q <= "1111";
                    when others => Q <= "0000";
                end case;
            end if;
        end if;
    end process;
end mux;

        
