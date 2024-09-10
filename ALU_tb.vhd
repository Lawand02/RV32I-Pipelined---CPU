library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_32bit_tb is
end entity;

architecture tb of ALU_32bit_tb is

	component ALU_32bit is
	port(
		Src_A : in std_logic_vector(31 downto 0);
		Src_B : in std_logic_vector(31 downto 0);
		ALU_Control : in std_logic_vector(2 downto 0);
		ZERO : out std_logic;
		ALU_Result : out std_logic_vector(31 downto 0)
	);
	end component;
	signal Src_A : std_logic_vector(31 downto 0);
	signal Src_B : std_logic_vector(31 downto 0);
	signal ALU_Control : std_logic_vector(2 downto 0);
	signal ZERO : std_logic;
	signal ALU_Result : std_logic_vector(31 downto 0);
	begin
	uut :ALU_32bit 
		port map(
			Src_A => Src_A,
			Src_B => Src_B,
			ALU_Control => ALU_Control,
			ZERO => ZERO,
			ALU_Result => ALU_Result
		);
		
	process
	begin
	
		Src_A <= "00000000000000000000000000000000";
		Src_B <= "00000000000000000000000000000000";
		ALU_Control <= "000";
		wait for 10 ns;
	
	-- Adder
		Src_A <= "00000000000000000000000000000111";
		Src_B <= "00000000000000000000000000000011";
		ALU_Control <= "000";
		wait for 10 ns;
		assert ALU_Result = X"0000000A" report "Test case 1 failed" severity error;
		
		-- Sub
		Src_A <= "00000000000000000000000000000111";
		Src_B <= "00000000000000000000000000000011";
		ALU_Control <= "001";
		wait for 10 ns;
		assert ALU_Result = X"00000004" report "Test case 1 failed" severity error;
		
		-- And
		Src_A <= "00000000000000000000000000000111";
		Src_B <= "00000000000000000000000000000011";
		ALU_Control <= "010";
		wait for 10 ns;
		assert ALU_Result = X"00000003" report "Test case 1 failed" severity error;
		
		-- Or
		Src_A <= "00000000000000000000000000000111";
		Src_B <= "00000000000000000000000000000011";
		ALU_Control <= "011";
		wait for 10 ns;
		assert ALU_Result = X"00000007" report "Test case 1 failed" severity error;
		
		-- Or
		Src_A <= "00000000000000000000000000000111";
		Src_B <= "00000000000000000000000000001011";
		ALU_Control <= "101";
		wait for 10 ns;
		assert ALU_Result = X"00000001" report "Test case 1 failed" severity error;
		
	end process;
end architecture;