library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity decrement is
    Port(
        clk       : in  std_logic;
        reset     : in  std_logic;
        M_read    : in  std_logic;
        M_write   : in  std_logic;
        select_mux: out std_logic;
		  
        PC        : inout std_logic_vector(18 downto 0);
        MDR       : inout std_logic_vector(18 downto 0);
        Z         : inout std_logic_vector(18 downto 0);
        MEM       : inout std_logic_vector(18 downto 0);
        IR        : out std_logic_vector(18 downto 0);
        MAR       : out std_logic_vector(18 downto 0);
        Y         : out std_logic_vector(18 downto 0);
        R1        : inout std_logic_vector(18 downto 0)
    );
end decrement;
architecture inc of decrement is
    signal temp : std_logic_vector(18 downto 0);
	 begin
    process(clk, reset)
    begin
        if reset = '1' then
            temp <= (others => '0'); -- Clear the register
        elsif rising_edge(clk) then
            -- Fetching instruction
            MAR <= PC;
				            select_mux <= '0';
            Z <= PC + "0000000000000000001";

            -- Decoding
            IR <= MDR;
            PC <= Z;
            temp <= R1 - "0000000000000000001";
        end if;
        R1 <= temp; -- Update R1 after processing
    end process;

end architecture;

