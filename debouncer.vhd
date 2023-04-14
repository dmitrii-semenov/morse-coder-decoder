library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity debouncer is
    port(
    clk         : in  std_logic;
    rst         : in  std_logic;
    input       : in  std_logic;
    output      : out  std_logic
    );
end entity debouncer;

architecture Behavioral of debouncer is
    signal one_cnt : integer := 0;
    signal zero_cnt : integer := 0;
    begin
        p_debouncer : process (clk,input) is
            begin
                if (rst = '1') then
                    output <= '0';
                    one_cnt <= 0;
                    zero_cnt <= 0;
                elsif rising_edge(clk) then
                    if (input = '0') then
                        zero_cnt <= zero_cnt + 1;
                        one_cnt <= 0;
                    end if;
                    if (input = '1') then
                        one_cnt <= one_cnt + 1;
                        zero_cnt <= 0;
                    end if;
                    if (one_cnt >= 300000) then
                        output <= '1';
                    elsif (zero_cnt >= 300000) then
                        output <= '0';
                    end if;
                end if;
            end process p_debouncer;
    end architecture Behavioral;