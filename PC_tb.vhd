library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity pc_tb is
end entity;

architecture tb of pc_tb is
component pc is
port(
	clk : in std_logic;
	arst_n : in std_logic;
	PCNext : in std_logic_vector(31 downto 0);
	PC : out std_logic_vector(31 downto 0)	
);
end component;
signal clk : std_logic := '0';
signal arst_n : std_logic :='1';
signal PCNext : std_logic_vector(31 downto 0);
signal PC : std_logic_vector(31 downto 0);

begin 
	uut : pc 
	port map(
		clk => clk,
		arst_n => arst_n,
		PCNext => PCNext,
		PC => PC
	);
	clocking : process
	begin
		clk <= not clk;
		wait for 10 ns;
	end process;
	test : process 
	begin
		PCNext <= "11110000000000000000000000000000";
		wait for 100 ns;
		PCNext <= "00000000000000000000000000011111";
		wait for 100 ns;
		PCNext <= "11001111110000111111100000000000";
		wait for 100 ns;
		arst_n <= '0';
		wait for 100 ns;

	
	end process;
end architecture;