library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity tb_shifter_16bit is
--  Port ( );
end tb_shifter_16bit;

architecture testbench of tb_shifter_16bit is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    signal rst               : std_logic;
    signal sig_clk_100mhz    : std_logic;
    signal input             : std_logic;
    signal output            : std_logic_vector(15 downto 0);


begin
    uut_shifter_16bit: entity work.shifter_16bit
        port map(
            rst       => rst,
            clk       => sig_clk_100mhz,
            input     => input,
            output    => output
        );
        
    p_clk_gen : process is
    begin
          
        while now < 700 ns loop -- 40 periods of 100MHz clock
          
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
        wait;
      
    end process p_reset_gen;

    p_stimulus : process
    begin
    	input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 10 ns;
        wait;
    end process p_stimulus;
end architecture testbench;