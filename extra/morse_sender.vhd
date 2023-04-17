library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity morse_sender is
    port(
    clk        : in  std_logic;
    rst        : in  std_logic;
    send       : in  std_logic;
    data1      : in  std_logic_vector(9 downto 0);
    data2      : in  std_logic_vector(9 downto 0);
    data3      : in  std_logic_vector(9 downto 0);
    data4      : in  std_logic_vector(9 downto 0);
    data5      : in  std_logic_vector(9 downto 0);
    data6      : in  std_logic_vector(9 downto 0);
    data7      : in  std_logic_vector(9 downto 0);
    data8      : in  std_logic_vector(9 downto 0);
    output     : out  std_logic;
    led    : out  std_logic
    );
end entity morse_sender;

architecture Behavioral of morse_sender is
    signal data_cnt : integer range 0 to 8 := 0;
    signal zero_cnt : integer := 0;
    signal data_ind : integer range 0 to 20 := 20;
    signal data_1 : std_logic_vector(20 downto 0) := "000000000000000000000";
    signal data : std_logic_vector(9 downto 0) := "0000000000";
    begin
        p_morse_sender : process (clk,send) is
            begin
                case data_cnt is
                    when 0 =>
                    data <= data1;
                    when 1 =>
                    data <= data2;
                    when 2 =>
                    data <= data3;
                    when 3 =>
                    data <= data4;
                    when 4 =>
                    data <= data5;
                    when 5 =>
                    data <= data6;
                    when 6 =>
                    data <= data7;
                    when 7 =>
                    data <= data8;
                    when others =>
                    data <= "0000000000";
                    led <= '1';
                end case;
                case data(1 downto 0) is
                    when "01" => 
                    data_1(3 downto 0) <= "0010";
                    when "11" => 
                    data_1(3 downto 0) <= "1110";
                    when others => 
                    data_1(3 downto 0) <= "0000";
                end case;
                case data(3 downto 2) is
                    when "01" => 
                    data_1(7 downto 4) <= "0010";
                    when "11" => 
                    data_1(7 downto 4) <= "1110";
                    when others => 
                    data_1(7 downto 4) <= "0000";
                end case;
                case data(5 downto 4) is
                    when "01" => 
                    data_1(11 downto 8) <= "0010";
                    when "11" => 
                    data_1(11 downto 8) <= "1110";
                    when others => 
                    data_1(11 downto 8) <= "0000";
                end case;
                case data(7 downto 6) is
                    when "01" => 
                    data_1(15 downto 12) <= "0010";
                    when "11" => 
                    data_1(15 downto 12) <= "1110";
                    when others => 
                    data_1(15 downto 12) <= "0000";
                end case;
                case data(9 downto 8) is
                    when "01" => 
                    data_1(19 downto 16) <= "0010";
                    when "11" => 
                    data_1(19 downto 16) <= "1110";
                    when others => 
                    data_1(19 downto 16) <= "0000";
                end case;
                if (rst = '1') then
                    output <= '0';
                    led <= '0';
                    data <= "0000000000";
                    data_1 <= "000000000000000000000";
                    data_cnt <= 0;
                elsif (send = '1') then
                    if rising_edge(clk) and (data_cnt /= 8) then
                        if (data_1(data_ind)) = '1' then
                            zero_cnt <= 0;
                            output <= '1';
                            data_ind <= (data_ind - 1) mod 21;
                        else
                            zero_cnt <= zero_cnt + 1;
                            if (zero_cnt = 2) then
                                if (data_1((data_ind - 1) mod 21)) = '1' then
                                    data_ind <= (data_ind - 1) mod 21;
                                elsif (data_1((data_ind - 2) mod 21)) = '1' then
                                    data_ind <= (data_ind - 2) mod 21;
                                elsif (data_1((data_ind - 3) mod 21)) = '1' then
                                    data_ind <= (data_ind - 3) mod 21;
                                elsif (data_1((data_ind - 4) mod 21)) = '1' then
                                    data_ind <= (data_ind - 4) mod 21;
                                elsif (data_1((data_ind - 5) mod 21)) = '1' then
                                    data_ind <= (data_ind - 5) mod 21;
                                elsif (data_1((data_ind - 6) mod 21)) = '1' then
                                    data_ind <= (data_ind - 6) mod 21;
                                elsif (data_1((data_ind - 7) mod 21)) = '1' then
                                    data_ind <= (data_ind - 7) mod 21;
                                elsif (data_1((data_ind - 8) mod 21)) = '1' then
                                    data_ind <= (data_ind - 8) mod 21;
                                elsif (data_1((data_ind - 9) mod 21)) = '1' then
                                    data_ind <= (data_ind - 9) mod 21;
                                elsif (data_1((data_ind - 10) mod 21)) = '1' then
                                    data_ind <= (data_ind - 10) mod 21;
                                elsif (data_1((data_ind - 11) mod 21)) = '1' then
                                    data_ind <= (data_ind - 11) mod 21;
                                elsif (data_1((data_ind - 12) mod 21)) = '1' then
                                    data_ind <= (data_ind - 12) mod 21;
                                else
                                end if;
                                zero_cnt <= 0;
                                output <= '0';
                            else
                                output <= '0';
                                data_ind <= (data_ind - 1) mod 21;
                            end if;
                        end if;
                        if (data_ind = 0) then
                            data_ind <= (data_ind - 1) mod 21;
                            data_cnt <= (data_cnt + 1) mod 9;
                        end if;
                    end if;
                elsif (send = '0') then
                    output <= '0';
                    led <= '0';
                    data <= "0000000000";
                    data_1 <= "000000000000000000000";
                    data_cnt <= 0;
                end if;
            end process p_morse_sender;
    end architecture Behavioral;