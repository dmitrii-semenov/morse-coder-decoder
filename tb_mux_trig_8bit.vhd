library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity tb_mux_trig_8bit is
--  Port ( );
end tb_mux_trig_8bit;

architecture testbench of tb_mux_trig_8bit is
    signal rst         : std_logic;
    signal indat       : std_logic_vector(7 downto 0);
    signal control     : std_logic;
    signal data0       : std_logic_vector(7 downto 0);
    signal data1       : std_logic_vector(7 downto 0);
    signal data2       : std_logic_vector(7 downto 0);
    signal data3       : std_logic_vector(7 downto 0);
    signal data4       : std_logic_vector(7 downto 0);
    signal data5       : std_logic_vector(7 downto 0);
    signal data6       : std_logic_vector(7 downto 0);
    signal data7       : std_logic_vector(7 downto 0);

begin
    uut_mux_trig_8bit: entity work.mux_trig_8bit
        port map(
            rst       => rst,
            indat     => indat,
            control   => control,
            data0     => data0,
            data1     => data1,
            data2     => data2,
            data3     => data3,
            data4     => data4,
            data5     => data5,
            data6     => data6,
            data7     => data7
        );
        
    p_stimulus : process
    begin
    	data0 <= "10100100"; -- Set - on 1 segment of display
		data1 <= "10100100"; -- Set - on 2 segment of display
    	data2 <= "10100100"; -- Set - on 3 segment of display
    	data3 <= "10100100"; -- Set - on 4 segment of display
    	data4 <= "10100100"; -- Set - on 5 segment of display
    	data5 <= "10100100"; -- Set - on 6 segment of display
    	data6 <= "10100100"; -- Set - on 7 segment of display
    	data7 <= "10100100"; -- Set - on 8 segment of display
        rst <= '1';
        control <= '0';
        wait for 10 ns;
        rst <= '0';
        indat <= "00000000"; -- Input value
        wait for 10 ns;
        control <= '1';
        indat <= "00000001"; -- Input value
        wait for 10 ns;
        control <= '0';
        indat <= "00000010"; -- Input value
        wait for 10 ns;
        control <= '1';
        indat <= "00000011"; -- Input value
        wait for 10 ns;
        control <= '0';
        indat <= "00000100"; -- Input value
        wait for 10 ns;
        control <= '1';
        indat <= "00000101"; -- Input value
        wait for 10 ns;
        control <= '0';
        indat <= "00000110"; -- Input value
        wait;
    end process p_stimulus;
end architecture testbench;