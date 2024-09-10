library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ExecuteToMemory_reg is
	port(
		RegWrite_e : in std_logic:='0';
		ResultSrc_e : in std_logic_vector(1 downto 0):="00";
		MemWrite_e : in std_logic:='0';
		AluResult_e : in std_logic_vector(31 downto 0):= x"00000000";
		Rd_e : in std_logic_vector(11 downto 7):="00000";
		Pc4_e : in std_logic_vector(31 downto 0):= x"00000000";
		WriteData_e : in std_logic_vector(31 downto 0):= x"00000000";
		
		clk : in std_logic;
		RegWrite_m : out std_logic:='0';
		ResultSrc_m : out std_logic_vector(1 downto 0):="00";
		MemWrite_m : out std_logic:='0';
		AluResult_m : out std_logic_vector(31 downto 0):= x"00000000";
		Rd_m : out std_logic_vector(11 downto 7):= "00000";
		Pc4_m : out std_logic_vector(31 downto 0):= x"00000000";
		WriteData_m : out std_logic_vector(31 downto 0):= x"00000000"
	);
end entity;

architecture reg3_behav of ExecuteToMemory_reg is
begin
	process(clk)
	begin
	if rising_edge(clk) then 
		RegWrite_m <= RegWrite_e;
		ResultSrc_m <= ResultSrc_e;
		MemWrite_m <= MemWrite_e;
		AluResult_m <= AluResult_e;
		Rd_m <= Rd_e;
		Pc4_m <= Pc4_e;
		WriteData_m <= WriteData_e; 
	end if;
	end process;

end architecture;