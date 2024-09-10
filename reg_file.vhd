library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity register_file is
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
end entity;

architecture Behavioral of register_file is
	    type register_array is array (0 to 31) of std_logic_vector(31 downto 0);
		signal registers : register_array := (0 => x"00000000", others => (others => '0'));
begin
		RD1 <= registers(to_integer(unsigned(A1)));
        RD2 <= registers(to_integer(unsigned(A2)));	
	process(clk)
	begin
   
        if falling_edge(clk) then
            if WE3 = '1'  and to_integer(unsigned(A3)) /= 0 then
                registers(to_integer(unsigned(A3))) <= WD3;
            end if;
        end if;
	end process;
end architecture;