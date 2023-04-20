----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2023 02:05:36 PM
-- Design Name: 
-- Module Name: mux_3bit_4to1 - Behavioral
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

entity mux_21bit_2to1 is
    port(
        b           : in  std_logic_vector(20 downto 0);
        a           : in  std_logic_vector(20 downto 0);
        slc         : in  std_logic;
        f           : out std_logic_vector(20 downto 0)
    );
end mux_21bit_2to1;

architecture Behavioral of mux_21bit_2to1 is
begin
    f <= a when (slc = '0') else
         b;
end Behavioral;
