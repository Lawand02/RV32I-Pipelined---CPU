library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file_tb is
end entity;

architecture behavior of register_file_tb is
    component register_file
        port(
            clk : in std_logic;
            arst_n : in std_logic;
            A1 : in std_logic_vector(4 downto 0);
            A2 : in std_logic_vector(4 downto 0);
            A3 : in std_logic_vector(4 downto 0);
            WD3 : in std_logic_vector(31 downto 0);
            WE3 : in std_logic;
            RD1 : out std_logic_vector(31 downto 0);
            RD2 : out std_logic_vector(31 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal arst_n : std_logic := '0';
    signal A1 : std_logic_vector(4 downto 0) := (others => '0');
    signal A2 : std_logic_vector(4 downto 0) := (others => '0');
    signal A3 : std_logic_vector(4 downto 0) := (others => '0');
    signal WD3 : std_logic_vector(31 downto 0) := (others => '0');
    signal WE3 : std_logic := '0';
    signal RD1 : std_logic_vector(31 downto 0);
    signal RD2 : std_logic_vector(31 downto 0);

begin
    DUT: register_file
        port map(
            clk    => clk,
            arst_n => arst_n,
            A1     => A1,
            A2     => A2,
            A3     => A3,
            WD3    => WD3,
            WE3    => WE3,
            RD1    => RD1,
            RD2    => RD2
        );

  
   clocking : process
	begin
		clk <= not clk;
		wait for 10 ns;
	end process;

    tb : process
    begin
        arst_n <= '0';
        wait for 20 ns;
        arst_n <= '1';

     
        A3 <= "00001";
        WD3 <= x"00000001";
        WE3 <= '1';
        wait for 10 ns;

        A1 <= "00001";
        A2 <= "00001";
        assert RD1 = x"00000001" and RD2 = x"00000001" report "Test 1 failed" severity error;

        A3 <= "00010";
        WD3 <= x"00000002";
        WE3 <= '1';
        wait for 10 ns;

        A1 <= "00010";
        A2 <= "00010";
        assert RD1 = x"00000002" and RD2 = x"00000002" report "Test 2 failed" severity error;

        wait;
    end process;
end architecture;