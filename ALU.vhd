library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_32bit is
	port(
		Src_A : in std_logic_vector(31 downto 0);
		Src_B : in std_logic_vector(31 downto 0);
		ALU_Control : in std_logic_vector(2 downto 0);
		ZERO : out std_logic;
		ALU_Result : out std_logic_vector(31 downto 0)
	);
end entity;

architecture RTL of ALU_32bit is
signal Result : std_logic_vector (31 downto 0);

	begin
		process(Src_A,Src_B,ALU_Control)
		begin
			case ALU_Control is 
				when "000" =>  
					Result <= std_logic_vector (unsigned(Src_A) + unsigned(Src_B));
				when "001" => 
					Result <= std_logic_vector (unsigned(Src_A) - unsigned(Src_B));
				when "010" =>
					Result <= Src_A and Src_B;
				when "011" => 
					Result <=  Src_A or Src_B;
				when "101" =>	
					if (Src_A<Src_B) then 
						Result <= (0 => '1', others => '0');
					else
						Result <= (others => '0');
					end if;
 				when others => 
					Result <= (others => '0');
			end case;
		end process;
		ALU_Result <= Result;
		ZERO <= '1' when Result = "00000000000000000000000000000000" else '0';
end architecture;
