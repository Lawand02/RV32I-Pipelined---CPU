library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend_unit is
	port(
		immsrc : in std_logic_vector(1 downto 0);
		original_in : in std_logic_vector(24 downto 0);
		extended_out : out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behavioral of sign_extend_unit is

begin
	process(original_in,immsrc)
	
	begin 
		case immsrc is
		    -- I-type immediate
			when "00" => extended_out <= (31 downto 12 => original_in(24))&original_in(24 downto 13);
			-- S-type immediate
			when "01" => extended_out <= (31 downto 12 => original_in(24))&original_in(24 downto 18)&original_in(4 downto 0);			
			-- B-type immediate
			when "10" => extended_out <= (31 downto 12 => original_in(24))&original_in(0)&original_in(23 downto 18)&original_in(4 downto 1)&'0';
			-- J-type immediate
			when "11" => extended_out <= (31 downto 20 => original_in(24))&original_in(12 downto 5)&original_in(13)&original_in(23 downto 14)&'0';
			when others => extended_out <= (31 downto 0 => '-');
		end case;
	end process;
end architecture; 