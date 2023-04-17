
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hex_7seg is
    Port ( blank : in STD_LOGIC;
           hex : in STD_LOGIC_VECTOR (9 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end hex_7seg;

architecture Behavioral of hex_7seg is

begin

  p_7seg_decoder : process (blank, hex) is

  begin
    if (blank = '1') then
      seg <= "1111111";     -- Blanking display
    else

      case hex is
        when "0000000111" =>
          seg <= "0001000"; -- A
          
        when "0011010101" =>
          seg <= "1100000"; -- B
          
        when "0011011101" =>
          seg <= "0110001"; -- C
          
        when "0000110101" =>
          seg <= "1000010"; -- D
          
        when "0000000001" =>
          seg <= "0110000"; -- E
         
         when "0001011101" =>
          seg <= "0111000"; -- F
          
         when "0000111101" =>
          seg <= "0100001"; -- G
          
         when "0001010101" =>
          seg <= "1101000"; -- H
         
         when "0000000101" =>
          seg <= "1001111"; -- I
         
         when "0001111111" =>
          seg <= "1000011"; -- J
          
         when "0000110111" =>
          seg <= "0101000"; -- K
          
         when "0001110101" =>
          seg <= "1110001"; -- L
          
         when "0000001111" =>
          seg <= "0101011"; -- M
          
         when "0000001101" =>
          seg <= "1101010"; -- N
          
         when "0000111111" =>
          seg <= "1100010"; -- O
         
         when "0001111101" =>
          seg <= "0011000"; -- P
          
         when "0011110111" =>
          seg <= "0001100"; -- Q
          
         when "0000011101" =>
          seg <= "1111010"; -- R
          
         when "0000010101" =>
          seg <= "0100101"; -- S
          
         when "0000000011" =>
          seg <= "1110000"; -- T
         
         when "0000010111" =>
          seg <= "1000001"; -- U
          
         when "0001010111" =>
          seg <= "1100011"; -- V
          
         when "0000011111" =>
          seg <= "1010101"; -- W
          
         when "0011010111" =>
          seg <= "1001000"; -- X
          
         when "0011011111" =>
          seg <= "1000100"; -- Y
          
         when "0011110101" =>
          seg <= "0010011"; -- Z
          
         when "0111111111" =>
          seg <= "1111001"; -- 1
          
         when "0101111111" =>
          seg <= "0010010"; -- 2
         
         when "0101011111" =>
          seg <= "0000110"; -- 3
          
         when "0101010111" =>
          seg <= "1001100"; -- 4
         
         when "0101010101" =>
          seg <= "0100100"; -- 5
          
         when "1101010101" =>
          seg <= "0100000"; -- 6
          
         when "1111010101" =>
          seg <= "0001111"; -- 7
          
         when "1111110101" =>
          seg <= "0000000"; -- 8
          
         when "1111111101" =>
          seg <= "0000100"; -- 9
          
         when "1111111111" =>
          seg <= "0000001"; -- 0
          
         when "0000000000" =>
          seg <= "1111111";  
          
         when others =>

          seg <= "1111110"; -- -

      end case;

    end if;

  end process p_7seg_decoder;

end Behavioral;
