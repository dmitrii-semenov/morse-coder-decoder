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
    CLK100MHZ     : in    std_logic;
    D14           : in    std_logic;
    SW0           : in    std_logic;
    SW1           : in    std_logic;
    BTNL          : in    std_logic;
    BTNC          : in    std_logic;
    BTND          : in    std_logic;
    seg           : out    std_logic_vector(6 downto 0);
    dig           : out   std_logic_vector(7 downto 0);
    E16           : out    std_logic;
    LED16_R       : out    std_logic;
    LED16_G       : out    std_logic;
    LED16_B       : out    std_logic;
    LED17_R       : out    std_logic;
    LED17_G       : out    std_logic;
    LED17_B       : out    std_logic
  );
end entity top;

----------------------------------------------------------
-- Architecture declaration for display driver
----------------------------------------------------------

architecture behavioral of top is

  signal clk_ce    : std_logic;
  signal deb_out   : std_logic;
  signal out_a     : std_logic_vector(20 downto 0);
  signal out_b     : std_logic_vector(20 downto 0);
  signal out_mux   : std_logic_vector(20 downto 0);
  signal out_1     : std_logic_vector(20 downto 0);
  signal out_2     : std_logic_vector(20 downto 0);
  signal out_3     : std_logic_vector(20 downto 0);
  signal out_4     : std_logic_vector(20 downto 0);
  signal out_5     : std_logic_vector(20 downto 0);
  signal out_6     : std_logic_vector(20 downto 0);
  signal out_7     : std_logic_vector(20 downto 0);
  signal out_8     : std_logic_vector(20 downto 0);

begin

  clk_div : entity work.clock_divider
    generic map (
      g_LENGTH => 500 -- point length in ms
    )
    port map (
      clk => CLK100MHZ,
      rst => BTNC,
      ce  => clk_ce
    );

  deb : entity work.debouncer
    port map (
      clk => CLK100MHZ,
      rst => BTNC,
      input => BTND,
      output => deb_out
    );

  shift : entity work.shifter
    port map (
      clk => clk_ce,
      rst => BTNC,
      SW => SW0,
      input => D14,
      output => out_a
    );

  butt_driver : entity work.button_driver
  port map (
    clk => clk_ce,
    rst => BTNC,
    SW => SW0,
    input => deb_out,
    send => BTNL,
    output => out_b,
    LED17_R => LED17_R,
    LED17_G => LED17_G,
    LED17_B => LED17_B
  );

  mux : entity work.mux_21bit_2to1
  port map (
    a => out_a,
    b => out_b,
    f => out_mux,
    slc => SW0
  );

  mux_driv : entity work.mux_driver
  port map (
    clk => CLK100MHZ,
    rst => BTNC,
    input => out_mux,--out_mux
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
  port map (
    clk => CLK100MHZ,
    rst => BTNC,
    data1 => out_1,
    data2 => out_2,
    data3 => out_3,
    data4 => out_4,
    data5 => out_5,
    data6 => out_6,
    data7 => out_7,
    data8 => out_8,
    seg => seg,
    dig => dig
  );

  sender : entity work.signal_sender
  port map (
    clk => clk_ce,
    rst => BTNC,
    data1 => out_1,
    data2 => out_2,
    data3 => out_3,
    data4 => out_4,
    data5 => out_5,
    data6 => out_6,
    data7 => out_7,
    data8 => out_8,
    send => SW1,
    output => E16,
    LED16_R => LED16_R,
    LED16_G => LED16_G,
    LED16_B => LED16_B
  );

end architecture behavioral;