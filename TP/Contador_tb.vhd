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
            tempo_out : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clock_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal start_tb : std_logic := '0';
    signal tempo_in_tb : std_logic_vector(3 downto 0) := "0000";
    signal tempo_out_tb : std_logic_vector(3 downto 0);

begin
    uut : Contador
        port map(
            clock => clock_tb,
            reset => reset_tb,
            start => start_tb,
            tempo_in => tempo_in_tb,
            tempo_out => tempo_out_tb
        );

    clock_tb <= not clock_tb after 10 ns;

    tb_proc : process
    begin
        -- Teste 1: Reset
        reset_tb <= '1';
        wait for 20 ns;
        reset_tb <= '0';
        wait for 20 ns;

        -- Teste 2: Contagem
        start_tb <= '1';
        wait for 100 ns;
        start_tb <= '0';
        wait for 20 ns;

        -- Teste 3: Entrada de tempo
        tempo_in_tb <= "1010";
        wait for 20 ns;
        start_tb <= '1';
        wait for 20 ns;
        start_tb <= '0';
        wait for 20 ns;

        -- Fim do teste
        wait;
    end process;
end tb;