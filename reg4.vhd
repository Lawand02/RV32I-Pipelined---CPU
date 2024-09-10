library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryToWriteback_reg is
	port(
		RegWrite_m : in std_logic;
		ResultSrc_m : in std_logic_vector(1 downto 0);
		AluResult_m : in std_logic_vector(31 downto 0);
		ReadData_m : in std_logic_vector(31 downto 0);
		Rd_m : in std_logic_vector(11 downto 7);
		Pc4_m : in std_logic_vector(31 downto 0);

		clk : in std_logic;
		
		RegWrite_w : out std_logic;
		ResultSrc_w : out std_logic_vector(1 downto 0);
		AluResult_w : out std_logic_vector(31 downto 0);
		ReadData_w : out std_logic_vector(31 downto 0);
		Rd_w : out std_logic_vector(11 downto 7);
		Pc4_w : out std_logic_vector(31 downto 0)
	);
end entity;

architecture reg4_behav of MemoryToWriteback_reg is
begin
	process(clk)
	begin
	if rising_edge(clk) then 
		RegWrite_w <= RegWrite_m;
		ResultSrc_w <= ResultSrc_m	;
		AluResult_w <= AluResult_m;
		ReadData_w <= ReadData_m;
		Rd_w <= Rd_m;
		Pc4_w <= Pc4_m;
	end if;
	end process;

end architecture;