-- let's taking some common part from previous code 



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sub is
Port(
    clk, M_read,M_write: in std_logic;
	 select_mux : out std_logic;
	 PC, MDR,Z,MEM:  inout std_logic_vector(18 downto 0);
	 IR, MAR,Y: out std_logic_vector(18 downto 0);
	 R2,R3 : in std_logic_vector(18 downto 0);
	 R1 : out std_logic_vector(18 downto 0)
   );
end sub;

architecture Behavioral of sub is

begin
 process(clk)
  begin
    if rising_edge(clk) then 
	     -- fetching the instruction
		  MAR <= PC;
		  select_mux <= '0';
		  Z <= PC + "0000000000000000001";
		  
		  ----DECODING
		  IR <= MDR;
		  PC <= Z;
		  ---- EXECUTING 
		  R1 <= R2 - R3;
		  
	 end if ;
	end process;


end Behavioral;