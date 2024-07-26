library ieee;
use ieee.std_logic_1164.all;

entity Processador is
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
end Processador;

architecture rtl of Processador is
    component Datapath
        generic(
            DATA_WIDTH : natural := 4
        );
        port(
            clock: in std_logic;
            enter: in std_logic;
            reset: in std_logic;
            sel_bebida : in std_logic_vector(1 downto 0);
            a, b, c: in std_logic_vector((DATA_WIDTH-1)downto 0);
            tmp_str: in std_logic;
            tempofinal: out std_logic;

            reg_out, reg2_out, reg3_out, reg4_out: out std_logic_vector((DATA_WIDTH-1)downto 0);
            soma_out, soma2_out, soma3_out, soma4_out: out std_logic_vector((DATA_WIDTH-1)downto 0);
            comp_b1, comp_b2, comp_b3: out std_logic;
            display_out, display2_out: out std_logic_vector (6 downto 0)
        );
    end component;

    component Controladora
        generic(
            DATA_WIDTH : natural := 4
        );
        port(
            clock, reset, enter: in std_logic;
            sel_bebida : in std_logic_vector(1 downto 0);
            comp_b1, comp_b2, comp_b3: in std_logic;
            regvalor: in std_logic_vector(6 downto 0);
            tempof: in std_logic;
            ficha : in std_logic;

            valor_disp, preco_disp: out std_logic_vector(6 downto 0);
            a, b, c: out std_logic_vector((DATA_WIDTH-1)downto 0);
            tmp_str: out std_logic;
            led: out std_logic;
            reset_componentes: out std_logic
        );
    end component;

	 signal resetar: std_logic;
	signal a, b, c : std_logic_vector((DATA_WIDTH-1) downto 0);
	signal reg_1, reg_2, reg_3 : std_logic_vector(6 downto 0);
	signal reg_1d, reg_2d, reg_3d : std_logic_vector((DATA_WIDTH-1) downto 0);
	signal soma1, soma2, soma3 : std_logic_vector((DATA_WIDTH-1)downto 0);
    signal comp1, comp2, comp3 : std_logic;
    signal starttempo, tempo : std_logic;
    signal display1, display2 : std_logic_vector(6 downto 0);
	 
	 begin
	 
inst_controladora : Controladora
    generic map (DATA_WIDTH => DATA_WIDTH)
    port map (
        clock => clock,
        reset => reset,
        enter => enter,
        sel_bebida => selecao_bebida,
        ficha => ficha,
        comp_b1 => comp1,
        comp_b2 => comp2,
        comp_b3 => comp3,
        regvalor => display1,
        tempof => tempo,
        valor_disp => display1_out,
        preco_disp => display2_out,
        tmp_str => starttempo,
        reset_componentes => resetar,
        a => a,
        b => b,
        c => c,
        led => led
    );

inst_datapath : Datapath
    generic map (DATA_WIDTH => DATA_WIDTH)
    port map (
        clock => clock,
        enter => enter,
        reset => reset,
        sel_bebida => selecao_bebida,
        a => a,
        b => b,
        c => c,
        tmp_str => starttempo,
        tempofinal => tempo,
        reg_out => reg_1d,
        reg2_out => reg_2d,
        reg3_out => reg_3d,
        soma_out => soma1,
        soma2_out => soma2,
        soma3_out => soma3,
        comp_b1 => comp1,
        comp_b2 => comp2,
        comp_b3 => comp3,
        display_out => display1,
		  display2_out => display2
    );
end rtl;
