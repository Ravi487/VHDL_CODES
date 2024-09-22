-- let's take common code from load_r1_addr.vhd file


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 
use ieee.std_logic_unsigned.all;

entity STORE_R1_ADDR is
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
        R1         : INOUT std_logic_vector(18 downto 0);
        STACK      : inout std_logic_vector(18 downto 0)
    );
end STORE_R1_ADDR;
architecture Behavioral of STORE_R1_ADDR is
    type MEMORY is array(0 to 18) of std_logic_vector(18 downto 0);  
    signal MEM: MEMORY := (others => (others => '0'));
    signal inter : integer := 0;  
    
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
            
            -- Execution of instruction
            MEM(to_integer(unsigned(Z))) <= R1 ;  -- data of r1 is stored in memory
        end if;
		  
    end Process;
	  

end architecture;