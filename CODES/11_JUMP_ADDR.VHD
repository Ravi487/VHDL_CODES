-- let's take some common code part from increment.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity jump_addr is
Port( clk,reset,M_read,M_write: in std_logic;
       select_mux : out std_logic;
		 PC, MDR,Z,MEM: inout std_logic_vector(18 downto 0);
		  MAR,Y : out std_logic_vector(18 downto 0);
		 R1,IR: inout std_logic_vector(18 downto 0));
end  jumP_addr;
architecture Behavioral of jump_addr is

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
			Z <= IR; --  here IR after decoding Provide the address where ot jumP
		  -- execution of instruction
		  if reset = '1' then 
		      PC <= (others =>'0'); -- clearing the Program counter
			elsif rising_edge(clk) then 
			      PC <= Z ; -- in Z address where ot jumP is stored (store by IR)
			else
			    PC <= PC + "0000000000000000001";
			end if;
		end if ;      
				
  
  end Process;

end Behavioral;
