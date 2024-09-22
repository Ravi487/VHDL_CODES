-- let's take some common code from jumP_addr.vhd file.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BEQ_R1_R2_Address is
Port( clk,reset,M_read,M_write: in std_logic;
       select_mux : out std_logic;
		 PC, MDR,Z,MEM,IR: inout std_logic_vector(18 downto 0);
		  MAR,Y : out std_logic_vector(18 downto 0);
		 R1,R2: inout std_logic_vector(18 downto 0));
end BEQ_R1_R2_Address;

architecture Behavioral of BEQ_R1_R2_Address is
signal m: integer ;
Begin
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
			Z <= IR; --  here IR after decoding Provide the address where ot jumP if condition meet.
		  -- execution of instruction
		  if reset = '1' then 
		      PC <= (others =>'0'); -- clearing the Program counter
			elsif rising_edge(clk) then 
			      for i in 0 to 18 looP
					   if R1(i) = R2(i) then 
						    m <= m+1;
						else 
						    exit;
						end if;
					 end looP;
					 if m= 19 then
					   PC <= Z ; -- in Z address where ot jumP is stored (store by IR)
					 end if;
			else
			          PC <= PC + "0000000000000000001";
			end if;
		end if ;      
				
  
  end Process;
  

end Behavioral;

