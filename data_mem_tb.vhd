library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_data_tb is
end entity mem_data_tb;

architecture tb of mem_data_tb is
    component mem_data
        port (
            clk : in std_logic;
            arst_n : in std_logic;
            A : in std_logic_vector(31 downto 0);
            WD : in std_logic_vector(31 downto 0);
            WE : in std_logic;
            RD : out std_logic_vector(31 downto 0)
        );
    end component;

    signal clk   : std_logic := '0';
    signal arst_n: std_logic := '0';
    signal A : std_logic_vector(31 downto 0) := (others => '0');
    signal WD : std_logic_vector(31 downto 0) := (others => '0');
    signal WE : std_logic := '0';
    signal RD : std_logic_vector(31 downto 0);

begin
    uut: mem_data
        port map (
            clk   => clk,
            arst_n=> arst_n,
            A     => A,
            WD    => WD,
            WE    => WE,
            RD    => RD
        );

    clocking : process
	begin
		clk <= not clk;
		wait for 10 ns;
	end process;

    tb: process
    begin
        
        arst_n <= '0';
        wait for 20 ns;
        arst_n <= '1';

        -- Write to the memory
        A  <= x"00000000";
        WD <= x"DEADBEEF";
        WE <= '1';
        wait for 10 ns;
        WE <= '0';

        -- Read from the memory
        A  <= x"00000000";
        wait for 10 ns;
        assert RD = x"DEADBEEF" report "Read data mismatch" severity error;
        wait;
    end process;
end architecture;