library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
	port (
		--Zero : in std_logic;
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
end entity; 

architecture Behav of control_unit is
	component main_dec is
	port(
		op : in std_logic_vector(6 downto 0);
		branch : out std_logic;
		jump : out std_logic;
		ResultSrc : out std_logic_vector(1 downto 0);
		MemWrite : out std_logic;
		AluSrc :  out std_logic;
		ImmSrc : out std_logic_vector(1 downto 0);
		RegWrite : out std_logic;
		AluOp : out std_logic_vector(1 downto 0)
	);
	end component;
	
	component alu_decoder is
	port(
		AluOp : in std_logic_vector(1 downto 0);
		Funct3 : in std_logic_vector(2 downto 0);
		Funct7 :  in std_logic_vector(1 downto 0); -- {op5,funct7}
		AluControl : out std_logic_vector(2 downto 0)
	);
	end component;
	signal AluOP : std_logic_vector(1 downto 0);
	--signal branch,jump : std_logic;
	signal op5 : std_logic_vector(1 downto 0);
	--signal Zero : std_logic;
	
	
	begin
	op5 <= op(5)&Funct7;
	main : main_dec 
	port map(
		op => op,
		branch => branch,
		jump => jump,
		ResultSrc => ResultSrc,
		MemWrite => MemWrite,
		AluSrc => AluSrc,
		ImmSrc => ImmSrc,
		RegWrite => RegWrite,
		AluOp => AluOp
	);
	
	alu : alu_decoder 
	port map(
		AluOp => AluOp,
		Funct3 => Funct3,
		Funct7 => op5,
		AluControl => AluControl
	);
	
	-- PcSrc <= (branch and zero) or jump;
	
end architecture;