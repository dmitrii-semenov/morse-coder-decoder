library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity tb_debouncer is
--  Port ( );
end entity tb_debouncer;

architecture testbench of tb_debouncer is

  constant c_clk_100mhz_period : time := 10 ns;

  signal rst            : std_logic;
  signal sig_clk_100mhz : std_logic;
  signal input          : std_logic;
  signal output         : std_logic;

begin

  uut_debouncer : entity work.debouncer
    port map (
      rst    => rst,
      clk    => sig_clk_100mhz,
      input  => input,
      output => output
    );

  p_clk_gen : process is
  begin

    while now < 12 us loop -- 100 periods of 100MHz clock

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

    input <= '1';
    wait for 1 us;
    input <= '0';
    wait for 5 us;
    input <= '1';
    wait for 100 ns;
    input <= '0';
    wait for 100 ns;
    input <= '1';
    wait for 100 ns;
    input <= '0';
    wait for 100 ns;
    input <= '1';
    wait for 100 ns;
    input <= '0';
    wait for 100 ns;
    input <= '1';
    wait for 5 us;
    wait;

  end process p_stimulus;

end architecture testbench;
