LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath is
    generic
    (
        DATA_WIDTH : natural := 14
    );
    port
    (
        clock : in std_logic;
        reset : in std_logic;
        D : in std_logic_vector ((DATA_WIDTH-1) downto 0);
        a : in std_logic_vector ((DATA_WIDTH-1) downto 0);
        b : in std_logic_vector ((DATA_WIDTH-1) downto 0);
        compi : in std_logic;
        load : in std_logic;
        sensores : in std_logic;
        etapa : in std_logic_vector;
    
---------------------------------------------------------------------------
        
        Q : out std_logic_vector ((DATA_WIDTH-1) downto 0);
        soma : out std_logic_vector ((DATA_WIDTH-1) downto 0);
        suficiente : out std_logic;
        compo: out std_logic

    );
end Datapath;

---------------------------------------------------------------------------

architecture data of Datapath is
    component Reg is
        generic
        (
            DATA_WIDTH : natural:= 14
        );
        port
        ( 
            clock: in std_logic;
            load: in std_logic;
            reset: in std_logic;
            D: in std_logicvector ((DATA_WIDTH-1) downto 0);
            Q: out std_logic_vector ((DATA_WIDTH-1) downto 0)
        );
    end component;

    component comparador is
    generic
    (
        DATA_WIDTH: natural := 14
    );
    port
    (
        a: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        b: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        suficiente: out std_logic
    );
    end component;

    component Somador is
        generic
        (
        DATA_WIDTH : natural:= 14
        );
        port
        (
        clock: in std_logic;
        a: in std_logic_vector ((DATA_WIDTH-1) downto 0); 
        b: in std_logic_vector ((DATA_WIDTH-1) downto 0);
        soma: out std_logic_vector ((DATA_WIDTH-1) downto 0)
        );
    end component;
    begin
        instance_Reg: generic map (DATA_WIDTH => 14) port map (clock => clock, load => load, reset => reset, D => D, Q => Q);
        instance_Somador: generic map (DATA_WIDTH => 14) port map (a => a, b => b, clock => clock, soma => soma);
        instance_Comparador: generic map (DATA_WIDTH => 14) port map (a => compi, b => 3, clock => clock, suficiente => suficiente);
        
