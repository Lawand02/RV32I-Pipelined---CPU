library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FetchToDecode_reg is 
	port(
		Instr_f : in std_logic_vector(31 downto 0):=x"00000000";
		Pc4_f : in std_logic_vector(31 downto 0):=x"00000000";
		clk : in std_logic;
		EN,CLR : in std_logic :='0';
		Pc_f : in std_logic_vector(31 downto 0):=x"00000000";
		Pc_d : out std_logic_vector(31 downto 0):=x"00000000";
		Instr_d : out std_logic_vector(31 downto 0):=x"00000000";
		Pc4_d : out std_logic_vector(31 downto 0):=x"00000000"

	);
end entity;

architecture reg1_behav of FetchToDecode_reg is
begin
	process(clk)
	begin

	if rising_edge(clk) then 
			if CLR = '1' then
				Instr_d <= (others => '0');
				Pc4_d <= (others => '0');
				Pc_d <= (others => '0');
			elsif EN = '0' then 
				Instr_d <= Instr_f;
				Pc4_d <= Pc4_f;
				Pc_d <= Pc_f;
			end if;
	end if;
	end process;
end architecture;