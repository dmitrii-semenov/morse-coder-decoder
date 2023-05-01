library ieee;
  use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity mux_21bit_2to1 is
  port (
    b   : in    std_logic_vector(20 downto 0);
    a   : in    std_logic_vector(20 downto 0);
    slc : in    std_logic;
    f   : out   std_logic_vector(20 downto 0)
  );
end entity mux_21bit_2to1;

architecture behavioral of mux_21bit_2to1 is

begin

  f <= a when (slc = '0') else
       b;

end architecture behavioral;
