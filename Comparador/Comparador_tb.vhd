LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity comparador_tb is
end comparador_tb;

architecture tb of comparador_tb is
    component comparador
        generic (
            DATA_WIDTH : natural := 14
        );
        port (
            a : in std_logic_vector ((DATA_WIDTH-1) downto 0);
            b : in std_logic_vector ((DATA_WIDTH-1) downto 0);
            suficiente : out std_logic
        );
    end component;

    constant DATA_WIDTH : natural := 14;

    signal a_tb : std_logic_vector ((DATA_WIDTH-1) downto 0) := (others => '0');
    signal b_tb : std_logic_vector ((DATA_WIDTH-1) downto 0) := (others => '0');
    signal suficiente_tb : std_logic;

begin
    dut : comparador
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            a => a_tb,
            b => b_tb,
            suficiente => suficiente_tb
        );

    stimulus_process : process
    begin
        -- Teste 1: a > b
        a_tb <= "00000000000010"; -- 2
        b_tb <= "00000000000001"; -- 1
        wait for 1 ns;
        assert suficiente_tb = '1' report "Erro: a > b, suficiente deve ser 1" severity error;

        -- Teste 2: a < b
        a_tb <= "00000000000001"; -- 1
        b_tb <= "00000000000010"; -- 2
        wait for 1 ns;
        assert suficiente_tb = '0' report "Erro: a < b, suficiente deve ser 0" severity error;

        -- Teste 3: a = b
        a_tb <= "00000000000010"; -- 2
        b_tb <= "00000000000010"; -- 2
        wait for 1 ns;
        assert suficiente_tb = '1' report "Erro: a = b, suficiente deve ser 1" severity error;

        -- Teste 4: a muito maior que b
        a_tb <= "11111111111111"; -- 16383
        b_tb <= "00000000000001"; -- 1
        wait for 1 ns;
        assert suficiente_tb = '1' report "Erro: a muito maior que b, suficiente deve ser 1" severity error;

        -- Teste 5: a muito menor que b
        a_tb <= "00000000000001"; -- 1
        b_tb <= "11111111111111"; -- 16383
        wait for 1 ns;
        assert suficiente_tb = '0' report "Erro: a muito menor que b, suficiente deve ser 0" severity error;

        wait; -- fim da simulação
    end process;
end tb;
