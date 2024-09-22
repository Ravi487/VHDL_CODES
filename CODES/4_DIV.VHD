-- let's take some code from last (mul.vhd) file.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity div is
Port( clk,M_read,M_write: in std_logic;
       select_mux : out std_logic;
		 PC, MDR,Z,MEM: inout std_logic_vector(18 downto 0);
		 IR, MAR,Y : out std_logic_vector(18 downto 0);
		 R2,R3 : in std_logic_vector(18 downto 0);
		 R1: out std_logic_vector(18 downto 0));
end div;

architecture Behavioral of div is
signal temP : std_logic_vector(18 downto 0);
signal temp1 : integer;
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
			
			  
			   if (R3 = (others =>'0')) then 
				   
					 R1 <= (others => '0') ; 
				     
				else 
                                temp1 <= (to_integer(unsigned(R2))/to_integer(unsigned(R3)));
				R1 <= std_logic_vector(to_unsigned(temp1,19));
				end if;
			
	     
			
		end if ;
end process;


end Behavioral;
