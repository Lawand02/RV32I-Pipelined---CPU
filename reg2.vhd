library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DcodeToExecute_reg is
	port(
		RegWrite_d : in std_logic := '0' ;
		ResultSrc_d : in std_logic_vector(1 downto 0) := "00";
		MemWrite_d : in std_logic:= '0' ;
		jump_d : in std_logic:= '0' ;
		Branch_d : in std_logic:= '0' ;
		AluControl_d : in std_logic_vector(2 downto 0):= "000";
		AluSrc_d : in std_logic:='0';
		RD1_d : in std_logic_vector(31 downto 0):= x"00000000";
		RD2_d : in std_logic_vector(31 downto 0):= x"00000000";
		PC_d : in std_logic_vector(31 downto 0):= x"00000000";
		Rs1_d : in std_logic_vector(19 downto 15):="00000";
		Rs2_d : in std_logic_vector(24 downto 20):="00000";
		Rd_d : in std_logic_vector(11 downto 7):="00000";
		ImmExt_d : in std_logic_vector(31 downto 0):= x"00000000";
		Pc4_d : in std_logic_vector(31 downto 0):= x"00000000";
		clk: in std_logic;
		CLR : in std_logic:='0';
		RegWrite_e : out std_logic:= '0';
		ResultSrc_e : out std_logic_vector(1 downto 0) := "00";
		MemWrite_e : out std_logic:= '0';
		jump_e : out std_logic:= '0';
		Branch_e : out std_logic:= '0';
		AluControl_e : out std_logic_vector(2 downto 0):= "000";
		AluSrc_e : out std_logic:= '0';
		RD1_e : out std_logic_vector(31 downto 0):= x"00000000";
		RD2_e : out std_logic_vector(31 downto 0):= x"00000000";
		PC_e : out std_logic_vector(31 downto 0):= x"00000000";
		Rs1_e : out std_logic_vector(19 downto 15):="00000";
		Rs2_e : out std_logic_vector(24 downto 20):="00000";
		Rd_e : out std_logic_vector(11 downto 7):="00000";
		ImmExt_e : out std_logic_vector(31 downto 0):= x"00000000";
		Pc4_e : out std_logic_vector(31 downto 0):= x"00000000"
			);
end entity;

architecture reg2_behav of DcodeToExecute_reg is
begin
	process(clk)
	begin
		if rising_edge(clk) then 
			if CLR = '1' then
				RegWrite_e <= '0';
				ResultSrc_e <= (others => '0');
				MemWrite_e <= '0';
				jump_e <= '0';
				Branch_e <= '0';
				AluControl_e <= (others => '0');
				AluSrc_e <= '0';
				RD1_e <= (others => '0');
				RD2_e <= (others => '0');
				PC_e <= (others => '0');
				Rs1_e <= (others => '0');
				Rs2_e <= (others => '0');
				Rd_e <= (others => '0');
				ImmExt_e <= (others => '0');
				Pc4_e <= (others => '0');
			else
				RegWrite_e <= RegWrite_d;
				ResultSrc_e <= ResultSrc_d;
				MemWrite_e <= MemWrite_d;
				jump_e <= jump_d;
				Branch_e <= Branch_d;
				AluControl_e <= AluControl_d;
				AluSrc_e <= AluSrc_d;
				RD1_e <= RD1_d;
				RD2_e <= RD2_d;
				PC_e <= PC_d;
				Rs1_e <= Rs1_d;
				Rs2_e <= Rs2_d;
				Rd_e <= Rd_d;
				ImmExt_e <= ImmExt_d;
				Pc4_e <= Pc4_d;
			end if;
		end if;
	end process;
end architecture;