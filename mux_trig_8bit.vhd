library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity mux_trig_8bit is
    port(
        rst         : in  std_logic;
        indat       : in  std_logic_vector(7 downto 0);
        control     : in  std_logic;
        data0       : out  std_logic_vector(7 downto 0);
        data1       : out  std_logic_vector(7 downto 0);
        data2       : out  std_logic_vector(7 downto 0);
        data3       : out  std_logic_vector(7 downto 0);
        data4       : out  std_logic_vector(7 downto 0);
        data5       : out  std_logic_vector(7 downto 0);
        data6       : out  std_logic_vector(7 downto 0);
        data7       : out  std_logic_vector(7 downto 0)
    );
end entity mux_trig_8bit;

architecture Behavioral of mux_trig_8bit is
signal data0_i : std_logic_vector(7 downto 0);
signal data1_i : std_logic_vector(7 downto 0);
signal data2_i : std_logic_vector(7 downto 0);
signal data3_i : std_logic_vector(7 downto 0);
signal data4_i : std_logic_vector(7 downto 0);
signal data5_i : std_logic_vector(7 downto 0);
signal data6_i : std_logic_vector(7 downto 0);
signal data7_i : std_logic_vector(7 downto 0);
begin
data0 <= data0_i;
data1 <= data1_i;
data2 <= data2_i;
data3 <= data3_i;
data4 <= data4_i;
data5 <= data5_i;
data6 <= data6_i;
data7 <= data7_i;
    data0_i <= "10100100"; -- Set - on 1 segment of display
    data1_i <= "10100100"; -- Set - on 2 segment of display
    data2_i <= "10100100"; -- Set - on 3 segment of display
    data3_i <= "10100100"; -- Set - on 4 segment of display
    data4_i <= "10100100"; -- Set - on 5 segment of display
    data5_i <= "10100100"; -- Set - on 6 segment of display
    data6_i <= "10100100"; -- Set - on 7 segment of display
    data7_i <= "10100100"; -- Set - on 8 segment of display

    p_mux_trig_8bit : process is
    begin
        if (rst = '1') then
            data0_i <= "10100100"; -- Set - on 1 segment of display
            data1_i <= "10100100"; -- Set - on 2 segment of display
            data2_i <= "10100100"; -- Set - on 3 segment of display
            data3_i <= "10100100"; -- Set - on 4 segment of display
            data4_i <= "10100100"; -- Set - on 5 segment of display
            data5_i <= "10100100"; -- Set - on 6 segment of display
            data6_i <= "10100100"; -- Set - on 7 segment of display
            data7_i <= "10100100"; -- Set - on 8 segment of display
    --    else
    --        if rising_edge(control) then
    --            data7_i <= data6_i; 
    --            data6_i <= data5_i; 
    --            data5_i <= data4_i; 
    --            data4_i <= data3_i; 
    --            data3_i <= data2_i; 
    --            data2_i <= data1_i; 
    --            data1_i <= data0_i; 
    --            data0_i <= indat;
    --        end if;
        end if;
    end process p_mux_trig_8bit;
end architecture Behavioral;
