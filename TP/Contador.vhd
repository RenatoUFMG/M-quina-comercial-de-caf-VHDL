library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador is
    port(
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        tempo_in : in std_logic_vector(3 downto 0);
        tempo_out : out std_logic_vector(3 downto 0)
    );
end Contador;

architecture timer of Contador is
    signal tempo : std_logic_vector(3 downto 0) := "0000";
begin
    process(clock, reset)
    begin
        if reset = '1' then
            tempo <= "0000";
        elsif rising_edge(clock) then
            if start = '1' then
                tempo <= std_logic_vector(unsigned(tempo) + 1);
            elsif start = '0' then
                tempo <= tempo_in;
            end if;
        end if;
    end process;

    tempo_out <= tempo when rising_edge(clock);
end timer;