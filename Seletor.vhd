LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity Seletor is
	 generic(DATA_WIDTH : natural := 4);
    port(
        entrada1, entrada2, entrada3: in std_logic_vector((DATA_WIDTH-1)downto 0);
        sel1, sel2, sel3 : in std_logic;
        saida: out std_logic_vector((DATA_WIDTH-1)downto 0)
    );
end Seletor;

architecture sel of Seletor is
begin
    process(entrada1, entrada2, entrada3, sel1, sel2, sel3)
    begin
        if sel1 = '1' then
            saida <= entrada1;
        elsif sel2 = '1' then
            saida <= entrada2;
        elsif sel3 = '1' then
            saida <= entrada3;
        end if;
    end process;
end sel;
