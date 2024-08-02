library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador is
    port(
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        tempo_in : in std_logic_vector(3 downto 0);
        tempo_out : out std_logic
    );
end Contador;

architecture timer of Contador is
    signal tempo : integer := 0;
begin
    process(clock, reset)
    begin
        if reset = '1' then
            tempo <= 0;
				tempo_out <= '0';
        elsif rising_edge(clock) then
            if start = '1' then
                if tempo < unsigned(tempo_in) then
                    tempo <= tempo + 1;
                    tempo_out <= '0';
                else
                    tempo_out <= '1';
                end if;
            end if;
        end if;
    end process;

end timer;