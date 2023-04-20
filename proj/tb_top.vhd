
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
  constant c_CLK_100MHZ_PERIOD : time := 10 ns;

  -- Testench local signals
  signal CLK100MHZ     : std_logic;
  signal D14           : std_logic;
  signal SW0           : std_logic;
  signal SW1           : std_logic;
  signal BTNL          : std_logic;
  signal BTNC          : std_logic;
  signal BTND          : std_logic;
  signal seg           : std_logic_vector(6 downto 0);
  signal dig           : std_logic_vector(7 downto 0);
  signal E16           : std_logic;
  signal LED16_R       : std_logic;
  signal LED16_G       : std_logic;
  signal LED16_B       : std_logic;
  signal LED17_R       : std_logic;
  signal LED17_G       : std_logic;
  signal LED17_B       : std_logic;

begin

  -- Connecting testbench signals with driver_7seg_8digits
  -- entity (Unit Under Test)
  uut_top : entity work.top
    port map (
      CLK100MHZ     => CLK100MHZ,
      D14     => D14,
      SW0   => SW0,
      SW1   => SW1,
      BTNL   => BTNL,
      BTNC   => BTNC,
      BTND   => BTND,
      seg   => seg,
      dig     => dig,
      E16   => E16,
      LED16_R   => LED16_R,
      LED16_G   => LED16_G,
      LED16_B   => LED16_B,
      LED17_R   => LED17_R,
      LED17_G   => LED17_G,
      LED17_B   => LED17_B
    );

  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 600 ms loop -- 40 periods of 100MHz clock

      CLK100MHZ <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      CLK100MHZ <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;
    wait;

  end process p_clk_gen;

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
    begin
      SW0 <= '0';
      SW1 <= '0';
      BTNL <= '0';
      D14 <= '0';
      BTND <= '0';
      BTNC <= '0';
      wait for 2 ms;
      BTNC <= '1';
      wait for 5 ms;
      BTNC <= '0';
      wait for 3 ms;
      ------------------------------------------------------------------------
      -- Generation process in mode 0 that is receiving signal from arduino --
      ------------------------------------------------------------------------
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 3 ms; -- End of letter "D"
  
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 3 ms; -- End of letter "I"
  
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 3 ms; -- End of letter "M"
  
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 3 ms; -- End of letter "A"
  
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 3 ms; -- End of number "4"
  
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 3 ms; -- End of number "0"
  
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 3 ms; -- End of number "7"
  
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 1 ms;
      D14 <= '0';
      wait for 1 ms;
      D14 <= '1';
      wait for 3 ms;
      D14 <= '0';
      wait for 3 ms; -- End of letter "Q"
      wait for 10 ms;
      SW1 <= '1'; -- Send signal
      wait for 120 ms;
      SW1 <= '0';
  
      BTNC <= '1'; --Reset between two modes--
      wait for 5 ms;
      BTNC <= '0';
      wait for 5 ms;
      ------------------------------------------------------------------------------
      -- Generation process in mode 1 that is sending signal controlled by button --
      ------------------------------------------------------------------------------
      SW0 <= '1';  
      wait for 5 ms;
  
      BTND <= '0';
      wait for 2 ms; 
  
      BTND <= '1';
      wait for 5 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 2 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 1 ms;
      BTND <= '0';
      wait for 6 ms;
      BTNL <= '1';
      wait for 1 ms; -- end of letter "D"
      BTNL <= '0';
      wait for 5 ms;
  
      BTNL <= '0';
      BTND <= '1';
      wait for 2 ms;
      BTND <= '0';
      wait for 1 ms;
      BTND <= '1';
      wait for 1.5 ms;
      BTND <= '0';
      wait for 6 ms;
      BTNL <= '1';
      wait for 1 ms; -- end of letter "I"
      BTNL <= '0';
      wait for 5 ms;
  
      BTNL <= '0';
      BTND <= '1';
      wait for 4 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 3.5 ms;
      BTND <= '0';
      wait for 6 ms;
      BTNL <= '1';
      wait for 1 ms; -- end of letter "M"
      BTNL <= '0';
      wait for 5 ms;
  
      BTNL <= '0';
      BTND <= '1';
      wait for 2.3 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 3.5 ms;
      BTND <= '0';
      wait for 6 ms;
      BTNL <= '1';
      wait for 1 ms; -- end of letter "A"
      BTNL <= '0';
      wait for 5 ms;
  
      BTNL <= '0';
      BTND <= '1';
      wait for 1.3 ms;
      BTND <= '0';
      wait for 1.5 ms;
      BTND <= '1';
      wait for 2.2 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 1.5 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 2.1 ms;
      BTND <= '0';
      wait for 1.4 ms;
      BTND <= '1';
      wait for 3.8 ms;
      BTND <= '0';
      wait for 6 ms;
      BTNL <= '1';
      wait for 1 ms; -- end of number "4"
      BTNL <= '0';
      wait for 5 ms;
  
      BTNL <= '0';
      BTND <= '1';
      wait for 3 ms;
      BTND <= '0';
      wait for 1.5 ms;
      BTND <= '1';
      wait for 4.5 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 5 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 4 ms;
      BTND <= '0';
      wait for 1.4 ms;
      BTND <= '1';
      wait for 3.8 ms;
      BTND <= '0';
      wait for 6 ms;
      BTNL <= '1';
      wait for 1 ms; -- end of number "0"
      BTNL <= '0';
      wait for 5 ms;
  
      BTNL <= '0';
      BTND <= '1';
      wait for 4 ms;
      BTND <= '0';
      wait for 1.5 ms;
      BTND <= '1';
      wait for 5 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 1.5 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 1 ms;
      BTND <= '0';
      wait for 1.4 ms;
      BTND <= '1';
      wait for 2.4 ms;
      BTND <= '0';
      wait for 6 ms;
      BTNL <= '1';
      wait for 1 ms; -- end of number "7"
      BTNL <= '0';
      wait for 5 ms;
  
      BTNL <= '0';
      BTND <= '1';
      wait for 4 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 4 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 1.5 ms;
      BTND <= '0';
      wait for 2 ms;
      BTND <= '1';
      wait for 4 ms;
      BTND <= '0';
      wait for 6 ms;
      BTNL <= '1';
      wait for 1 ms; -- end of letter "Q"
      BTNL <= '0';
      wait for 5 ms;
      wait;
  
    end process p_stimulus;
  
  end architecture testbench;
  