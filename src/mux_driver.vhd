library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity mux_driver is
    port(
    clk         : in  std_logic;
    rst         : in  std_logic;
    input       : in  std_logic_vector(20 downto 0);
    output1      : out  std_logic_vector(20 downto 0);
    output2      : out  std_logic_vector(20 downto 0);
    output3      : out  std_logic_vector(20 downto 0);
    output4      : out  std_logic_vector(20 downto 0);
    output5      : out  std_logic_vector(20 downto 0);
    output6      : out  std_logic_vector(20 downto 0);
    output7      : out  std_logic_vector(20 downto 0);
    output8      : out  std_logic_vector(20 downto 0)
    );
end entity mux_driver;

architecture Behavioral of mux_driver is
    signal sig_control : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal sig_1 : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal sig_2 : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal sig_3 : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal sig_4 : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal sig_5 : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal sig_6 : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal sig_7 : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal sig_8 : std_logic_vector(20 downto 0) := "000000000000000000000";
    begin
        p_mux_driver : process (clk,input) is
            begin
                if rising_edge(clk) then
                    if (rst = '1') then
                        output1 <= "000000000000000000000";
                        output2 <= "000000000000000000000";
                        output3 <= "000000000000000000000";
                        output4 <= "000000000000000000000";
                        output5 <= "000000000000000000000";
                        output6 <= "000000000000000000000";
                        output7 <= "000000000000000000000";
                        output8 <= "000000000000000000000";
                        sig_1   <= "000000000000000000000";
                        sig_2   <= "000000000000000000000";
                        sig_3   <= "000000000000000000000";
                        sig_4   <= "000000000000000000000";
                        sig_5   <= "000000000000000000000";
                        sig_6   <= "000000000000000000000";
                        sig_7   <= "000000000000000000000";
                    elsif input /= sig_control then
                            sig_8 <= sig_7;
                            sig_7 <= sig_6;
                            sig_6 <= sig_5;
                            sig_5 <= sig_4;
                            sig_4 <= sig_3;
                            sig_3 <= sig_2;
                            sig_2 <= sig_1;
                            sig_1 <= input;
                            output1 <= input;
                            output2 <= sig_1;
                            output3 <= sig_2;
                            output4 <= sig_3;
                            output5 <= sig_4;
                            output6 <= sig_5;
                            output7 <= sig_6;
                            output8 <= sig_7;
                            sig_control <= input;
                    end if;
                end if;
            end process p_mux_driver;
    end architecture Behavioral;