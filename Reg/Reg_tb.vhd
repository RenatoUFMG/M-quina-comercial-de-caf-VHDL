LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity Reg_tb is
end Reg_tb;

architecture tb of Reg_tb is
    component Reg
        generic (
            DATA_WIDTH : natural := 14
        );
        port (
            clock : in std_logic;
            load : in std_logic;
            reset : in std_logic;
            D : in std_logic_vector ((DATA_WIDTH-1) downto 0);
            Q : out std_logic_vector ((DATA_WIDTH-1) downto 0)
        );
    end component;

    constant DATA_WIDTH : natural := 14;
    constant CLOCK_PERIOD : time := 10 ns;

    signal clock_tb : std_logic := '0';
    signal load_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal D_tb : std_logic_vector ((DATA_WIDTH-1) downto 0) := (others => '0');
    signal Q_tb : std_logic_vector ((DATA_WIDTH-1) downto 0);

begin
    dut : Reg
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            clock => clock_tb,
            load => load_tb,
            reset => reset_tb,
            D => D_tb,
            Q => Q_tb
        );

    clock_process : process
    begin
        clock_tb <= '0';
        wait for CLOCK_PERIOD/2;
        clock_tb <= '1';
        wait for CLOCK_PERIOD/2;
    end process;

    stimulus_process : process
    begin
        reset_tb <= '1';
        wait for CLOCK_PERIOD;
        reset_tb <= '0';

        D_tb <= "00000000000001"; -- valor de teste
        load_tb <= '1';
        wait for CLOCK_PERIOD;
        load_tb <= '0';

        wait for CLOCK_PERIOD*5; -- aguarda alguns clock cycles

        D_tb <= "00000000000010"; -- outro valor de teste
        load_tb <= '1';
        wait for CLOCK_PERIOD;
        load_tb <= '0';

        wait; -- fim da simulação
    end process;
end tb;
