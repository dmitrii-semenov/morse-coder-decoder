library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity tb_button_driver is
--  Port ( );
end tb_button_driver;

architecture testbench of tb_button_driver is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    signal SW                : std_logic;
    signal rst               : std_logic;
    signal sig_clk_100mhz    : std_logic;
    signal input             : std_logic;
    signal send              : std_logic;
    signal output            : std_logic_vector(20 downto 0);
    signal LED17_R :  STD_LOGIC;
    signal LED17_G :  STD_LOGIC;
    signal LED17_B :  STD_LOGIC;


begin
    uut_button_driver: entity work.button_driver
        port map(
            SW         => SW,
            rst        => rst,
            clk        => sig_clk_100mhz,
            input      => input,
            output     => output,
            send       => send,
            LED17_R    => LED17_R,
            LED17_G    => LED17_G,
            LED17_B    => LED17_B
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

    p_SW : process is
        begin
            SW <= '1';
            wait;
        end process p_SW;

    p_send : process is
        begin
          
            send <= '0';
            wait for 300 ns;
            send <= '1';
            wait for 10 ns;
            send <= '0';
            wait for 220 ns;
            send <= '1';
            wait for 50 ns;
            send <= '0';
            wait for 220 ns;
            send <= '1';
            wait for 10 ns;
            send <= '0';
            wait for 190 ns;
            send <= '1';
            wait for 40 ns;
            send <= '0';
            wait for 200 ns;
            send <= '1';
            wait for 10 ns;
            send <= '0';
            wait for 370 ns;
            send <= '1';
            wait for 10 ns;
            send <= '0';
            wait;
          
    end process p_send;

    p_stimulus : process
    begin
    	input <= '0';
        wait for 200 ns; -- NO INPUT
        input <= '1';
        wait for 25 ns; --longer
        input <= '0';
        wait for 10 ns; -- A
        input <= '1';
        wait for 50 ns; --longer
        input <= '0';
        wait for 100 ns; -- Pause --longer
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 25 ns; --longer
        input <= '0';
        wait for 10 ns; -- B
        input <= '1';
        wait for 10 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 25 ns; --longer
        input <= '0';
        wait for 50 ns; -- Pause --longer
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 25 ns; --longer
        input <= '0';
        wait for 10 ns; -- C
        input <= '1';
        wait for 60 ns; --longer
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 27 ns; --longer
        input <= '0';
        wait for 70 ns; -- Pause --longer
        input <= '1';
        wait for 25 ns; --longer
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
        wait for 50 ns; -- Pause --longer
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 60 ns; -- O --longer
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 50 ns; --longer
        input <= '0';
        wait for 30 ns; -- Pause
        input <= '1';
        wait for 30 ns;
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 50 ns; -- 0 --longer
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 70 ns; --longer
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 30 ns; 
        input <= '0';
        wait for 10 ns;
        input <= '1';
        wait for 70 ns; --longer
        input <= '0';
        wait for 150 ns; -- Pause --longer
        wait;
    end process p_stimulus;
end architecture testbench;