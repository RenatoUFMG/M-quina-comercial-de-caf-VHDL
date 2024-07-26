library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controladora is
    generic(
        DATA_WIDTH : natural := 4
    );
    port(
        clock, reset, enter : in std_logic;

        sek_bebida : in std_logic_vector(1 downto 0);
        display : in std_logic_vector((DATA_WIDTH-1) downto 0);
        display2 : in std_logic_vector((DATA_WIDTH-1) downto 0);
        ficha : in std_logic;
        comp_b1, comp_b2, comp_b3 : in std_logic;
        tempof : in std_logic;

        valor_disp : out std_logic_vector((DATA_WIDTH-1) downto 0);
        preco_disp : out std_logic_vector((DATA_WIDTH-1) downto 0);
        
        led : out std_logic
    );

end Controladora;
architecture fsm of Controladora is

    type states is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13);
    signal state : states;

begin
    process(clock, reset)
    begin
        if reset = '1' then
            state <= s0;
        elsif (rising_edge(clock)) then
            case state is
                when s0 =>
                    state <= s1;
                when s1 =>
                    if enter = '1' then
                        if (sel_bebida = "01") then
                            state <= s2;
                        elsif (sel_bebida = "10") then
                            state <= s6;
                        elsif (sel_bebida = "11") then
                            state <= s10;
                        elsif (sel_bebida = "00") then
                            state <= s1;
                        end if;
                    end if;
                when s2 =>
                    if ficha = '1' then
                        state <= s3;
                    elsif comp_b1 = '1' then
                        state <= s4;
                    end if;
                when s3 =>
                    if enter = '1' then
                        state <= s2;
                    end if;
                when s4 =>
                    if tempof = '0' then
                        state <= s5;
                    elsif tempof = '1' then
                        state <= s0;
                    end if;
                when s5=>
                    state <= s4;
                when s6 =>
                    if ficha = '1' then
                        state <= s7;
                    elsif comp_b2 = '1' then
                        state <= s8;
                    end if;
                when s7 =>
                    if enter = '1' then
                        state <= s6;
                    end if;
                when s8 => 
                    if tempof = '0' then
                        state <= s9;
                    elsif tempof = '1' then
                        state <= s0;
                    end if;
                when s9 =>
                    state <= s8;
                when s10 =>
                    if ficha = '1' then
                        state <= s11;
                    elsif comp_b3 = '1' then
                        state <= s12;
                    end if;
                when s11 =>
                    if enter = '1' then
                        state <= s10;
                    end if;
                when s12 =>
                    if tempof = '0' then
                        state <= s13;
                    elsif tempof = '1' then
                        state <= s0;
                    end if;
                when s13 =>
                    state <= s12
            end case;

        end if;    
end fsm;