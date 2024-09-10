library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_instruct_tb is
end entity;

architecture behavior of mem_instruct_tb is
    component mem_instruct
        port (
            arst_n : in std_logic;
            A      : in std_logic_vector(31 downto 0);
            RD     : out std_logic_vector(31 downto 0)
        );
    end component;

    signal arst_n : std_logic := '0';
    signal A      : std_logic_vector(31 downto 0) := (others => '0');
    signal RD     : std_logic_vector(31 downto 0);

begin
    DUT: mem_instruct
        port map (
            arst_n => arst_n,
            A      => A,
            RD     => RD
        );

    process
    begin
    
        arst_n <= '0';
        wait for 10 ns;
        arst_n <= '1';

        A <= x"00000000";
        wait for 10 ns;

        A <= x"00000004";	
        wait for 10 ns;
	
        A <= x"00000008";
        wait for 10 ns;
		
		A <= x"0000000C";
		wait for 10 ns;
		
		A <= x"00000012";
		wait for 10 ns;

    end process;
end architecture;