LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity Mux_TB is
end Mux_TB;

architecture TB of Mux_TB is
    component Mux
        port (
            clock: in std_logic;
            load: in std_logic;
            reset: in std_logic;
            D: in std_logic_vector (1 downto 0);
            Q: out std_logic_vector (3 downto 0)
        );
    end component;

    signal clock_tb: std_logic := '0';
    signal load_tb: std_logic := '0';
    signal reset_tb: std_logic := '0';
    signal D_tb: std_logic_vector (1 downto 0) := "00";
    signal Q_tb: std_logic_vector (3 downto 0);

begin
    UUT: Mux port map (
        clock => clock_tb,
        load => load_tb,
        reset => reset_tb,
        D => D_tb,
        Q => Q_tb
    );

    process
    begin

        load_tb <= '1';
        D_tb <= "01";
        wait for 10 ns;
        load_tb <= '0';
        wait for 10 ns;

        load_tb <= '1';
        D_tb <= "10";
        wait for 10 ns;
        load_tb <= '0';
        wait for 10 ns;

        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';
        wait for 10 ns;

        load_tb <= '1';
        D_tb <= "11";
        wait for 10 ns;
        load_tb <= '0';
        wait for 10 ns;

        load_tb <= '1';
        D_tb <= "00";
        wait for 10 ns;
        load_tb <= '0';
        wait for 10 ns;

        wait;
    end process;
    
    process
    begin
        clock_tb <= '0';
        wait for 5 ns;
        clock_tb <= '1';
        wait for 5 ns;
    end process;
end TB;