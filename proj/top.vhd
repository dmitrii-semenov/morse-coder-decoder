----------------------------------------------------------
--
--! @title Driver for 4-digit 7-segment display
--! @author Tomas Fryza
--! Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
--!
--! @copyright (c) 2020 Tomas Fryza
--! This work is licensed under the terms of the MIT license
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

----------------------------------------------------------

entity top is
  port (
    clk100mhz : in    std_logic;
    d14       : in    std_logic;
    sw0       : in    std_logic;
    sw1       : in    std_logic;
    btnl      : in    std_logic;
    btnc      : in    std_logic;
    btnd      : in    std_logic;
    seg       : out   std_logic_vector(6 downto 0);
    dig       : out   std_logic_vector(7 downto 0);
    e16       : out   std_logic;
    led16_r   : out   std_logic;
    led16_g   : out   std_logic;
    led16_b   : out   std_logic;
    led17_r   : out   std_logic;
    led17_g   : out   std_logic;
    led17_b   : out   std_logic;
    led_sig   : out   std_logic
  );
end entity top;

----------------------------------------------------------
-- Architecture declaration for display driver
----------------------------------------------------------

architecture behavioral of top is

  signal clk_ce  : std_logic;
  signal deb_out : std_logic;
  signal sig_16  : std_logic;
  signal out_a   : std_logic_vector(20 downto 0);
  signal out_b   : std_logic_vector(20 downto 0);
  signal out_mux : std_logic_vector(20 downto 0);
  signal out_1   : std_logic_vector(20 downto 0);
  signal out_2   : std_logic_vector(20 downto 0);
  signal out_3   : std_logic_vector(20 downto 0);
  signal out_4   : std_logic_vector(20 downto 0);
  signal out_5   : std_logic_vector(20 downto 0);
  signal out_6   : std_logic_vector(20 downto 0);
  signal out_7   : std_logic_vector(20 downto 0);
  signal out_8   : std_logic_vector(20 downto 0);

begin

  clk_div : entity work.clock_divider
    generic map (
      g_length => 1 --500 000
    )
    port map (
      clk => clk100mhz,
      rst => btnc,
      ce  => clk_ce
    );

  deb : entity work.debouncer
    generic map (
      g_debounce => 3 -- 300 000
    )
    port map (
      clk    => clk100mhz,
      rst    => btnc,
      input  => btnd,
      output => deb_out
    );

  shift : entity work.shifter
    port map (
      clk    => clk_ce,
      rst    => btnc,
      sw     => sw0,
      input  => d14,
      output => out_a
    );

  butt_driver : entity work.button_driver
    port map (
      clk     => clk_ce,
      rst     => btnc,
      sw      => sw0,
      input   => deb_out,
      send    => btnl,
      output  => out_b,
      led17_r => led17_r,
      led17_g => led17_g,
      led17_b => led17_b
    );

  mux : entity work.mux_21bit_2to1
    port map (
      a   => out_a,
      b   => out_b,
      f   => out_mux,
      slc => sw0
    );

  mux_driv : entity work.mux_driver
    port map (
      clk     => clk100mhz,
      rst     => btnc,
      input   => out_mux,
      output1 => out_1,
      output2 => out_2,
      output3 => out_3,
      output4 => out_4,
      output5 => out_5,
      output6 => out_6,
      output7 => out_7,
      output8 => out_8
    );

  seg_driv : entity work.driver_7seg_8digits
    generic map (
      g_max => 1 --200 000
    )
    port map (
      clk   => clk100mhz,
      rst   => btnc,
      data1 => out_1,
      data2 => out_2,
      data3 => out_3,
      data4 => out_4,
      data5 => out_5,
      data6 => out_6,
      data7 => out_7,
      data8 => out_8,
      seg   => seg,
      dig   => dig
    );

  sender : entity work.signal_sender
    port map (
      clk     => clk_ce,
      rst     => btnc,
      data1   => out_1,
      data2   => out_2,
      data3   => out_3,
      data4   => out_4,
      data5   => out_5,
      data6   => out_6,
      data7   => out_7,
      data8   => out_8,
      send    => sw1,
      output  => sig_16,
      led16_r => led16_r,
      led16_g => led16_g,
      led16_b => led16_b
    );
  led_sig <= sig_16;
  e16 <= sig_16;

end architecture behavioral;
