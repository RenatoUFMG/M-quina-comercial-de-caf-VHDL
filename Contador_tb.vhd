library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador_tb is
end Contador_tb;

architecture tb of Contador_tb is
    component Contador
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            tempo_in : in std_logic_vector(3 downto 0);
            tempo_out : out std_logic
        );
    end component;

    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal start : std_logic := '0';
    signal tempo_in : std_logic_vector(3 downto 0) := "0000";
    signal tempo_out : std_logic;

begin
    uut : Contador
        port map(
            clock => clock,
            reset => reset,
            start => start,
            tempo_in => tempo_in,
            tempo_out => tempo_out
        );

    clock_process : process
    begin
        clock <= '0';
        wait for 10 ns;
        clock <= '1';
        wait for 10 ns;
    end process;

    stim_process : process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        start <= '1';
        tempo_in <= "0101";  -- set tempo_in to 5
        wait for 120 ns;

        start <= '0';
		  reset <= '1';
        wait for 20 ns;

		  reset <= '0';
        start <= '1';
        tempo_in <= "1010";  -- set tempo_in to 10
        wait for 220 ns;

        start <= '0';
        wait for 20 ns;

        wait;
    end process;
end tb;
