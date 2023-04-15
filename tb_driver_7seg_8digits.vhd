
library ieee;
  use ieee.std_logic_1164.all;

----------------------------------------------------------
-- Entity declaration for testbench
----------------------------------------------------------

entity tb_driver_7seg_8digits is
  -- Entity of testbench is always empty
end entity tb_driver_7seg_8digits;

----------------------------------------------------------
-- Architecture body for testbench
----------------------------------------------------------

architecture testbench of tb_driver_7seg_8digits is

  -- Testbench local constants
  constant c_CLK_100MHZ_PERIOD : time := 10 ns;

  -- Testench local signals
  signal sig_clk_100mhz : std_logic;
  signal sig_rst        : std_logic;
  signal sig_data1      : std_logic_vector(20 downto 0);
  signal sig_data2      : std_logic_vector(20 downto 0);
  signal sig_data3      : std_logic_vector(20 downto 0);
  signal sig_data4      : std_logic_vector(20 downto 0);
  signal sig_data5      : std_logic_vector(20 downto 0);
  signal sig_data6      : std_logic_vector(20 downto 0);
  signal sig_data7      : std_logic_vector(20 downto 0);
  signal sig_data8      : std_logic_vector(20 downto 0);
  signal sig_seg        : std_logic_vector(6 downto 0);
  signal sig_dig        : std_logic_vector(7 downto 0);

begin

  -- Connecting testbench signals with driver_7seg_8digits
  -- entity (Unit Under Test)
  uut_driver_7seg_8digits : entity work.driver_7seg_8digits
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
    sig_data8 <= "000000000001110101110"; -- K
    sig_data7 <= "000000000111011101110"; -- O
    sig_data6 <= "000000000101110111010"; -- P
    sig_data5 <= "000001010111011101110"; -- 3
    sig_data4 <= "000000000000000000000"; -- nothing
    sig_data3 <= "011100011111110000000"; -- -
    sig_data2 <= "000000000101010101110"; -- 4
    sig_data1 <= "000000000000000101110"; -- A

    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end architecture testbench;