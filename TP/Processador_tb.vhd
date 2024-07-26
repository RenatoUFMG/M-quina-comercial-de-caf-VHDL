library ieee;
use ieee.std_logic_1164.all;

entity Processador_tb is
end Processador_tb;

architecture tb of Processador_tb is
    component Processador
        generic(DATA_WIDTH : natural := 4);
        port(
            clock: in std_logic;
            enter: in std_logic;
            reset: in std_logic;
            ficha: in std_logic;
            selecao_bebida : in std_logic_vector(1 downto 0);

            display1_out: out std_logic_vector (6 downto 0);
            display2_out: out std_logic_vector (6 downto 0);
            led : out std_logic
        );
    end component;

    signal clock_tb : std_logic := '0';
    signal enter_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal ficha_tb : std_logic := '0';
    signal selecao_bebida_tb : std_logic_vector(1 downto 0) := "00";

    signal display1_out_tb : std_logic_vector (6 downto 0);
    signal display2_out_tb : std_logic_vector (6 downto 0);
    signal led_tb : std_logic;

begin
    inst_Processador : Processador
        generic map (DATA_WIDTH => 4)
        port map (
            clock => clock_tb,
            enter => enter_tb,
            reset => reset_tb,
            ficha => ficha_tb,
            selecao_bebida => selecao_bebida_tb,

            display1_out => display1_out_tb,
            display2_out => display2_out_tb,
            led => led_tb
        );

    -- Geração do clock
    clock_tb <= not clock_tb after 10 ns;

    -- Estímulo para a entrada
    enter_tb <= '1' after 20 ns, '0' after 40 ns;
    reset_tb <= '1' after 60 ns, '0' after 80 ns;
    ficha_tb <= '1' after 100 ns, '0' after 120 ns;
    selecao_bebida_tb <= "01" after 140 ns, "10" after 160 ns;

end tb;