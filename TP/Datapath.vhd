library ieee;
use ieee.std_logic_1164.all;

entity Datapath is
    generic
    (
        DATA_WIDTH : natural:= 4
    );
    port
    (
        clock: in std_logic;
        enter: in std_logic;
        reset: in std_logic;
        a: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        b: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        c: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        valorbebida1: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        valorbebida2: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        valorbebida3: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        reg_out: out std_logic_vector ((DATA_WIDTH-1) downto 0);
        reg2_out: out std_logic_vector ((DATA_WIDTH-1) downto 0);
        reg3_out: out std_logic_vector ((DATA_WIDTH-1) downto 0);
        reg4_out: out std_logic_vector ((DATA_WIDTH-1) downto 0);
        soma_out: out std_logic_vector ((DATA_WIDTH-1) downto 0);
        soma2_out: out std_logic_vector ((DATA_WIDTH-1) downto 0);
        soma3_out: out std_logic_vector ((DATA_WIDTH-1) downto 0);
        soma4_out: out std_logic_vector ((DATA_WIDTH-1) downto 0);
        comp_b1: out std_logic;
        comp_b2: out std_logic;
        comp_b3: out std_logic;
        display_out: out std_logic_vector (6 downto 0)
    );
end Datapath;

architecture RTL of Datapath is
    component Somador
        generic (DATA_WIDTH : natural);
        port (clock: in std_logic; a: in std_logic_vector ((DATA_WIDTH-1) downto 0); 
              b: in std_logic_vector ((DATA_WIDTH-1) downto 0); soma: out std_logic_vector ((DATA_WIDTH-1) downto 0);
              reset : in std_logic);
    end component;

    component Reg
        generic (DATA_WIDTH : natural);
        port (clock: in std_logic; load: in std_logic; reset: in std_logic;
              D: in std_logic_vector ((DATA_WIDTH-1) downto 0); Q: out std_logic_vector ((DATA_WIDTH-1) downto 0));
    end component;

    component Comparador
        generic (DATA_WIDTH : natural);
        port (a: in std_logic_vector ((DATA_WIDTH-1) downto 0); 
              b: in std_logic_vector ((DATA_WIDTH-1) downto 0); suficiente: out std_logic);
    end component;

    component Bcd_7seg
        port (entrada : in std_logic_vector (3 downto 0);
              saida : out std_logic_vector (6 downto 0));
    end component;

    signal soma_int: std_logic_vector ((DATA_WIDTH-1) downto 0);
    signal reg_int: std_logic_vector ((DATA_WIDTH-1) downto 0);
    signal reg2_int: std_logic_vector ((DATA_WIDTH-1) downto 0);
    signal reg3_int: std_logic_vector ((DATA_WIDTH-1) downto 0);
    signal reg4_int: std_logic_vector ((DATA_WIDTH-1) downto 0);
    signal soma2_int: std_logic_vector ((DATA_WIDTH-1) downto 0);
    signal soma3_int: std_logic_vector ((DATA_WIDTH-1) downto 0);
    signal soma4_int: std_logic_vector ((DATA_WIDTH-1) downto 0);
    signal display_int: std_logic_vector (6 downto 0);
	 signal display2_int: std_logic_vector (6 downto 0);
begin
    somador_inst: Somador
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (clock => clock, a => reg_int, b => a, soma => soma_int, reset => reset);
    somador2_inst: Somador
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (clock => clock, a => reg2_int, b => b, soma => soma2_int, reset => reset);
    somador3_inst: Somador
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (clock => clock, a => reg3_int, b => c, soma => soma3_int, reset => reset);
	somador4_inst: Somador
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (clock => clock, a => reg2_int, b => reg3_int, soma => soma4_int, reset => reset);
    reg_inst: Reg
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (clock => clock, load => enter, reset => reset, D => soma_int, Q => reg_int);
    reg2_inst: Reg
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (clock => clock, load => enter, reset => reset, D => soma2_int, Q => reg2_int);
    reg3_inst: Reg
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (clock => clock, load => enter, reset => reset, D => soma3_int, Q => reg3_int);
    reg4_inst: Reg
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (clock => clock, load => enter, reset => reset, D => soma4_int, Q => reg4_int);
    comparador1_inst: Comparador
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (a => reg_int, b => valorbebida1, suficiente => comp_b1);
    comparador2_inst: Comparador
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (a => reg2_int, b => valorbebida2, suficiente => comp_b2);
    comparador3_inst: Comparador
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (a => reg3_int, b => valorbebida3, suficiente => comp_b3);
    display_inst: Bcd_7seg
        port map (entrada => reg_int, saida => display_int);
    display2_inst: Bcd_7seg
        port map (entrada => reg_int, saida => display2_int);

    soma_out <= soma_int;
    reg_out <= reg_int;
    reg2_out <= reg2_int;
    reg3_out <= reg3_int;
    reg4_out <= reg4_int;
    soma2_out <= soma2_int;
    soma3_out <= soma3_int;
    soma4_out <= soma4_int;
    display_out <= display_int;
end RTL;