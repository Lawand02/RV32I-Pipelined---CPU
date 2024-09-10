library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

architecture tb_control of control_unit_tb is
	component control_unit is
		port (
			Zero : in std_logic;
			op : in std_logic_vector(6 downto 0);
			Funct3 : in std_logic_vector(2 downto 0);
			Funct7 : in std_logic;
			ResultSrc : out std_logic_vector(1 downto 0);
			MemWrite : out std_logic;
			AluSrc : out std_logic;
			ImmSrc : out std_logic_vector(1 downto 0);
			RegWrite : out std_logic;
			AluControl : out std_logic_vector(2 downto 0);
			branch : out std_logic;
			jump : out std_logic
		);
	end component; 
	signal Zero : std_logic;
	signal op : std_logic_vector(6 downto 0);
	signal Funct3 : std_logic_vector(2 downto 0);
	signal Funct7 : std_logic;
	signal ResultSrc : std_logic_vector(1 downto 0);
	signal MemWrite : std_logic;
	signal AluSrc : std_logic;
	signal ImmSrc : std_logic_vector(1 downto 0);
	signal RegWrite : std_logic;
	signal AluControl : std_logic_vector(2 downto 0);
	signal branch : std_logic;
	signal jump : std_logic;

	
	begin 
	uut : control_unit
		port map(
			Zero => Zero,
			op => op,
			Funct3 => Funct3,
			Funct7 => Funct7,
			ResultSrc => ResultSrc,
			MemWrite => MemWrite,
			AluSrc => AluSrc,
			ImmSrc => ImmSrc,
			RegWrite => RegWrite,
			AluControl => AluControl,
			jump => jump,
			branch => branch
		);
	process
		begin
			Zero <= '0';
			op <= "0000011";
			wait for 10 ns;
			Zero <= '1';
			op <= "1100011";
			Funct3 <= "000";
			Funct7 <= '0';
			wait for 10 ns;
			Zero <= '1';
			op <= "0110011";
			Funct3 <= "000";
			Funct7 <= '0';
			wait for 10 ns;
			Zero <= '1';
			op <= "0110011";
			Funct3 <= "111";
			Funct7 <= '0';
			wait for 10 ns;
				
	end process;
	
end architecture;