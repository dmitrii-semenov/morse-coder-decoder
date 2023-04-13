----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2023 13:19:23
-- Design Name: 
-- Module Name: hex_7seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hex_7seg is
    Port ( blank : in STD_LOGIC;
           hex : in STD_LOGIC_VECTOR (7 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end hex_7seg;

architecture Behavioral of hex_7seg is

begin

  --------------------------------------------------------
  -- p_7seg_decoder:
  -- A combinational process for 7-segment display (Common
  -- Anode) decoder. Any time "hex" or "blank" is changed,
  -- the process is "executed". Output pin seg(6) controls
  -- segment A, seg(5) segment B, etc.
  --     segment A
  --      | segment B
  --      |  | segment C
  --      +-+|  |   ...   segment G
  --        ||+-+          |
  --        |||            |
  -- seg = "0000001"-------+
  --
  -- Display is clear/blank if signal blank = 1.
  --------------------------------------------------------

  p_7seg_decoder : process (blank, hex) is

  begin
    if (blank = '1') then
      seg <= "1111111";     -- Blanking display
    else

      case hex is
        when "10000111" =>
          seg <= "0001000"; -- A
          
        when "11001001" =>
          seg <= "1100000"; -- B
          
        when "11010010" =>
          seg <= "0110001"; -- C
          
        when "11000110" =>
          seg <= "1000010"; -- D
          
        when "01010001" =>
          seg <= "0110000"; -- E
         
         when "10000001" =>
          seg <= "0111000"; -- F
          
         when "11100001" =>
          seg <= "0100001"; -- G
          
         when "01111000" =>
          seg <= "1101000"; -- H
         
         when "01101100" =>
          seg <= "1001111"; -- I
         
         when "10011111" =>
          seg <= "1000011"; -- J
          
         when "11001111" =>
          seg <= "0101000"; -- K
          
         when "10010011" =>
          seg <= "1110001"; -- L
          
         when "11011000" =>
          seg <= "0101011"; -- M
          
         when "10111101" =>
          seg <= "1101010"; -- N
          
         when "11101010" =>
          seg <= "1100010"; -- O
         
         when "10011100" =>
          seg <= "0011000"; -- P
          
         when "11100111" =>
          seg <= "0001100"; -- Q
          
         when "10010000" =>
          seg <= "1111010"; -- R
          
         when "01110101" =>
          seg <= "0100101"; -- S
          
         when "10100010" =>
          seg <= "1110000"; -- T
         
         when "01111110" =>
          seg <= "1000001"; -- U
          
         when "01111011" =>
          seg <= "1100011"; -- V
          
         when "10011001" =>
          seg <= "1010101"; -- W
          
         when "11001100" =>
          seg <= "1001000"; -- X
          
         when "11010101" =>
          seg <= "1000100"; -- Y
          
         when "11100100" =>
          seg <= "0010011"; -- Z
          
         when "10100001" =>
          seg <= "1111001"; -- 1
          
         when "10000110" =>
          seg <= "0010010"; -- 2
         
         when "01111101" =>
          seg <= "0000110"; -- 3
          
         when "01111010" =>
          seg <= "1001100"; -- 4
         
         when "01111001" =>
          seg <= "0100100"; -- 5
          
         when "11001010" =>
          seg <= "0100000"; -- 6
          
         when "11100101" =>
          seg <= "0001111"; -- 7
          
         when "11101110" =>
          seg <= "0000000"; -- 8
          
         when "11110001" =>
          seg <= "0000100"; -- 9
          
         when "11110010" =>
          seg <= "0000001"; -- 0
          
         when "10100100" =>
          seg <= "1111110"; -- -

      end case;

    end if;

  end process p_7seg_decoder;

end Behavioral;
