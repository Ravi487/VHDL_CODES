library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity mul is
Port( clk,M_read,M_write: in std_logic;
       select_mux : out std_logic;
		 PC, MDR,Z,MEM: inout std_logic_vector(18 downto 0);
		 IR, MAR,Y : out std_logic_vector(18 downto 0);
		 R2,R3 : in std_logic_vector(18 downto 0);
		 R1: out std_logic_vector(18 downto 0));
end mul;

architecture Behavioral of mul is

begin
 Process(clk)
   begin 
	  if rising_edge(clk) then
	    -- fetching instruction
		   MAR <= PC;
			select_mux <='0';
			Z <= PC + "0000000000000000001";
			
			--- DECODING
			IR <= MDR;
			PC <= Z;
			
			--EXECUTION
			R1 <= R2 * R3;
		end if ;
end process;


end Behavioral;