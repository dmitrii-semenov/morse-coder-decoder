----------------------------------------------------------
--
-- Testbench for clock enable circuit.
-- Nexys A7-50T, xc7a50ticsg324-1L
-- TerosHDL, Vivado v2020.2, EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

----------------------------------------------------------
-- Entity declaration for testbench
----------------------------------------------------------

entity tb_clock_divider is
-- Entity of testbench is always empty
end entity tb_clock_divider;

----------------------------------------------------------
-- Architecture body for testbench
----------------------------------------------------------

architecture testbench of tb_clock_divider is

  constant c_length            : natural := 10;
  constant c_clk_100mhz_period : time    := 10 ns;

  -- Local signals
  signal sig_clk_100mhz : std_logic;
  signal sig_rst        : std_logic;
  signal sig_ce         : std_logic;

begin

  -- Connecting testbench signals with clock_enable entity
  -- (Unit Under Test)
  uut_ce : entity work.clock_divider
    generic map (
      g_length => c_length
    )
    -- generic map section and port map section
    port map (
      clk => sig_clk_100mhz,
      rst => sig_rst,
      ce  => sig_ce
    );

  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 100 us loop              -- 75 periods of 100MHz clock

      sig_clk_100mhz <= '0';
      wait for c_clk_100mhz_period / 2;
      sig_clk_100mhz <= '1';
      wait for c_clk_100mhz_period / 2;

    end loop;

    wait;                               -- Process is suspended forever

  end process p_clk_gen;

  --------------------------------------------------------
  -- Reset generation process
  --------------------------------------------------------
  p_reset_gen : process is
  begin

    sig_rst <= '0';
    wait for 28 ns;

    -- Reset activated
    sig_rst <= '1';
    wait for 153 ns;

    -- Reset deactivated
    sig_rst <= '0';

    wait;

  end process p_reset_gen;

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    report "Stimulus process started";
    -- No other input data is needed
    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end architecture testbench;
