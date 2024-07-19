LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity Somador_tb is
end Somador_tb;

architecture tb of Somador_tb is
    component Somador
        generic (
            DATA_WIDTH : natural := 14
        );
        port (
            clock : in std_logic;
            a : in std_logic_vector ((DATA_WIDTH-1) downto 0);
            b : in std_logic_vector ((DATA_WIDTH-1) downto 0);
            soma : out std_logic_vector ((DATA_WIDTH-1) downto 0)
        );
    end component;

    constant DATA_WIDTH : natural := 14;
    constant CLOCK_PERIOD : time := 10 ns;

    signal clock_tb : std_logic := '0';
    signal a_tb : std_logic_vector ((DATA_WIDTH-1) downto 0) := (others => '0');
    signal b_tb : std_logic_vector ((DATA_WIDTH-1) downto 0) := (others => '0');
    signal soma_tb : std_logic_vector ((DATA_WIDTH-1) downto 0);

begin
    dut : Somador
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            clock => clock_tb,
            a => a_tb,
            b => b_tb,
            soma => soma_tb
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
        -- Teste 1: a + b = 10
        a_tb <= "00000000001010"; -- 10
        b_tb <= "00000000000000"; -- 0
        wait for CLOCK_PERIOD;
        assert soma_tb = "00000000001010" report "Erro: a + b = 10, soma deve ser 10" severity error;

        -- Teste 2: a + b = 15
        a_tb <= "00000000001010"; -- 10
        b_tb <= "00000000000101"; -- 5
        wait for CLOCK_PERIOD;
        assert soma_tb = "00000000001111" report "Erro: a + b = 15, soma deve ser 15" severity error;

        -- Teste 3: a + b = 20
        a_tb <= "00000000000100"; -- 4
        b_tb <= "00000000010000"; -- 16
        wait for CLOCK_PERIOD;
        assert soma_tb = "00000000010100" report "Erro: a + b = 20, soma deve ser 20" severity error;

        -- Teste 4: a + b = 16383 (máximo valor)
        a_tb <= "11111111111111"; -- 16383
        b_tb <= "00000000000001"; -- 1
        wait for CLOCK_PERIOD;
        assert soma_tb = "11111111111111" report "Erro: a + b = 16383, soma deve ser 16383" severity error;

        wait; -- fim da simulação
    end process;
end tb;
