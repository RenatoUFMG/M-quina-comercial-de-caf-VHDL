library ieee;
use ieee.std_logic_1164.all;

entity Processador is
	 generic(DATA_WIDTH : natural := 4);
    port(
        clock: in std_logic;
        enter: in std_logic;
        reset: in std_logic;
        ficha: in std_logic;
        btbeb1, btbeb2, btbeb3 : in std_logic;

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
            ficha: in std_logic;
            reset: in std_logic;
            load1, load2, load3: in std_logic;
            start: in std_logic;
    
            suficiente_valor, suficiente_tempo: out std_logic;
            display_fichas, display_valor: out std_logic_vector(6 downto 0)
        );
    end component;

    component Controladora
        port(
            clock, reset, enter : in std_logic;
            btbeb1, btbeb2, btbeb3 : in std_logic;
            temposuficiente, valorsuficiente: in std_logic;
            ficha : in std_logic;
              
            
            ficha_out : out std_logic;
            start, led: out std_logic;
            load1, load2, load3 : out std_logic;
            reset_componentes: out std_logic
        );
    end component;

    component DivisorClock
    port(
        clk50MHz: in std_logic;
        reset: in std_logic;
        clk1Hz: out std_logic
    );
    end component;


	signal tmpsuficiente, vlrsuficiente: std_logic;
    signal ficha_out: std_logic;
    signal loads1, loads2, loads3: std_logic;
    signal starttmp: std_logic;
	signal clear:std_logic;
    signal newclock : std_logic;
	 
begin
	 
	inst_divisor : DivisorClock
    port map(
        clk50MHz => clock,
        reset => reset,
        clk1Hz => newclock
    );

    inst_controladora : Controladora
    port map (
        clock => newclock,
        reset => reset,
        enter => enter,
        btbeb1 => btbeb1,
        btbeb2 => btbeb2,
        btbeb3 => btbeb3,
        temposuficiente => tmpsuficiente,
        valorsuficiente => vlrsuficiente,
        ficha => ficha,
        ficha_out => ficha_out,
        start => starttmp,
        led => led,
        load1 => loads1,
        load2 => loads2,
        load3 => loads3,
        reset_componentes => clear
    );

    inst_datapath : Datapath
    generic map (DATA_WIDTH => DATA_WIDTH)
    port map (
        clock => newclock,
        enter => enter,
        reset => clear,
        ficha => ficha_out,
        load1 => loads1,
        load2 => loads2,
        load3 => loads3,
        start => starttmp,
        suficiente_valor => vlrsuficiente,
        suficiente_tempo => tmpsuficiente,
        display_fichas => display1_out,
        display_valor => display2_out
    );
end rtl;