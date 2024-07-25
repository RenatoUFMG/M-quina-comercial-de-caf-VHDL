	library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use ieee.numeric_std.all;

	entity comparador is
		
		generic
		(
			DATA_WIDTH: natural := 3
		);
		
		port
		(
			a: in std_logic_vector ((DATA_WIDTH-1) downto 0);
			b: in std_logic_vector ((DATA_WIDTH-1) downto 0);
			suficiente: out std_logic;
			load: in std_logic;
			reset: in std_logic
		);
		
	end comparador;

	architecture comp of comparador is
	begin
		process (a, b, load, reset) is
		begin
			if (reset = '1') then
				suficiente <= '0';
			elsif (load = '1') then
				if (unsigned(a) >= unsigned(b)) then
					suficiente <= '1';
				else 
					suficiente <= '0';
				end if;
			end if;	
		end process;
	end comp;