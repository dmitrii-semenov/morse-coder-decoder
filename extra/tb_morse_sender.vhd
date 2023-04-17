library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity tb_morse_sender is
--  Port ( );
end tb_morse_sender;

architecture testbench of tb_morse_sender is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    signal rst               : std_logic;
    signal sig_clk_100mhz    : std_logic;
    signal send       : std_logic;
    signal data1      : std_logic_vector(9 downto 0);
    signal data2      : std_logic_vector(9 downto 0);
    signal data3      : std_logic_vector(9 downto 0);
    signal data4      : std_logic_vector(9 downto 0);
    signal data5      : std_logic_vector(9 downto 0);
    signal data6      : std_logic_vector(9 downto 0);
    signal data7      : std_logic_vector(9 downto 0);
    signal data8      : std_logic_vector(9 downto 0);
    signal output     : std_logic;
    signal led        : std_logic;


begin
    uut_morse_sender: entity work.morse_sender
        port map(
            rst        => rst,
            clk        => sig_clk_100mhz,
            send       => send,
            data1      => data1,
            data2      => data2,
            data3      => data3,
            data4      => data4,
            data5      => data5,
            data6      => data6,
            data7      => data7,
            data8      => data8,
            output     => output,
            led        => led
        );
        
    p_clk_gen : process is
    begin
          
        while now < 3800 ns loop -- 200 periods of 100MHz clock
          
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
        data8 <= "0001010111"; 
        data7 <= "0001110101"; 
        data6 <= "0000000111"; 
        data5 <= "0000110101"; 
        data4 <= "1111111111"; 
        data3 <= "1111111111"; 
        data2 <= "0011111111"; 
        data1 <= "0000111111"; 
        send <= '0';
        wait for 200 ns;
        send <= '1';
        wait for 1800 ns;
        send <= '0';
        wait for 200 ns;
        send <= '1';
        wait for 1200 ns;
        send <= '0';
        wait;
    end process p_stimulus;
end architecture testbench;