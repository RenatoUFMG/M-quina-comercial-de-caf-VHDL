-- ----------------------------------------------------------------------------
-- Testbench for Processador Entity
-- ----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Processador_tb is
end Processador_tb;

architecture tb of Processador_tb is
    -- Component declaration
    component Processador
        generic (DATA_WIDTH : natural := 4);
        port (
            clock : in std_logic;
            enter : in std_logic;
            reset : in std_logic;
            ficha : in std_logic;
            btbeb1, btbeb2, btbeb3 : in std_logic;

            display1_out : out std_logic_vector (6 downto 0);
            display2_out : out std_logic_vector (6 downto 0);
            led : out std_logic
        );
    end component;

    -- Signal declarations
    signal clock_tb : std_logic := '0';
    signal enter_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal ficha_tb : std_logic := '0';
    signal btbeb1_tb, btbeb2_tb, btbeb3_tb : std_logic := '0';

    signal display1_out_tb : std_logic_vector (6 downto 0);
    signal display2_out_tb : std_logic_vector (6 downto 0);
    signal led_tb : std_logic;

begin
    -- Instantiate Processador component
    inst_processador : Processador
        generic map (DATA_WIDTH => 4)
        port map (
            clock => clock_tb,
            enter => enter_tb,
            reset => reset_tb,
            ficha => ficha_tb,
            btbeb1 => btbeb1_tb,
            btbeb2 => btbeb2_tb,
            btbeb3 => btbeb3_tb,

            display1_out => display1_out_tb,
            display2_out => display2_out_tb,
            led => led_tb
        );

    -- Clock generation
    clock_tb <= not clock_tb after 5 ns;

    -- Testbench process
    process
    begin
        -- Reset the system
        reset_tb <= '1';
        enter_tb <= '1';
        wait for 20 ns;
        reset_tb <= '0';

        -- Test case 1: Insert coin and select beverage 1
        wait for 20 ns;
        ficha_tb <= '0';
        btbeb1_tb <= '1';
        wait for 50 ns;

        -- Test case 2: Insert coin and select beverage 2
        btbeb1_tb <= '0';
        ficha_tb <= '1';
        wait for 20 ns;
		    enter_tb <= '0';
		    wait for 20 ns;
		    ficha_tb <= '0';
        wait for 20 ns;
        enter_tb <= '1';


        wait;
    end process;
end tb;