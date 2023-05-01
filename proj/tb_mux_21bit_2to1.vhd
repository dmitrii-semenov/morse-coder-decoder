library ieee;
  use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity tb_mux_21bit_2to1 is
--  Port ( );
end entity tb_mux_21bit_2to1;

architecture testbench of tb_mux_21bit_2to1 is

  signal s_a   : std_logic_vector(20 downto 0);
  signal s_b   : std_logic_vector(20 downto 0);
  signal s_slc : std_logic;
  signal s_f   : std_logic_vector(20 downto 0);

begin

  uut_mux_21bit_2to1 : entity work.mux_21bit_2to1
    port map (
      a   => s_a,
      b   => s_b,
      slc => s_slc,
      f   => s_f
    );

  p_stimulus : process is
  begin

    s_a   <= "100100100100100100100";
    s_b   <= "101101101101101101101";
    s_slc <= '0';
    wait for 100 ns;
    s_slc <= '1';
    wait for 100 ns;
    wait;

  end process p_stimulus;

end architecture testbench;
