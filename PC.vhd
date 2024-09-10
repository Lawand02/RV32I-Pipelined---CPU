library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
port(
	clk : in std_logic;
	arst_n,EN : in std_logic;
	PCNext : in std_logic_vector(31 downto 0);
	PC : out std_logic_vector(31 downto 0)
);
end entity;
architecture rtl of pc is 
signal count : std_logic_vector(31 downto 0);
begin
	count_process : process(clk)
		begin 
			if rising_edge(clk) then
				if arst_n = '1' then
					count <= (others => '0');
				elsif EN = '0' then 
					count <= PCNext;
					end if;
			end if;
	end process;
		PC <= count;
end architecture;