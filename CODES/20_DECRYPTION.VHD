-- WITH THE HELP OF CIRCULAR SHIFT WE HAVE ENCRYPTED THE DATA OF R2 AND STORE IN R1
-- IN FILE ENC_R1_R2.VHD , NOW AS WE KNOW THE PROPERTY OF CIRCULAR SHIFT THAT , 
-- ON CIRCULAR SHIFTING TWICE WE GET THE ORIGINAL BIT SEQUENCE. SO FOR DECRYPTATION 
-- WE JUST SHIFT THE REGISTER SEQUENCE AGAIN. !!!!!!!!!
-- TAKING COMMON DATA FROM  ENC_R1_R2.VHD FILE.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 
use ieee.std_logic_unsigned.all;

entity DEC_R1_R2 is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        M_read     : in  std_logic;
        M_write    : in  std_logic;
        CALL       : in  std_logic;
        select_mux : out std_logic;
		   PC        : inout std_logic_vector(18 downto 0);
        MDR        : inout std_logic_vector(18 downto 0);
        IR         : inout std_logic_vector(18 downto 0);
        SP         : inout std_logic_vector(18 downto 0);
        Z          : inout std_logic_vector(18 downto 0) ;  
        MAR        : out std_logic_vector(18 downto 0); 
		    Y          : out std_logic_vector(18 downto 0);
        R1         : OUT std_logic_vector(18 downto 0);
        STACK      : inout std_logic_vector(18 downto 0);
		  R2         : in std_logic_vector(18 downto 0)
    );

end DEC_R1_R2;

architecture Behavioral of DEC_R1_R2 is
signal x: std_logic_vector(18 downto 0) := "1010101010101010101";
begin
Process(clk, reset) 
    begin 
        if reset = '1' then 
		      
            PC <= (others => '0');  
            R1 <= (others => '0'); 
            Z <= (others => '0');				
        elsif rising_edge(clk) then
		     -- Fetching instruction
            MAR <= PC;
            select_mux <= '0';
            Z <= PC + "000000000000000001";
				 -- Decoding
            IR <= MDR;  -- Assuming this is done after reading from memory
            PC <= Z;    -- Update PC for next instruction
            Z <= IR;  -- Provide the address to store data in R1
				-- execution
				
				R1 <= std_logic_vector(unsigned(R2) xor unsigned(x));
				-- here we are implementing a circular shift for incryption!!
			end if;
 end Process;
end architecture;