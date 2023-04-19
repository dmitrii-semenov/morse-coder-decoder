library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity signal_sender is
    port(
    clk        : in  std_logic;
    rst        : in  std_logic;
    send       : in  std_logic;
    data1      : in  std_logic_vector(20 downto 0);
    data2      : in  std_logic_vector(20 downto 0);
    data3      : in  std_logic_vector(20 downto 0);
    data4      : in  std_logic_vector(20 downto 0);
    data5      : in  std_logic_vector(20 downto 0);
    data6      : in  std_logic_vector(20 downto 0);
    data7      : in  std_logic_vector(20 downto 0);
    data8      : in  std_logic_vector(20 downto 0);
    output     : out  std_logic;
    LED16_R    : out  std_logic;
    LED16_G    : out  std_logic;
    LED16_B    : out  std_logic
    );
end entity signal_sender;

architecture Behavioral of signal_sender is
    signal index : integer range 0 to 20 := 20;
    signal data_cnt : integer range 0 to 8 := 7;
    signal one_start : integer range 0 to 20 := 20;
    signal cnt : integer range 0 to 1 := 0;
    begin
        p_signal_sender : process (clk,send) is
            begin
            if rising_edge(clk) then
                if (rst = '1') then
                    output <= '0';
                    LED16_R <= '0';
                    LED16_G <= '0';
                    LED16_B <= '0';
                    index <= 20;
                    data_cnt <= 7;
                    one_start <= 20;
                    cnt <= 0;
                elsif (send = '1') then
                    --if rising_edge(clk) then
                        if (data_cnt = 0) then
                            if (index = 20) then 
                                for i in 0 to 20 loop
                                    if (data1(i) = '1') then
                                        one_start <= i;
                                        cnt <= cnt + 1;
                                    end if;
                                end loop; 
                            end if;
                            if (cnt = 1) then
                                index <= one_start;
                                cnt <= 0;
                            else
                                output <= data1(index);
                                index <= (index - 1) mod 21;
                            end if;
                        end if;
                        if (data_cnt = 1) then
                            LED16_R <= '1';
                            LED16_G <= '0';
                            LED16_B <= '0';
                            if (index = 20) then 
                                for i in 0 to 20 loop
                                    if (data2(i) = '1') then
                                        one_start <= i;
                                        cnt <= cnt + 1;
                                    end if;
                                end loop; 
                            end if;
                            if (cnt = 1) then
                                index <= one_start;
                                cnt <= 0;
                            else
                                output <= data2(index);
                                index <= (index - 1) mod 21;
                            end if;
                        end if;
                        if (data_cnt = 2) then
                            LED16_R <= '1';
                            LED16_G <= '0';
                            LED16_B <= '0';
                            if (index = 20) then 
                                for i in 0 to 20 loop
                                    if (data3(i) = '1') then
                                        one_start <= i;
                                        cnt <= cnt + 1;
                                    end if;
                                end loop; 
                            end if;
                            if (cnt = 1) then
                                index <= one_start;
                                cnt <= 0;
                            else
                                output <= data3(index);
                                index <= (index - 1) mod 21;
                            end if;
                        end if;
                        if (data_cnt = 3) then
                            LED16_R <= '1';
                            LED16_G <= '0';
                            LED16_B <= '0';
                            if (index = 20) then 
                                for i in 0 to 20 loop
                                    if (data4(i) = '1') then
                                        one_start <= i;
                                        cnt <= cnt + 1;
                                    end if;
                                end loop; 
                            end if;
                            if (cnt = 1) then
                                index <= one_start;
                                cnt <= 0;
                            else
                                output <= data4(index);
                                index <= (index - 1) mod 21;
                            end if;
                        end if;
                        if (data_cnt = 4) then
                            LED16_R <= '1';
                            LED16_G <= '0';
                            LED16_B <= '0';
                            if (index = 20) then 
                                for i in 0 to 20 loop
                                    if (data5(i) = '1') then
                                        one_start <= i;
                                        cnt <= cnt + 1;
                                    end if;
                                end loop; 
                            end if;
                            if (cnt = 1) then
                                index <= one_start;
                                cnt <= 0;
                            else
                                output <= data5(index);
                                index <= (index - 1) mod 21;
                            end if;
                        end if;
                        if (data_cnt = 5) then
                            LED16_R <= '1';
                            LED16_G <= '0';
                            LED16_B <= '0';
                            if (index = 20) then 
                                for i in 0 to 20 loop
                                    if (data6(i) = '1') then
                                        one_start <= i;
                                        cnt <= cnt + 1;
                                    end if;
                                end loop; 
                            end if;
                            if (cnt = 1) then
                                index <= one_start;
                                cnt <= 0;
                            else
                                output <= data6(index);
                                index <= (index - 1) mod 21;
                            end if;
                        end if;
                        if (data_cnt = 6) then
                            LED16_R <= '1';
                            LED16_G <= '0';
                            LED16_B <= '0';
                            if (index = 20) then 
                                for i in 0 to 20 loop
                                    if (data7(i) = '1') then
                                        one_start <= i;
                                        cnt <= cnt + 1;
                                    end if;
                                end loop; 
                            end if;
                            
                            if (cnt = 1) then
                                index <= one_start;
                                cnt <= 0;
                            else
                                output <= data7(index);
                                index <= (index - 1) mod 21;
                            end if;
                        end if;
                        if (data_cnt = 7) then
                            LED16_R <= '1';
                            LED16_G <= '0';
                            LED16_B <= '0';
                            if (index = 20) then 
                                for i in 0 to 20 loop
                                    if (data8(i) = '1') then
                                        one_start <= i;
                                        cnt <= cnt + 1;
                                    end if;
                                end loop; 
                            end if;
                            if (cnt = 1) then
                                index <= one_start;
                                cnt <= 0;
                            else
                                output <= data8(index);
                                index <= (index - 1) mod 21;
                            end if;
                        end if;
                        if (data_cnt = 8) then
                            output <= '0';
                            index <= 1;
                            LED16_R <= '0';
                            LED16_G <= '1';
                            LED16_B <= '0';
                        end if;
                        if (index = 0) then
                            data_cnt <= (data_cnt - 1) mod 9;
                            cnt <= 0;
                        end if;
                    --end if;
                else
                    index <= 20;
                    data_cnt <= 7;
                    one_start <= 20;
                    cnt <= 0;
                    LED16_R <= '0';
                    LED16_G <= '0';
                    LED16_B <= '0';
                end if;
            end if;
            end process p_signal_sender;
    end architecture Behavioral;