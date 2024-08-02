library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controladora is
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

end Controladora;
architecture fsm of Controladora is

    type states is (s0, s1, s2, s3, s4);
    signal state : states;

begin
    process(clock, reset, btbeb1, btbeb2, btbeb3)
    begin
        if reset = '1' then
            state <= s0;
				load1 <= '0';
            load2 <= '0';
            load3 <= '0';
        elsif (rising_edge(clock)) then
            case state is
                when s0 =>
                    state <= s1;
                when s1 =>
                    if btbeb1 = '1' or btbeb2 = '1' or btbeb3 = '1' then
								if btbeb1 = '1' and enter = '1' then
                            load1 <= '1';
                            load2 <= '0';
                            load3 <= '0';
									 state <= s2;
                        elsif btbeb2 = '1' and enter = '1' then
                            load1 <= '0';
                            load2 <= '1';
                            load3 <= '0';
									 state <= s2;
                        elsif btbeb3 = '1' and enter = '1' then
                            load1 <= '0';
                            load2 <= '0';
                            load3 <= '1';
									 state <= s2;
								end if;
						   end if;
                when s2 =>
                     if valorsuficiente = '1' then
                        state <= s4;
							elsif ficha = '1' then
                        state <= s3;
                    end if;
                when s3 =>
                    if enter = '0' then
                        state <= s2;
                    end if;
                when s4 =>
                    if temposuficiente = '1' then
								load1 <= '0';
                        load2 <= '0';
                         load3 <= '0';
                        state <= s0;
                    end if;
            end case;
        end if;
    end process;
    process (state)
    begin
        case state is
            when s0 =>
                start <= '0';
                led <= '0';
                ficha_out <= '0';
                reset_componentes <= '1';
            when s1 =>
                start <= '0';
                led <= '0';
                ficha_out <= '0';
                reset_componentes <= '0';
            when s2 =>
                start <= '0';
                led <= '0';
                ficha_out <= '0';
                reset_componentes <= '0';
            when s3 =>
                start <= '0';
                led <= '0';
                ficha_out <= '1';
                reset_componentes <= '0';
            when s4 =>
                start <= '1';
                led <= '1';
                ficha_out <= '0';
                reset_componentes <= '0';
                


        end case;
    end process;
end fsm;
