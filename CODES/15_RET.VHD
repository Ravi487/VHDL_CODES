-- LET'S TAKE SOME COMMON CODE FROM CALL_ADD.VHD FILE


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

ENTITY RET IS 
 Port( clk,reset,M_read,M_write,CALL,RETR: in std_logic;
       select_mux : out std_logic;
		 PC, MDR,Z,MEM,IR,SP: inout std_logic_vector(18 downto 0);
		  MAR,Y : out std_logic_vector(18 downto 0));
		
 
END ENTITY;

architecture Behavioral of RET is
 signal counter : std_logic_vector(18 downto 0);
 type stk is array(0 downto 18 ) of std_logic_vector(18 downto 0);
 signal stack: stk := (others => (others => '0'));
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
			
		  -- execution of instruction
		  if reset = '1' then 
		      PC <= (others =>'0'); -- clearing the Program counter
			elsif rising_edge(clk) then 
			   if RETR= '1'  then
				    
					 SP <= SP + "0000000000000000001";
					 PC <= STACK(to_integer(unsigned(SP)));
			      
			    else
			         counter <= std_logic_vector(unsigned(PC)+1); -- execute next instruction
						PC <= counter;
			     end if;
		  end if ;      
	  end if;	
  
  end Process;

end architecture;
