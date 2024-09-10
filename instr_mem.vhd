library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_instruct is
port(
	A : in std_logic_vector(31 downto 0);
	RD : out std_logic_vector(31 downto 0)
);
end entity;
architecture behavior of mem_instruct is 
type instruct is array (0 to 63)of std_logic_vector(31 downto 0);
-- memory content
signal memory : instruct := (
        x"00500113",
		x"00C00193",
		x"FF718393",
		x"0023E233",
		x"0041F2B3",
		x"004282B3",
		x"02728863",
		x"0041A233",
		x"00020463",
		x"00000293",
		x"0023A233",
		x"005203B3",
		x"402383B3",
		x"0471AA23",
		x"06002103",
		x"005104B3",
		x"008001EF",
		x"00100113",
		x"00910133",
		x"0221A023",
		x"00210063",
		others => x"00000000" -- nop

		);

	begin	

	pro :process(A)
	begin
			RD <= memory(to_integer(unsigned(A(31 downto 2))));		
	end process;
	
end architecture;