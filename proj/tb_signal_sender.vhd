library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity tb_signal_sender is
--  Port ( );
end entity tb_signal_sender;

architecture testbench of tb_signal_sender is

  constant c_clk_100mhz_period : time := 10 ns;

  signal rst            : std_logic;
  signal sig_clk_100mhz : std_logic;
  signal send           : std_logic;
  signal data1          : std_logic_vector(20 downto 0);
  signal data2          : std_logic_vector(20 downto 0);
  signal data3          : std_logic_vector(20 downto 0);
  signal data4          : std_logic_vector(20 downto 0);
  signal data5          : std_logic_vector(20 downto 0);
  signal data6          : std_logic_vector(20 downto 0);
  signal data7          : std_logic_vector(20 downto 0);
  signal data8          : std_logic_vector(20 downto 0);
  signal output         : std_logic;
  signal led16_r        : std_logic;
  signal led16_g        : std_logic;
  signal led16_b        : std_logic;

begin

  uut_signal_sender : entity work.signal_sender
    port map (
      rst     => rst,
      clk     => sig_clk_100mhz,
      send    => send,
      data1   => data1,
      data2   => data2,
      data3   => data3,
      data4   => data4,
      data5   => data5,
      data6   => data6,
      data7   => data7,
      data8   => data8,
      output  => output,
      led16_r => led16_r,
      led16_g => led16_g,
      led16_b => led16_b
    );

  p_clk_gen : process is
  begin

    while now < 2800 ns loop -- 200 periods of 100MHz clock

      sig_clk_100mhz <= '0';
      wait for c_clk_100mhz_period / 2;
      sig_clk_100mhz <= '1';
      wait for c_clk_100mhz_period / 2;

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

  p_stimulus : process is
  begin

    data1 <= "000000000000000001110";
    data2 <= "000000000000010101110";
    data3 <= "000000000000010101110";
    data4 <= "000000000000000101110";
    data5 <= "000000000001011101010";
    data6 <= "000000000111011101110";
    data7 <= "011101110111011101110";
    data8 <= "011101110111011101110";
    send  <= '0';
    wait for 200 ns;
    send  <= '1';
    wait for 1200 ns;
    send  <= '0';
    wait for 200 ns;
    send  <= '1';
    wait for 1200 ns;
    send  <= '0';
    wait;

  end process p_stimulus;

end architecture testbench;
