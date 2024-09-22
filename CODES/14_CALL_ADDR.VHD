-- LET'S TAKE SOME COMMON CODE FROM PRIVOUS FILES (BNE_R1_R2_ADDR.VHD) 



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;


ENTITY CALL_ADDR IS 
 Port( clk,reset,M_read,M_write,CALL: in std_logic;
       select_mux : out std_logic;
		 PC, MDR,Z,MEM,IR,SP: inout std_logic_vector(18 downto 0);
		  MAR,Y : out std_logic_vector(18 downto 0)
		 --STACK: inout std_logic_vector(18 downto 0)
		 );
 
END ENTITY;

architecture Behavioral of CALL_ADDR IS 

 type stack_Mem is array(0 downto 18) of std_logic_vector(18 downto 0);
 signal stack: stack_Mem := (others => (others => '0'));

Begin
Process(clk,reset)
   begin 
	  if rising_edge(clk) then
	    -- fetching instruction
		   MAR <= PC;
			select_mux <='0';
			Z <= PC +  "0000000000000000001";
			
			--- DECODING
			IR <= MDR;
			PC <= Z;
			Z <= IR; --  here IR after decoding Provide the address where ot jumP if condition meet.
		  -- execution of instruction
		  if reset = '1' then 
		      PC <= (others =>'0'); -- clearing the Program counter
			elsif rising_edge(clk) then 
			   if call = '1'  then
				    stack(to_integer(unsigned(SP))) <= std_logic_vector(unsigned(PC) +1);-- PC + "0000000000000000001";
					 SP <= SP - "0000000000000000001";
					 PC <= Z ;
			      
			  else
			         PC <= std_logic_vector(unsigned(PC) +1); -- execute next instruction
			   end if;
		end if ;      
		end if;		
  
  end Process;

end architecture;
