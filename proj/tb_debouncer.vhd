library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity tb_debouncer is
--  Port ( );
end tb_debouncer;

architecture testbench of tb_debouncer is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    signal rst               : std_logic;
    signal sig_clk_100mhz    : std_logic;
    signal input             : std_logic;
    signal output           : std_logic;


begin
    uut_debouncer: entity work.debouncer
        port map(
            rst        => rst,
            clk        => sig_clk_100mhz,
            input      => input,
            output    => output
        );
        
    p_clk_gen : process is
    begin
          
        while now < 30 ms loop -- 100 periods of 100MHz clock
          
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
        wait for 10 ns;
        wait;
      
    end process p_reset_gen;


    p_stimulus : process
    begin
        input <= '1';
        wait for 10 ms;
    	input <= '0';
        wait for 5 ms;
        input <= '1';
        wait for 100 ns;
        input <= '0';
        wait for 100 ns;
        input <= '1';
        wait for 100 ns;
        input <= '0';
        wait for 100 ns;
        input <= '1';
        wait for 100 ns;
        input <= '0';
        wait for 100 ns;
        input <= '1';
        wait for 10 ms;
        wait;
    end process p_stimulus;
end architecture testbench;