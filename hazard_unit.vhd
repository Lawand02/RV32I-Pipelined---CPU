library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hazard_detection is 
	port(
		-- Decode Stage
		rs1_id : in std_logic_vector(4 downto 0):="00000"; -- Source Register 1 in Decode Stage
		rs2_id : in std_logic_vector(4 downto 0):="00000"; -- Source Register 2 in Decode Stage.
		
		-- Execute Stage
		rd_ex : in std_logic_vector(4 downto 0):="00000"; -- Destination Register in Excute Stage.
		rs1_ex : in std_logic_vector(4 downto 0):="00000"; -- Source Register 1 in Excute Stage.
		rs2_ex : in std_logic_vector(4 downto 0):="00000"; -- Source Register 2 in Excute Stage.
		resultsrc0_ex : in std_logic:='0'; -- First Bit of the ResultSrc in Excute Stage.
		pcsrc_ex : in std_logic:='0'; -- PCSrc Control Signal in Excute Stage.
		
		-- Memory Stage
		rd_mem : in std_logic_vector(4 downto 0):="00000"; -- Destination Register in Memory Stage.
		regwrite_mem : in std_logic:='0'; --  RF Write Enable in Memory Stage.

		-- Writeback Stage
		rd_wb : in std_logic_vector(4 downto 0):="00000"; -- Destination Register in Writeback Stage.
		regwrite_wb : in std_logic:='0'; -- RF Write Enable in Writeback Stage.
		
		--Control Signals
		
		forwarda_ex : out std_logic_vector(1 downto 0):="00"; -- Forward Mux Control Signal for SrcA.
		forwardb_ex : out std_logic_vector(1 downto 0):="00"; -- Forward Mux Control Signal for SrcB.
		stall_if : out std_logic:='0'; -- Enable Control Signal for the Fetch Stage.
		stall_id : out std_logic:='0'; -- Enable Control Signal for the Decode Stage.
		flush_id : out std_logic:='0'; -- Clear Control Signal for the Decode Stage.
		flush_ex : out std_logic:='0' -- Clear Control Signal for the Decode Stage.
	);
end entity;

architecture Behaviore of hazard_detection is
signal lwStall : std_logic;
begin
		process(rs1_id,rs2_id,rd_ex,rs1_ex,rs2_ex,resultsrc0_ex,pcsrc_ex,rd_mem,regwrite_mem,rd_wb,regwrite_wb)
		begin
			lwStall <= '0';
			if ((rs1_ex = rd_mem) and regwrite_mem ='1') and (rs1_ex /= "00000") then 
				forwarda_ex <= "10";
			elsif ((rs1_ex=rd_wb) and regwrite_wb='1') and (rs1_ex /= "00000") then 
				forwarda_ex <= "01";
			else 
				forwarda_ex <= "00";
			end if;
			
			if ((rs2_ex = rd_mem) and regwrite_mem='1') and (rs2_ex /= "00000") then 
				forwardb_ex <= "10";
			elsif ((rs2_ex=rd_wb) and regwrite_wb='1') and (rs2_ex /= "00000") then 
				forwardb_ex <= "01";
			else 
				forwardb_ex <= "00";
			end if;
			
			if ((resultsrc0_ex='1') and ((rs1_id = rd_ex) or (rs2_id = rd_ex))) then
				lwStall <= '1';
			end if;
			
			stall_if <= lwStall;
			stall_id <= lwStall;
			
			flush_id <= pcsrc_ex;
			flush_ex <= lwStall or pcsrc_ex;
	
	end process;
end architecture; 

