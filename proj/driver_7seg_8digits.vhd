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

entity driver_7seg_8digits is
  generic (
    g_max : natural := 2 -- 200000
  );
  port (
    clk   : in    std_logic;
    rst   : in    std_logic;
    data1 : in    std_logic_vector(20 downto 0);
    data2 : in    std_logic_vector(20 downto 0);
    data3 : in    std_logic_vector(20 downto 0);
    data4 : in    std_logic_vector(20 downto 0);
    data5 : in    std_logic_vector(20 downto 0);
    data6 : in    std_logic_vector(20 downto 0);
    data7 : in    std_logic_vector(20 downto 0);
    data8 : in    std_logic_vector(20 downto 0);
    seg   : out   std_logic_vector(6 downto 0);
    dig   : out   std_logic_vector(7 downto 0)
  );
end entity driver_7seg_8digits;

----------------------------------------------------------
-- Architecture declaration for display driver
----------------------------------------------------------

architecture behavioral of driver_7seg_8digits is

  -- Internal clock enable
  signal sig_en_2ms : std_logic;

  -- Internal 3-bit counter for multiplexing 8 digits
  signal sig_cnt_3bit : std_logic_vector(2 downto 0);

  -- Internal 8-bit value for 7-segment decoder
  signal sig_hex : std_logic_vector(20 downto 0);

begin

  --------------------------------------------------------
  -- Instance (copy) of clock_enable entity generates
  -- an enable pulse every 4 ms
  --------------------------------------------------------
  clk_en0 : entity work.clock_enable
    generic map (
      g_max => g_max
    )
    port map (
      clk => clk,
      rst => rst,
      ce  => sig_en_2ms
    );

  --------------------------------------------------------
  -- Instance (copy) of cnt_up_down entity performs
  -- a 2-bit down counter
  --------------------------------------------------------
  bin_cnt0 : entity work.cnt_up_down
    generic map (
      g_cnt_width => 3
    )
    port map (
      clk    => clk,
      rst    => rst,
      en     => sig_en_2ms,
      cnt_up => '0',
      cnt    => sig_cnt_3bit

    );

  --------------------------------------------------------
  -- Instance (copy) of hex_7seg entity performs
  -- a 7-segment display decoder
  --------------------------------------------------------
  hex2seg : entity work.hex_7seg
    port map (
      blank => rst,
      hex   => sig_hex,
      seg   => seg
    );

  --------------------------------------------------------
  -- p_mux:
  -- A sequential process that implements a multiplexer for
  -- selecting data for a single digit, a decimal point,
  -- and switches the common anodes of each display.
  --------------------------------------------------------
  p_mux : process (clk) is
  begin

    if (rising_edge(clk)) then
      if (rst = '1') then
        sig_hex <= data1;
        dig     <= "11111110";
      else

        case sig_cnt_3bit is

          when "111" =>

            sig_hex <= data8;
            dig     <= "01111111";

          when "110" =>

            sig_hex <= data7;
            dig     <= "10111111";

          when "101" =>

            sig_hex <= data6;
            dig     <= "11011111";

          when "100" =>

            sig_hex <= data5;
            dig     <= "11101111";

          when "011" =>

            sig_hex <= data4;
            dig     <= "11110111";

          when "010" =>

            sig_hex <= data3;
            dig     <= "11111011";

          when "001" =>

            sig_hex <= data2;
            dig     <= "11111101";

          when others =>

            sig_hex <= data1;
            dig     <= "11111110";

        end case;

      end if;
    end if;

  end process p_mux;

end architecture behavioral;
