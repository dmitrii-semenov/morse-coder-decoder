library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity tb_switch_driver is
--  Port ( );
end tb_switch_driver;

architecture testbench of tb_switch_driver is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    signal rst               : std_logic;
    signal sig_clk_100mhz    : std_logic;
    signal send              : std_logic;
    signal SW                : std_logic_vector(9 downto 0);
    signal output            : std_logic_vector(9 downto 0);


begin
    uut_switch_driver: entity work.switch_driver
        port map(
            rst        => rst,
            clk        => sig_clk_100mhz,
            send       => send,
            SW         => SW,
            output     => output
        );
        
    p_clk_gen : process is
    begin
          
        while now < 1200 ns loop -- 100 periods of 100MHz clock
          
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
        SW <= "0000001101";
        send <= '0';
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 50 ns;
    	SW <= "0000010111";
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 200 ns;
        SW <= "0000011101";
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 100 ns;
        SW <= "0000000101";
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 100 ns;
        SW <= "0000110111";
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 100 ns;
        SW <= "0001110101";
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 100 ns;
        SW <= "0000111111";
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 100 ns;
        SW <= "0001010111";
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 100 ns;
        SW <= "0000000001";
        wait for 20 ns;
        send <= '1';
        wait for 10 ns;
        send <= '0';
        wait for 100 ns;
        wait;
    end process p_stimulus;
end architecture testbench;