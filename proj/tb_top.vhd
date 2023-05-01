
library ieee;
  use ieee.std_logic_1164.all;

----------------------------------------------------------
-- Entity declaration for testbench
----------------------------------------------------------

entity tb_top is
-- Entity of testbench is always empty
end entity tb_top;

----------------------------------------------------------
-- Architecture body for testbench
----------------------------------------------------------

architecture testbench of tb_top is

  -- Testbench local constants
  constant c_clk_100mhz_period : time := 10 ns;

  -- Testench local signals
  signal clk100mhz : std_logic;
  signal d14       : std_logic;
  signal sw0       : std_logic;
  signal sw1       : std_logic;
  signal btnl      : std_logic;
  signal btnc      : std_logic;
  signal btnd      : std_logic;
  signal seg       : std_logic_vector(6 downto 0);
  signal dig       : std_logic_vector(7 downto 0);
  signal e16       : std_logic;
  signal led16_r   : std_logic;
  signal led16_g   : std_logic;
  signal led16_b   : std_logic;
  signal led17_r   : std_logic;
  signal led17_g   : std_logic;
  signal led17_b   : std_logic;
  signal led_sig   : std_logic;

begin

  -- Connecting testbench signals with driver_7seg_8digits
  -- entity (Unit Under Test)
  uut_top : entity work.top
    port map (
      clk100mhz => clk100mhz,
      d14       => d14,
      sw0       => sw0,
      sw1       => sw1,
      btnl      => btnl,
      btnc      => btnc,
      btnd      => btnd,
      seg       => seg,
      dig       => dig,
      e16       => e16,
      led16_r   => led16_r,
      led16_g   => led16_g,
      led16_b   => led16_b,
      led17_r   => led17_r,
      led17_g   => led17_g,
      led17_b   => led17_b,
      led_sig   => led_sig
    );

  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 600 us loop

      clk100mhz <= '0';
      wait for c_clk_100mhz_period / 2;
      clk100mhz <= '1';
      wait for c_clk_100mhz_period / 2;

    end loop;

    wait;

  end process p_clk_gen;

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    sw0  <= '0';
    sw1  <= '0';
    btnl <= '0';
    d14  <= '0';
    btnd <= '0';
    btnc <= '0';
    wait for 2 us;
    btnc <= '1';
    wait for 5 us;
    btnc <= '0';
    wait for 3 us;
    ------------------------------------------------------------------------
    -- Generation process in mode 0 that is receiving signal from arduino --
    ------------------------------------------------------------------------
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 3 us;   -- End of letter "D"

    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 3 us;   -- End of letter "I"

    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 3 us;   -- End of letter "M"

    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 3 us;   -- End of letter "A"

    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 3 us;   -- End of number "4"

    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 3 us;   -- End of number "0"

    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 3 us;   -- End of number "7"

    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 1 us;
    d14 <= '0';
    wait for 1 us;
    d14 <= '1';
    wait for 3 us;
    d14 <= '0';
    wait for 3 us;   -- End of letter "Q"
    wait for 10 us;
    sw1 <= '1';      -- Send signal
    wait for 120 us;
    sw1 <= '0';

    btnc <= '1';     -- Reset between two modes--
    wait for 5 us;
    btnc <= '0';
    wait for 5 us;
    ------------------------------------------------------------------------------
    -- Generation process in mode 1 that is sending signal controlled by button --
    ------------------------------------------------------------------------------
    sw0 <= '1';
    wait for 5 us;

    btnd <= '0';
    wait for 2 us;

    btnd <= '1';
    wait for 5 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 2 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 1 us;
    btnd <= '0';
    wait for 6 us;
    btnl <= '1';
    wait for 1 us;   -- end of letter "D"
    btnl <= '0';
    wait for 5 us;
    btnl <= '0';
    btnd <= '1';
    wait for 2 us;
    btnd <= '0';
    wait for 1 us;
    btnd <= '1';
    wait for 1.5 us;
    btnd <= '0';
    wait for 6 us;
    btnl <= '1';
    wait for 1 us;   -- end of letter "I"
    btnl <= '0';
    wait for 5 us;

    btnl <= '0';
    btnd <= '1';
    wait for 4 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 3.5 us;
    btnd <= '0';
    wait for 6 us;
    btnl <= '1';
    wait for 1 us;   -- end of letter "M"
    btnl <= '0';
    wait for 5 us;

    btnl <= '0';
    btnd <= '1';
    wait for 2.3 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 3.5 us;
    btnd <= '0';
    wait for 6 us;
    btnl <= '1';
    wait for 1 us;   -- end of letter "A"
    btnl <= '0';
    wait for 5 us;

    btnl <= '0';
    btnd <= '1';
    wait for 1.3 us;
    btnd <= '0';
    wait for 1.5 us;
    btnd <= '1';
    wait for 2.2 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 1.5 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 2.1 us;
    btnd <= '0';
    wait for 1.4 us;
    btnd <= '1';
    wait for 3.8 us;
    btnd <= '0';
    wait for 6 us;
    btnl <= '1';
    wait for 1 us;   -- end of number "4"
    btnl <= '0';
    wait for 5 us;

    btnl <= '0';
    btnd <= '1';
    wait for 3 us;
    btnd <= '0';
    wait for 1.5 us;
    btnd <= '1';
    wait for 4.5 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 5 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 4 us;
    btnd <= '0';
    wait for 1.4 us;
    btnd <= '1';
    wait for 3.8 us;
    btnd <= '0';
    wait for 6 us;
    btnl <= '1';
    wait for 1 us;   -- end of number "0"
    btnl <= '0';
    wait for 5 us;

    btnl <= '0';
    btnd <= '1';
    wait for 4 us;
    btnd <= '0';
    wait for 1.5 us;
    btnd <= '1';
    wait for 5 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 1.5 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 1 us;
    btnd <= '0';
    wait for 1.4 us;
    btnd <= '1';
    wait for 2.4 us;
    btnd <= '0';
    wait for 6 us;
    btnl <= '1';
    wait for 1 us;   -- end of number "7"
    btnl <= '0';
    wait for 5 us;

    btnl <= '0';
    btnd <= '1';
    wait for 4 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 4 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 1.5 us;
    btnd <= '0';
    wait for 2 us;
    btnd <= '1';
    wait for 4 us;
    btnd <= '0';
    wait for 6 us;
    btnl <= '1';
    wait for 1 us;   -- end of letter "Q"
    btnl <= '0';
    wait for 5 us;
    wait;

  end process p_stimulus;

end architecture testbench;

