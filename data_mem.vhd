library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_data is
	port(
		clk : in std_logic;
		WE    : in std_logic;    
		A : in std_logic_vector(31 downto 0);
		WD : in std_logic_vector(31 downto 0);
		RD : out std_logic_vector(31 downto 0)
	);
end entity;
architecture RTL of mem_data is
	type size is array(127 downto 0) of std_logic_vector(31 downto 0);
	signal memory : size;
	begin
		process(clk)
		begin  
			if rising_edge(clk) then
				if WE = '1' then 
					memory(to_integer(unsigned(A(7 downto 2)))) <= WD;
				end if;
			end if;
		end process;
		RD <= memory(to_integer(unsigned(A(7 downto 2))));
end architecture;