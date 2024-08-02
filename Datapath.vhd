library ieee;
use ieee.std_logic_1164.all;

entity Datapath is
    generic
    (
        DATA_WIDTH : natural := 4
    );
    port
    (
        clock: in std_logic;
        enter: in std_logic;
        ficha: in std_logic;
        
        reset: in std_logic;
        load1, load2, load3: in std_logic;
        start: in std_logic;

        suficiente_valor, suficiente_tempo: out std_logic;
        display_fichas, display_valor: out std_logic_vector(6 downto 0)

    );  
end Datapath;

architecture RTL of Datapath is
    component Somador
        generic (DATA_WIDTH : natural);
        port(
            clock: in std_logic;
            a: in std_logic_vector ((DATA_WIDTH-1) downto 0); 
            b: in std_logic_vector ((DATA_WIDTH-1) downto 0);
			load: in std_logic;
            soma: out std_logic_vector ((DATA_WIDTH-1) downto 0);
            reset : in std_logic
			);
    end component;

    component Reg
        generic (DATA_WIDTH : natural);
        port(
            clock: in std_logic;
            load: in std_logic;
            reset: in std_logic;
            D: in std_logic_vector ((DATA_WIDTH-1) downto 0);
            Q: out std_logic_vector ((DATA_WIDTH-1) downto 0)
        );
    end component;

    component Comparador
        generic (DATA_WIDTH : natural);
        port(
            a: in std_logic_vector ((DATA_WIDTH-1) downto 0); 
            b: in std_logic_vector ((DATA_WIDTH-1) downto 0);
            clock: in std_logic;
            suficiente: out std_logic
        );
    end component;

    component Bcd_7seg
        port(
            entrada : in std_logic_vector (3 downto 0);
            saida : out std_logic_vector (6 downto 0)
        );
    end component;
    component Contador
        port(
            clock : in std_logic; 
            reset : in std_logic;
            start : in std_logic;
            tempo_in : in std_logic_vector(3 downto 0);
            tempo_out : out std_logic
        );
    end component;

    component DivisorClock
        port(
            clk50MHz: in std_logic;
            reset: in std_logic;
            clk1Hz: out std_logic
        );
    end component;
    
    component Seletor
		  generic(DATA_WIDTH : natural);
        port(
            entrada1, entrada2, entrada3 : in std_logic_vector((DATA_WIDTH-1)downto 0);
            sel1, sel2, sel3 : in std_logic;
            saida : out std_logic_vector((DATA_WIDTH-1)downto 0)
        );
    end component;

--declaraÃ§Ã£o de sinais:
    signal valor1, valor2, valor3, tempo1, tempo2, tempo3: std_logic_vector((DATA_WIDTH-1)downto 0);
    signal valorsel, temposel: std_logic_vector((DATA_WIDTH-1)downto 0);
    signal somafichas, fichas: std_logic_vector((DATA_WIDTH-1)downto 0);
    signal clock_1mhz: std_logic;

begin
--instanciando os componentes:

    --fase 0 - Divisor de clock:
    inst_divisor: DivisorClock
    port map(clk50MHz => clock, reset => reset, clk1Hz => clock_1mhz);

    --fase1 - valores e fichas:
    inst_regv1: Reg
    generic map (DATA_WIDTH => 4)
    port map (clock => clock_1mhz, load => load1, reset => reset, D => "0001", Q => valor1);

    inst_regv2: Reg
    generic map (DATA_WIDTH => 4)
    port map (clock => clock_1mhz, load => load2, reset => reset, D => "0010", Q => valor2);

    inst_regv3: Reg
    generic map (DATA_WIDTH => 4)
    port map (clock => clock_1mhz, load => load3, reset => reset, D => "0101", Q => valor3);

    inst_selvalor: Seletor
	 generic map (DATA_WIDTH => 4)
    port map (entrada1 => valor1, entrada2 => valor2, entrada3 => valor3,
    sel1 => load1, sel2 => load2, sel3 => load3, saida => valorsel);

    inst_regficha: Reg
    generic map (DATA_WIDTH => 4)
    port map (clock => clock_1mhz, load => enter, reset => reset, D => somafichas, Q=> fichas);

    inst_somador_fichas: Somador
    generic map (DATA_WIDTH => 4)
    port map (clock => clock_1mhz, load => ficha, reset => reset, a => fichas, b => "0001", soma => somafichas);

    inst_comp_fichas: Comparador
    generic map (DATA_WIDTH => 4)
    port map (a => fichas, b => valorsel, clock => clock_1mhz, suficiente => suficiente_valor);

    inst_display_fichas: Bcd_7seg
    port map (entrada => fichas, saida => display_fichas);

    inst_display_valor: Bcd_7seg
    port map(entrada => valorsel, saida => display_valor);
    
    --fase 2 - tempo de preparo
    inst_regt1: Reg
    generic map (DATA_WIDTH => 4)
    port map (clock => clock_1mhz, load => load1, reset => reset, D => "0101", Q => tempo1);

    inst_regt2: Reg
    generic map (DATA_WIDTH => 4)
    port map (clock => clock_1mhz, load => load2, reset => reset, D => "1010", Q => tempo2);

    inst_regt3: Reg
    generic map (DATA_WIDTH => 4)
    port map (clock => clock_1mhz, load => load3, reset => reset, D => "1111", Q => tempo3);

    inst_seltempo: Seletor
	 generic map (DATA_WIDTH => 4)
    port map (entrada1 => tempo1, entrada2 => tempo2, entrada3 => tempo3,
    sel1 => load1, sel2 => load2, sel3 => load3, saida => temposel);

    inst_count: Contador
    port map (clock => clock_1mhz, start => start, reset => reset, tempo_in => temposel, tempo_out => suficiente_tempo);
    
    

end RTL;


