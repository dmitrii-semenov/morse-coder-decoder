library ieee;
  use ieee.std_logic_1164.all;


entity tb_driver_display is
  -- Entity of testbench is always empty
end entity tb_driver_display;


architecture testbench of tb_driver_display is

  -- Testbench local constants
  constant c_CLK_100MHZ_PERIOD : time := 10 ns;

  -- Testench local signals
  signal sig_clk_100mhz : std_logic;
  signal sig_rst        : std_logic;
  signal sig_data1      : std_logic_vector(9 downto 0);
  signal sig_data2      : std_logic_vector(9 downto 0);
  signal sig_data3      : std_logic_vector(9 downto 0);
  signal sig_data4      : std_logic_vector(9 downto 0);
  signal sig_data5      : std_logic_vector(9 downto 0);
  signal sig_data6      : std_logic_vector(9 downto 0);
  signal sig_data7      : std_logic_vector(9 downto 0);
  signal sig_data8      : std_logic_vector(9 downto 0);
  signal sig_seg        : std_logic_vector(6 downto 0);
  signal sig_dig        : std_logic_vector(7 downto 0);

begin

 
  uut_driver_display : entity work.driver_display
    port map (
      clk     => sig_clk_100mhz,
      rst     => sig_rst,
      data1   => sig_data1,
      data2   => sig_data2,
      data3   => sig_data3,
      data4   => sig_data4,
      data5   => sig_data5,
      data6   => sig_data6,
      data7   => sig_data7,
      data8   => sig_data8,
      seg     => sig_seg,
      dig     => sig_dig
    );

  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 400 ns loop -- 40 periods of 100MHz clock

      sig_clk_100mhz <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      sig_clk_100mhz <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;
    wait;

  end process p_clk_gen;

  --------------------------------------------------------
  -- Reset generation process
  --------------------------------------------------------
  p_reset_gen : process is
  begin

    sig_rst <= '0';
    wait for 15 ns;
    sig_rst <= '1';
    wait for 70 ns;
    sig_rst <= '0';
    wait;

  end process p_reset_gen;

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    report "Stimulus process started";
    sig_data8 <= "0001010111"; -- V
    sig_data7 <= "0001110101"; -- L
    sig_data6 <= "0000000111"; -- A
    sig_data5 <= "0000110101"; -- D
    sig_data4 <= "0000000101"; -- I
    sig_data3 <= "0000110111"; -- K
    sig_data2 <= "1111111111"; -- 0
    sig_data1 <= "0111111111"; -- 1

    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end architecture testbench;