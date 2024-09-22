-- Here we are peforming fft with 2 point . 
-- So coefficeint will be W0 (1,0) and W1(-1,0) , here first co-ordinate shows real part and 
-- second co-ordinate for the complex part . 
 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 use ieee.std_logic_unsigned.all;
 
 
 entity FFT_R1_R2 is 
 Port(
         clk: in std_logic;
			reset : in std_logic;
			start : in std_logic;
			-- here as we know that each element has two part one is real and another is complex 
			-- so we have to break the whole calculation in two part.
			R2_Real , R2_Imag : in std_logic_vector(18 downto 0); -- input complex number
			R1_Real , R1_Imag: out std_logic_vector ( 18 downto 0); -- output complex number
			-- some signal to identify the process like as done, not done , ideal state or not
			done: out std_logic -- if it is true then fft opretion is completed. 
 
 );
 end entity;
 
 architecture behavioral of fft is 
 
 signal X_real, X_imag : std_logic_vector(18 downto 0);
 signal Y_real ,Y_imag : std_logic_vector(18 downto 0);
 
 type state_type is (idle , load,twiddle_multiply,calc_fft,complete,calc_butterfly);
 signal state: state_type := idle;
 
 signal W_real: std_logic_vector(18 downto 0) := (others =>'0');
 signal W_imag: std_logic_vector(18 downto 0) := (others =>'0');
 
 signal temp_real, temp_imag: std_logic_vector(18 downto 0);
 signal mult_real, mult_imag: std_logic_vector(18 downto 0);
 
 begin
 
     Process(clk,reset)
	  begin
	     if reset= '1' then
		     R1_real <= (others => '0');
			  R1_imag <= (others =>'0');
			   done <= '0';
				state <= idle;
		  elsif rising_edge(clk) then
		     case state is 
			      when idle =>
					      if start = '1' then 
							     X_real <= R2_real;
								  X_imag <= R2_imag;
								  Y_real <= R2_real;
								  Y_imag <= R2_imag;
								  state <= load;
							end if;
					when load =>
					      W_real <= "0000000000000000001";
							W_imag <= (others =>'0');
							state <= calc_butterfly;
							   when calc_butterfly =>
								
								temp_real <= std_logic_vector(signed(X_real) + signed(Y_real));
								temp_imag <= std_logic_vector(signed(X_imag) + signed(Y_imag));
								
								mult_real <= std_logic_vector(signed(X_real) - signed(Y_real));
								mult_imag <= std_logic_vector(signed(X_imag) - signed(Y_imag));
								
								state <= twiddle_multiply;
								  when twiddle_multiply =>
								   R1_real <= std_logic_vector(signed(mult_real)*signed(W_real) - signed(mult_imag) * signed(W_imag));
									R1_imag <= std_logic_vector(signed(mult_real)*signed(W_imag) + signed(mult_imag)*signed(W_real));
									
								state <= calc_fft;
								  when calc_fft =>
								     R1_real <= temp_real;
									  R1_imag <= temp_imag;
								state <= complete;
								when complete =>
								done <= '1';
								state <= idle;
				end case ;
			end if;
		end process;
	end architecture;
 