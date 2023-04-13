library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity tb_shifter is
--  Port ( );
end tb_shifter;

architecture testbench of tb_shifter is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    signal rst               : std_logic;
    signal sig_clk_100mhz    : std_logic;
    signal input             : std_logic;
    signal output            : std_logic_vector(20 downto 0);


begin
    uut_shifter: entity work.shifter
        port map(
            rst       => rst,
            clk       => sig_clk_100mhz,
            input     => input,
            output    => output
        );
        
    p_clk_gen : process is
    begin
          
        while now < 2000 ns loop -- 200 periods of 100MHz clock
          
             sig_clk_100mhz <= '0';
             wait for c_CLK_100MHZ_PERIOD / 2;
             sig_clk_100mhz <= '1';
             wait for c_CLK_100MHZ_PERIOD / 2;
          
        end loop;
        wait;
          
    end process p_clk_gen;

    p_reset_gen : process is
    begin
      
        rst <= '0';
        wait for 10 ns;
        rst <= '1';
        wait for 90 ns;
        rst <= '0';
        wait for 1500 ns;
        rst <= '1';
        wait for 90 ns;
        rst <= '0';
        wait;
      
    end process p_reset_gen;

    p_stimulus : process
    begin
    	input <= '0';
        wait for 200 ns; -- NO INPUT
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns; -- A
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 30 ns; -- Pause
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns; -- B
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 30 ns; -- Pause
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns; -- C
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 30 ns; -- Pause
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns; -- J
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 30 ns; -- Pause
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns; -- O
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 30 ns; -- Pause
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns; -- 0
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns; 
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 70 ns; -- Pause
        wait;
    end process p_stimulus;
end architecture testbench;