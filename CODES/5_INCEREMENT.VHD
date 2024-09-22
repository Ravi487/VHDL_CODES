--let's take some Part from last file
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;



entity increament is
Port( clk,reset,M_read,M_write: in std_logic;
       select_mux : out std_logic;
		 PC, MDR,Z,MEM:inout std_logic_vector(18 downto 0);
		 IR, MAR,Y : out std_logic_vector(18 downto 0);
		 R1: inout std_logic_vector(18 downto 0));
end increament;

architecture Behavioral of increament is
signal temP : std_logic_vector(18 downto 0);

begin
 Process(clk,reset)
   begin 
	  if rising_edge(clk) then
	    -- fetching instruction
		   MAR <= PC;
			select_mux <='0';
			Z <= PC + "0000000000000000001";
			
			--- DECODING
			IR <= MDR;
			PC <= Z;
			-- Execution of R1 = R1 + 1
		 
	   	  
			     temP <= R1 + "0000000000000000001";
				 end if;
				
				 R1 <= temP;
	     
		  
end Process;


end architecture;
