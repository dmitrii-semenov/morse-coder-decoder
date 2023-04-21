library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity button_driver is
    port(
    clk         : in  std_logic;
    SW         : in  std_logic;
    rst         : in  std_logic;
    input       : in  std_logic;
    send       : in  std_logic;
    output      : out  std_logic_vector(20 downto 0);
    LED17_R : out STD_LOGIC;
    LED17_G : out STD_LOGIC;
    LED17_B : out STD_LOGIC
    );
end entity button_driver;

architecture Behavioral of button_driver is
    signal sig_out : std_logic_vector(20 downto 0);
    signal one_cnt : integer := 0;
    signal zero_cnt : integer := 0;
    begin
        p_button_driver : process (clk,input,send) is
            begin
                if rising_edge(clk) then--(SW = '1')
                    if (rst = '1') then
                        sig_out <= "000000000000000000000";
                        output <= (others => '0');
                        one_cnt <= 0;
                        LED17_G <= '0';
                        LED17_B <= '0';
                        LED17_R <= '0';
                    elsif (SW = '1') then
                        if (send = '1') then
                            output <= sig_out;
                            sig_out <= "000000000000000000000";
                        end if;
                        if (input = '0') then
                            zero_cnt <= zero_cnt + 1;
                            one_cnt <= 0;
                            LED17_G <= '1';
                            LED17_B <= '0';
                            LED17_R <= '0';
                        end if;
                        if (zero_cnt = 1) then
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
                            sig_out(0) <= '0';
                        end if;
                        if (input = '1') then
                            zero_cnt <= 0;
                            one_cnt <= one_cnt + 1;
                            if (one_cnt < 2) then
                                LED17_G <= '0';
                                LED17_B <= '0';
                                LED17_R <= '1';
                            elsif (one_cnt = 2) then
                                LED17_G <= '0';
                                LED17_B <= '1';
                                LED17_R <= '0';
                            elsif (one_cnt > 2) then
                                LED17_G <= '0';
                                LED17_B <= '1';
                                LED17_R <= '0';
                            end if;
                        end if;
                        if (one_cnt = 1) then
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
                            sig_out(0) <= '1';
                        elsif (one_cnt = 3) then
                            sig_out(20) <= sig_out(18);
                            sig_out(19) <= sig_out(17);
                            sig_out(18) <= sig_out(16);
                            sig_out(17) <= sig_out(15);
                            sig_out(16) <= sig_out(14);
                            sig_out(15) <= sig_out(13);
                            sig_out(14) <= sig_out(12);
                            sig_out(13) <= sig_out(11);
                            sig_out(12) <= sig_out(10);
                            sig_out(11) <= sig_out(9);
                            sig_out(10) <= sig_out(8);
                            sig_out(9) <= sig_out(7);
                            sig_out(8) <= sig_out(6);
                            sig_out(7) <= sig_out(5);
                            sig_out(6) <= sig_out(4);
                            sig_out(5) <= sig_out(3);
                            sig_out(4) <= sig_out(2);
                            sig_out(3) <= sig_out(1);
                            sig_out(2) <= sig_out(0);
                            sig_out(1) <= '1';
                            sig_out(0) <= '1';
                        end if;
                    else 
                    sig_out <= "000000000000000000000";
                    output <= (others => '0');
                    one_cnt <= 0;
                    LED17_G <= '0';
                    LED17_B <= '0';
                    LED17_R <= '0';
                    end if;
                end if;
            end process p_button_driver;
    end architecture Behavioral;