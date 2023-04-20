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
           hex : in STD_LOGIC_VECTOR (20 downto 0);
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
        when "000000000000000101110" =>
          seg <= "0001000"; -- A
          
        when "000000000001110101010" =>
          seg <= "1100000"; -- B
          
        when "000000000111010111010" =>
          seg <= "0110001"; -- C
          
        when "000000000000011101010" =>
          seg <= "1000010"; -- D
          
        when "000000000000000000010" =>
          seg <= "0110000"; -- E
         
         when "000000000001010111010" =>
          seg <= "0111000"; -- F
          
         when "000000000001110111010" =>
          seg <= "0100001"; -- G
          
         when "000000000000010101010" =>
          seg <= "1101000"; -- H
         
         when "000000000000000001010" =>
          seg <= "1001111"; -- I
         
         when "000000010111011101110" =>
          seg <= "1000011"; -- J
          
         when "000000000001110101110" =>
          seg <= "0101000"; -- K
          
         when "000000000001011101010" =>
          seg <= "1110001"; -- L
          
         when "000000000000011101110" =>
          seg <= "0101011"; -- M
          
         when "000000000000000111010" =>
          seg <= "1101010"; -- N
          
         when "000000000111011101110" =>
          seg <= "1100010"; -- O
         
         when "000000000101110111010" =>
          seg <= "0011000"; -- P
          
         when "000000011101110101110" =>
          seg <= "0001100"; -- Q
          
         when "000000000000010111010" =>
          seg <= "1111010"; -- R
          
         when "000000000000000101010" =>
          seg <= "0100101"; -- S
          
         when "000000000000000001110" =>
          seg <= "1110000"; -- T
         
         when "000000000000010101110" =>
          seg <= "1000001"; -- U
          
         when "000000000001010101110" =>
          seg <= "1100011"; -- V
          
         when "000000000001011101110" =>
          seg <= "1010101"; -- W
          
         when "000000000111010101110" =>
          seg <= "1001000"; -- X
          
         when "000000011101011101110" =>
          seg <= "1000100"; -- Y
          
         when "000000000111011101010" =>
          seg <= "0010011"; -- Z
          
         when "000101110111011101110" =>
          seg <= "1111001"; -- 1
          
         when "000001010111011101110" =>
          seg <= "0010010"; -- 2
         
         when "000000010101011101110" =>
          seg <= "0000110"; -- 3
          
         when "000000000101010101110" =>
          seg <= "1001100"; -- 4
         
         when "000000000001010101010" =>
          seg <= "0100100"; -- 5
          
         when "000000000111010101010" =>
          seg <= "0100000"; -- 6
          
         when "000000011101110101010" =>
          seg <= "0001111"; -- 7
          
         when "000001110111011101010" =>
          seg <= "0000000"; -- 8
          
         when "000111011101110111010" =>
          seg <= "0000100"; -- 9
          
         when "011101110111011101110" =>
          seg <= "0000001"; -- 0
          
         when "000000000000000000000" =>
          seg <= "1111111";  
          
         when others =>

          seg <= "1111110"; -- -

      end case;

    end if;

  end process p_7seg_decoder;

end Behavioral;
