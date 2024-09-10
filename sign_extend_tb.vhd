library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend_unit_tb is
end entity;

architecture tb of sign_extend_unit_tb is
component sign_extend_unit is
	port(
		immsrc : in std_logic_vector(1 downto 0);
		original_in : in std_logic_vector(24 downto 0);
		extended_out : out std_logic_vector(31 downto 0)
	);
end component;
signal original_in : std_logic_vector(24 downto 0) := (others => '0');
signal immsrc      : std_logic_vector(1 downto 0)  := (others => '0');
signal extended_out: std_logic_vector(31 downto 0);
begin 
	uut : sign_extend_unit
		port map (
			original_in => original_in,
			immsrc => immsrc,
			extended_out => extended_out			
		);
	
	process 
	begin 
		-- Test I-type immediate
		original_in <= "1111111110100000000000000";
		immsrc <= "00";
		wait for 10 ns;
	    assert extended_out = X"FFFFFFFA" report "Test case 1 failed" severity error;
		
		original_in <= "0000000010000000000000000";
		immsrc <= "00";
		wait for 10 ns;
	    assert extended_out = X"00000008" report "Test case 1 failed" severity error;
		
		-- Test I-type immediate
		original_in <= "1111111000000000000011010";
		immsrc <= "01";
		wait for 01 ns;
	    assert extended_out = X"FFFFFFFA" report "Test case 1 failed" severity error;
		
		original_in <= "1111111000000000000101010";
		immsrc <= "10";
		wait for 10 ns;
	    assert extended_out = X"FFFFFFFA" report "Test case 1 failed" severity error;
	end process;

end architecture;