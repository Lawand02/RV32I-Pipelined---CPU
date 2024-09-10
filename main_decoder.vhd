library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_dec is
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
end entity;

architecture Behavioral of main_dec is
signal output : std_logic_vector(10 downto 0);
	begin
		process(op)
		begin
			case op is 
				when "0000011" => -- lw
					output <= "10010010000";
				when "0100011" => -- sw
					output <= "00111--0000";
				when "0110011" => -- R-type
					output <= "1--00000100";
				when "1100011" => -- beq
					output <= "01000--1010";
				when "0010011" => -- I-type ALU
					output <= "10010000100";
				when "1101111" => -- jal
					output <= "111-0100--1";
				when others => 
				output <= "00000000000";
					
				
			end case;
		end process;
		RegWrite <= output(10);
		ImmSrc <= output(9 downto 8);
		AluSrc <= output(7);
		MemWrite <= output(6);
		ResultSrc <= output(5 downto 4);
		branch <= output(3);
		AluOp <= output(2 downto 1);
		jump <= output(0);
		
end architecture;