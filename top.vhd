library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
port(
	clk : in std_logic;
	arst_n : in std_logic
);
end entity;
architecture RTL of top is
	component pc is
	port(
		clk : in std_logic;
		arst_n,EN : in std_logic;
		PCNext : in std_logic_vector(31 downto 0):=x"00000000";
		PC : out std_logic_vector(31 downto 0):=x"00000000"	
	);
	end component;
	component mem_instruct is
	port(
		A : in std_logic_vector(31 downto 0);
		RD : out std_logic_vector(31 downto 0)
	);
	end component;
	component FetchToDecode_reg is 
	port(
		Instr_f : in std_logic_vector(31 downto 0) :=x"00000000";
		Pc4_f : in std_logic_vector(31 downto 0) :=x"00000000";
		clk : in std_logic;
		EN,CLR : in std_logic :='0';
		Pc_f : in std_logic_vector(31 downto 0) :=x"00000000";
		Pc_d : out std_logic_vector(31 downto 0) :=x"00000000";
		Instr_d : out std_logic_vector(31 downto 0) :=x"00000000";
		Pc4_d : out std_logic_vector(31 downto 0) :=x"00000000"
	);
	end component;
	
	component register_file is
	port(
		clk 	: in std_logic;
		A1 		: in std_logic_vector(4 downto 0);
		A2		: in std_logic_vector(4 downto 0);
		A3 		: in std_logic_vector(4 downto 0);
		WD3		: in std_logic_vector(31 downto 0);
		WE3		: in std_logic;
		RD1		: out std_logic_vector(31 downto 0);
		RD2		: out std_logic_vector(31 downto 0)
	);
	end component;
	component sign_extend_unit is
	port(
		immsrc : in std_logic_vector(1 downto 0);
		original_in : in std_logic_vector(24 downto 0);
		extended_out : out std_logic_vector(31 downto 0)
	);
	end component;
	component control_unit is
	port (
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
	component DcodeToExecute_reg is
	port(
		RegWrite_d : in std_logic:='0';
		ResultSrc_d : in std_logic_vector(1 downto 0):= "00";
		MemWrite_d : in std_logic:='0';
		jump_d : in std_logic:='0';
		Branch_d : in std_logic:='0';
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
		clk : in std_logic;
		CLR : in std_logic:='0';
		RegWrite_e : out std_logic:='0';
		ResultSrc_e : out std_logic_vector(1 downto 0):= "00";
		MemWrite_e : out std_logic:='0';
		jump_e : out std_logic:='0';
		Branch_e : out std_logic:='0';
		AluControl_e : out std_logic_vector(2 downto 0):= "000";
		AluSrc_e : out std_logic:='0';
		RD1_e : out std_logic_vector(31 downto 0):= x"00000000";
		RD2_e : out std_logic_vector(31 downto 0):= x"00000000";
		PC_e : out std_logic_vector(31 downto 0):= x"00000000";
		Rs1_e : out std_logic_vector(19 downto 15):="00000";
		Rs2_e : out std_logic_vector(24 downto 20):="00000";
		Rd_e : out std_logic_vector(11 downto 7):="00000";
		ImmExt_e : out std_logic_vector(31 downto 0):= x"00000000";
		Pc4_e : out std_logic_vector(31 downto 0):= x"00000000"
			);
	end component;
	component ALU_32bit is
	port(
		Src_A : in std_logic_vector(31 downto 0);
		Src_B : in std_logic_vector(31 downto 0);
		ALU_Control : in std_logic_vector(2 downto 0);
		ZERO : out std_logic;
		ALU_Result : out std_logic_vector(31 downto 0)
	);
	end component;
	
	component ExecuteToMemory_reg is
	port(
		RegWrite_e : in std_logic;
		ResultSrc_e : in std_logic_vector(1 downto 0);
		MemWrite_e : in std_logic;
		AluResult_e : in std_logic_vector(31 downto 0):= x"00000000";
		Rd_e : in std_logic_vector(11 downto 7);
		Pc4_e : in std_logic_vector(31 downto 0):= x"00000000";
		WriteData_e : in std_logic_vector(31 downto 0):= x"00000000";
		
		clk : in std_logic;
		RegWrite_m : out std_logic:='0';
		ResultSrc_m : out std_logic_vector(1 downto 0):= "00";
		MemWrite_m : out std_logic:= '0';
		AluResult_m : out std_logic_vector(31 downto 0):= x"00000000";
		Rd_m : out std_logic_vector(11 downto 7):="00000";
		Pc4_m : out std_logic_vector(31 downto 0):= x"00000000";
		WriteData_m : out std_logic_vector(31 downto 0):= x"00000000"
		);
	end component;
	component mem_data is
	port(
		clk : in std_logic;
		WE    : in std_logic;    
		A : in std_logic_vector(31 downto 0);
		WD : in std_logic_vector(31 downto 0);
		RD : out std_logic_vector(31 downto 0)
	);
	end component;
	component MemoryToWriteback_reg is
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
	end component;
	component hazard_detection is 
	port(
		rs1_id : in std_logic_vector(4 downto 0):="00000";
		rs2_id : in std_logic_vector(4 downto 0):="00000"; 
		rd_ex : in std_logic_vector(4 downto 0):="00000"; 
		rs1_ex : in std_logic_vector(4 downto 0):="00000"; 
		rs2_ex : in std_logic_vector(4 downto 0):="00000";
		resultsrc0_ex : in std_logic:='0'; 
		pcsrc_ex : in std_logic:='0'; 
		rd_mem : in std_logic_vector(4 downto 0):="00000";
		regwrite_mem : in std_logic:='0';
		rd_wb : in std_logic_vector(4 downto 0):="00000"; 
		regwrite_wb : in std_logic:='0'; 
		forwarda_ex : out std_logic_vector(1 downto 0):="00"; 
		forwardb_ex : out std_logic_vector(1 downto 0):="00";
		stall_if : out std_logic:='0';
		stall_id : out std_logic:='0';
		flush_id : out std_logic:='0';
		flush_ex : out std_logic:='0'
	);
	end component;
	
	-- pc
	signal Stall_f : std_logic := '0';
	signal pc_f,pcNext_f : std_logic_vector(31 downto 0):=x"00000000";
	signal PcPlus4_f: std_logic_vector(31 downto 0):=x"00000000";
	-- Instruction Memory
	signal Instr_f : std_logic_vector(31 downto 0):=x"00000000";
	-- MUX Fetch Stage 
	signal PcSrc : std_logic := '0';
	-- FetchToDecode Registers
	signal PcTarget_e : std_logic_vector(31 downto 0):=x"00000000";
	signal Instr_d : std_logic_vector(31 downto 0):=x"00000000";
	signal pc_d,PcPlus4_d : std_logic_vector(31 downto 0):=x"00000000";
	-- Registers File
	signal Rd_w : std_logic_vector(4 downto 0):="00000";
	signal Result_w : std_logic_vector(31 downto 0):=x"00000000";
	signal RegWrite_w : std_logic := '0';
	signal RD1_d : std_logic_vector(31 downto 0):=x"00000000";
	signal RD2_d : std_logic_vector(31 downto 0):=x"00000000";
	-- FetchToDecode Register
	signal Stall_d : std_logic := '0';
	signal Flush_d : std_logic := '0';
	-- sign Extend
	signal ImmSrc_d : std_logic_vector(1 downto 0):="00";
	signal ImmExt_d : std_logic_vector(31 downto 0):=x"00000000";
	-- controll_unit
	signal RegWrite_d : std_logic := '0';
	signal ResultSrc_d : std_logic_vector(1 downto 0):="00";
	signal MemWrite_d : std_logic:='0';
	signal Jump_d : std_logic := '0';
	signal Branch_d : std_logic := '0';
	signal AluControl_d : std_logic_vector(2 downto 0):="000";
	signal AluSrc_d : std_logic := '0';
	--DecodeToExecute Register
	signal RegWrite_e : std_logic := '0';
	signal ResultSrc_e : std_logic_vector(1 downto 0):="00";
	signal MemWrite_e : std_logic := '0';
	signal Jump_e : std_logic := '0';
	signal Branch_e : std_logic := '0';
	signal AluControl_e : std_logic_vector(2 downto 0):="000";
	signal AluSrc_e : std_logic:='0';
	signal RD1_e : std_logic_vector(31 downto 0):=x"00000000";
	signal RD2_e : std_logic_vector(31 downto 0):=x"00000000";
	signal PC_e : std_logic_vector(31 downto 0):=x"00000000";
	signal Rs1_e : std_logic_vector(19 downto 15):="00000";
	signal Rs2_e : std_logic_vector(24 downto 20):="00000";
	signal Rd_e : std_logic_vector(11 downto 7):="00000";
	signal ImmExt_e : std_logic_vector(31 downto 0):=x"00000000";
	signal PcPlus4_e : std_logic_vector(31 downto 0):=x"00000000";
	signal Flush_e : std_logic := '0';

	--MUX
	signal ForwardA_e : std_logic_vector(1 downto 0):="00";
	signal SrcA_e : std_logic_vector(31 downto 0):=x"00000000";
	signal ALUResult_m : std_logic_vector(31 downto 0):=x"00000000"; 
	signal ForwardB_e :  std_logic_vector(1 downto 0):="00";
	signal WriteData_e : std_logic_vector(31 downto 0):=x"00000000";
	signal SrcB_e : std_logic_vector(31 downto 0):=x"00000000";
	--ALU
	signal ZERO_e : std_logic := '0';
	signal ALUResult_e : std_logic_vector(31 downto 0):=x"00000000"; 
	-- ExecuteToMemory_reg
	signal RegWrite_m : std_logic := '0';
	signal ResultSrc_m : std_logic_vector(1 downto 0):="00";
	signal MemWrite_m : std_logic := '0';
	signal WriteData_m : std_logic_vector(31 downto 0):=x"00000000";
	signal Rd_m : std_logic_vector(11 downto 7):="00000";
	signal PcPlus4_m : std_logic_vector(31 downto 0):=x"00000000";
	-- data memory
	signal ReadData_m : std_logic_vector(31 downto 0):=x"00000000";
	-- MemoryToWriteback_reg
	signal ResultSrc_w : std_logic_vector(1 downto 0):="00";
	signal ALUResult_w : std_logic_vector(31 downto 0):=x"00000000"; 
	signal ReadData_w : std_logic_vector(31 downto 0):=x"00000000";
	signal PcPlus4_w : std_logic_vector(31 downto 0):=x"00000000";

	begin	
	PCounter : pc 
		port map(
			clk => clk,
			arst_n => arst_n,
			EN => Stall_f,
			PCNext => pcNext_f,
			PC => pc_f	
		);
	InstructionMemory : mem_instruct
		port map(
			A => pc_f,
			RD => Instr_f	
		);
	PcPlus4_f <= std_logic_vector (signed(pc_f) + X"00000004");
	
	with PcSrc select
		pcNext_f <= PcPlus4_f when '0',
					PcTarget_e when '1',
					x"00000000" when others; 
	reg1 : FetchToDecode_reg
		port map(
			clk => clk,
			Instr_f => Instr_f,
			Pc_f => Pc_f,
			Pc4_f => PcPlus4_f,
			EN => Stall_d,
			CLR => Flush_d,
			Instr_d => Instr_d,
			pc_d => pc_d,
			Pc4_d => PcPlus4_d
			);
	reg_file : register_file
		port map(
			clk => clk,
			A1 => Instr_d(19 downto 15),
			A2 => Instr_d(24 downto 20),
			A3 => Rd_w,
			WD3 => Result_w,
			WE3 => RegWrite_w,
			RD1 => RD1_d,
			RD2 => RD2_d
			);
	sign_extend : sign_extend_unit
		port map(
			immsrc => ImmSrc_d,
			original_in => Instr_d(31 downto 7),
			extended_out => ImmExt_d		
		);
	controller : control_unit 
		port map(
			op => Instr_d(6 downto 0),
			Funct3 => Instr_d(14 downto 12),
			Funct7 => Instr_d(30),
			ResultSrc => ResultSrc_d,
			MemWrite => MemWrite_d,
			AluSrc => AluSrc_d,
			ImmSrc => ImmSrc_d,
			RegWrite => RegWrite_d,
			AluControl => AluControl_d,
			jump => Jump_d,
			branch => Branch_d
		);	
	reg2 : DcodeToExecute_reg
		port map(
		RegWrite_d => RegWrite_d,
		ResultSrc_d => ResultSrc_d,
		MemWrite_d => MemWrite_d,
		jump_d => Jump_d,
		Branch_d => Branch_d,
		AluControl_d => AluControl_d,
		AluSrc_d => AluSrc_d,
		RD1_d => RD1_d,
		RD2_d => RD2_d,
		PC_d => pc_d,
		Rs1_d => Instr_d(19 downto 15),
		Rs2_d => Instr_d(24 downto 20),
		Rd_d => Instr_d(11 downto 7),
		ImmExt_d => ImmExt_d,
		Pc4_d => PcPlus4_d,
		clk => clk,
		CLR => Flush_e,	
		RegWrite_e => RegWrite_e,
		ResultSrc_e => ResultSrc_e,
		MemWrite_e => MemWrite_e,
		jump_e => Jump_e,
		Branch_e => Branch_e,
		AluControl_e => AluControl_e,
		AluSrc_e => AluSrc_e,
		RD1_e => RD1_e,
		RD2_e => RD2_e,
		PC_e => PC_e,
		Rs1_e => Rs1_e,
		Rs2_e => Rs2_e,
		Rd_e => Rd_e,
		ImmExt_e => ImmExt_e,
		Pc4_e => PcPlus4_e	
		);	
		with ForwardA_e select	
			SrcA_e <= RD1_e when "00",
					  Result_w when "01",
					  ALUResult_m when "10",
					  x"00000000" when others; 
		with ForwardB_e select	
			WriteData_e <= RD2_e when "00",
					  Result_w when "01",
					  ALUResult_m when "10",
					  x"00000000" when others; 
		with AluSrc_e select	
			SrcB_e <= WriteData_e when '0',
					  ImmExt_e when '1',
					  x"00000000" when others; 
	ALU32Bit : ALU_32bit
		port map(
			Src_A => SrcA_e,
			Src_B => SrcB_e,
			ALU_Control => AluControl_e,
			ZERO => ZERO_e,
			ALU_Result => ALUResult_e	
		);
	PcSrc <= (ZERO_e and Branch_e) or Jump_e;
	
	PcTarget_e <= std_logic_vector (signed(PC_e) + signed(ImmExt_e));
	
	reg3 : ExecuteToMemory_reg
		port map (
			RegWrite_e => RegWrite_e,
			ResultSrc_e => ResultSrc_e,
			MemWrite_e => MemWrite_e,
			AluResult_e => AluResult_e,
			Rd_e => Rd_e,
			Pc4_e => PcPlus4_e,
			WriteData_e => WriteData_e,
			clk => clk,
			RegWrite_m => RegWrite_m,
			ResultSrc_m => ResultSrc_m,
			MemWrite_m => MemWrite_m,
			AluResult_m => ALUResult_m,
			Rd_m => Rd_m,
			Pc4_m => PcPlus4_m,
			WriteData_m => WriteData_m	
		);
	data_memmory : mem_data
		port map(
			clk => clk,
			WE => MemWrite_m,   
			A => ALUResult_m,
			WD => WriteData_m,
			RD => ReadData_m
		);
	reg4 : MemoryToWriteback_reg
		port map(
			RegWrite_m => RegWrite_m,
			ResultSrc_m => ResultSrc_m,
			AluResult_m => AluResult_m,
			ReadData_m => ReadData_m,
			Rd_m => Rd_m,
			Pc4_m => PcPlus4_m,
			clk => clk,
			RegWrite_w => RegWrite_w,
			ResultSrc_w => ResultSrc_w,
			AluResult_w => ALUResult_w,
			ReadData_w => ReadData_w,
			Rd_w => Rd_w,
			Pc4_w => PcPlus4_w
		);
	with ResultSrc_w select	
			Result_w <= ALUResult_w when "00",
					    ReadData_w when "01",
					    PcPlus4_w when "10",
					    x"00000000" when others; 
	Hazard_Unit : hazard_detection
		port map(
		rs1_id => Instr_d(19 downto 15),
		rs2_id => Instr_d(24 downto 20),
		rd_ex => Rd_e, 
		rs1_ex => Rs1_e,
		rs2_ex => Rs2_e,
		resultsrc0_ex => ResultSrc_e(0),
		pcsrc_ex => PcSrc,
		rd_mem => Rd_m,
		regwrite_mem => RegWrite_m,
		rd_wb => Rd_w,
		regwrite_wb => RegWrite_w,
		forwarda_ex => ForwardA_e,
		forwardb_ex => ForwardB_e,
		stall_if => Stall_f,
		stall_id => Stall_d, 
		flush_id => Flush_d,
		flush_ex => Flush_e
		);
end architecture;