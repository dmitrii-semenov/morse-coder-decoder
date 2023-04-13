library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity shifter is
    port(
    clk         : in  std_logic;
    rst         : in  std_logic;
    input       : in  std_logic;
    output      : out  std_logic_vector(20 downto 0)
    );
end entity shifter;

architecture Behavioral of shifter is
    signal sig_out : std_logic_vector(20 downto 0);
    signal sig_cnt : integer := 0;
    signal zero_cnt : integer := 0;
    begin
        p_shifter : process (clk,input) is
            begin
                if (rst = '1') then
                    sig_out <= "000000000000000000000";
                    output <= (others => '0');
                    sig_cnt <= 0;
                    zero_cnt <= 0;
                elsif rising_edge(clk) then
                    if (input = '0') then
                        zero_cnt <= zero_cnt + 1;
                    end if;
                    if (zero_cnt = 2) then
                        output <= sig_out;
                        sig_out <= "000000000000000000000";
                        sig_cnt <= 0;
                    end if;
                    if (input = '1') then
                        zero_cnt <= 0;

                        sig_out(20) <= sig_out(19);
                        sig_out(19) <= sig_out(18);
                        sig_out(18) <= sig_out(17);
                        sig_out(17) <= sig_out(16);
                        sig_out(16) <= sig_out(15);
                        sig_out(15) <= sig_out(14);
                        sig_out(14) <= sig_out(13);
                        sig_out(13) <= sig_out(12);
                        sig_out(12) <= sig_out(11);
                        sig_out(11) <= sig_out(10);
                        sig_out(10) <= sig_out(9);
                        sig_out(9) <= sig_out(8);
                        sig_out(8) <= sig_out(7);
                        sig_out(7) <= sig_out(6);
                        sig_out(6) <= sig_out(5);
                        sig_out(5) <= sig_out(4);
                        sig_out(4) <= sig_out(3);
                        sig_out(3) <= sig_out(2);
                        sig_out(2) <= sig_out(1);
                        sig_out(1) <= sig_out(0);
                        sig_out(0) <= input;
                        sig_cnt <= sig_cnt + 1;
                        if (sig_cnt = 20) then
                            output <= sig_out;
                            sig_out <= "000000000000000000000";
                            sig_cnt <= 0;
                        end if;

                    end if;
                    if (zero_cnt < 1) then
                        sig_out(20) <= sig_out(19);
                        sig_out(19) <= sig_out(18);
                        sig_out(18) <= sig_out(17);
                        sig_out(17) <= sig_out(16);
                        sig_out(16) <= sig_out(15);
                        sig_out(15) <= sig_out(14);
                        sig_out(14) <= sig_out(13);
                        sig_out(13) <= sig_out(12);
                        sig_out(12) <= sig_out(11);
                        sig_out(11) <= sig_out(10);
                        sig_out(10) <= sig_out(9);
                        sig_out(9) <= sig_out(8);
                        sig_out(8) <= sig_out(7);
                        sig_out(7) <= sig_out(6);
                        sig_out(6) <= sig_out(5);
                        sig_out(5) <= sig_out(4);
                        sig_out(4) <= sig_out(3);
                        sig_out(3) <= sig_out(2);
                        sig_out(2) <= sig_out(1);
                        sig_out(1) <= sig_out(0);
                        sig_out(0) <= input;
                        sig_cnt <= sig_cnt + 1;
                        if (sig_cnt = 20) then
                            output <= sig_out;
                            sig_out <= "000000000000000000000";
                            sig_cnt <= 0;
                        end if;
                    end if;
                end if;
            end process p_shifter;
    end architecture Behavioral;