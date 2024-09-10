library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_decoder is
	port(
		AluOp : in std_logic_vector(1 downto 0);
		Funct3 : in std_logic_vector(2 downto 0);
		Funct7 :  in std_logic_vector(1 downto 0); -- {op5,funct7}
		AluControl : out std_logic_vector(2 downto 0)
	);
end entity;

architecture behavior of alu_decoder is
signal ALU : std_logic_vector(2 downto 0);
begin
	process(AluOp,Funct3,Funct7)
	begin
		case AluOp is
			when "00" =>
				ALU <= "000"; -- Add
			when "01" =>
				ALU <= "001"; -- Sub
			when "10" =>
				if (Funct3 = "000") then
					if (Funct7 = "00" or Funct7 = "01" or Funct7 = "10") then
						ALU <= "000"; -- Add
					elsif (Funct7 = "11") then 
						ALU <= "001"; -- Sub
					end if;
						
				elsif (Funct3 = "010") then 
					ALU <= "101"; -- slt
				elsif (Funct3 = "110") then 
					ALU <= "011"; -- or
				elsif (Funct3 = "111") then 
					ALU <= "010"; -- and
				else
					ALU <= "000";
				
				end if;	
				
			when others => 
				ALU <= "000";
		end case;
	end process;
	AluControl <= ALU;

end architecture;