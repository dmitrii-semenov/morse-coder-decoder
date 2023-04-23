library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity tb_mux_driver is
--  Port ( );
end entity tb_mux_driver;

architecture testbench of tb_mux_driver is

  constant c_clk_100mhz_period : time := 10 ns;

  signal rst            : std_logic;
  signal sig_clk_100mhz : std_logic;
  signal input          : std_logic_vector(20 downto 0);
  signal output1        : std_logic_vector(20 downto 0);
  signal output2        : std_logic_vector(20 downto 0);
  signal output3        : std_logic_vector(20 downto 0);
  signal output4        : std_logic_vector(20 downto 0);
  signal output5        : std_logic_vector(20 downto 0);
  signal output6        : std_logic_vector(20 downto 0);
  signal output7        : std_logic_vector(20 downto 0);
  signal output8        : std_logic_vector(20 downto 0);

begin

  uut_mux_driver : entity work.mux_driver
    port map (
      rst     => rst,
      clk     => sig_clk_100mhz,
      input   => input,
      output1 => output1,
      output2 => output2,
      output3 => output3,
      output4 => output4,
      output5 => output5,
      output6 => output6,
      output7 => output7,
      output8 => output8
    );

  p_clk_gen : process is
  begin

    while now < 1000 ns loop -- 100 periods of 100MHz clock

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

    input <= "111000000000000000111";
    wait for 50 ns;
    input <= "111000000000000000000";
    wait for 200 ns;
    input <= "111000000000000111111";
    wait for 100 ns;
    input <= "111000000000111000111";
    wait for 100 ns;
    input <= "111000000000111111111";
    wait for 100 ns;
    input <= "111000000111000000111";
    wait for 100 ns;
    input <= "111000000111111000111";
    wait for 100 ns;
    input <= "111000111000000000111";
    wait for 100 ns;
    input <= "111000111000111000111";
    wait for 100 ns;
    wait;

  end process p_stimulus;

end architecture testbench;
