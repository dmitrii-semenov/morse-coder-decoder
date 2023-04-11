library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity decoder_16bit is
    port(
    input       : in   std_logic_vector(15 downto 0);
    output      : out  std_logic_vector(7 downto 0)
    );
end entity decoder_16bit;

architecture Behavioral of decoder_16bit is
    signal sig_in : std_logic_vector(15 downto 0);
    signal sig_1 : std_logic_vector(1 downto 0) := "00";
    signal sig_2 : std_logic_vector(1 downto 0) := "00";
    signal sig_3 : std_logic_vector(1 downto 0) := "00";
    signal sig_4 : std_logic_vector(1 downto 0) := "00";
    signal sig_5 : std_logic_vector(1 downto 0) := "00";
    signal sig_cnt    : std_logic_vector(2 downto 0) := "000";
begin
    p_decoder_16bit : process is
        begin
            sig_in <= input;
            for i in 14 downto 0 loop
                if sig_in(i) = '1' then
                    if sig_in(i+1) = '1' then
                        if sig_cnt = "000" then
                            sig_1 <= "10";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        elsif sig_cnt = "001" then
                            sig_2 <= "10";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        elsif sig_cnt = "010" then
                            sig_3 <= "10";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        elsif sig_cnt = "011" then
                            sig_4 <= "10";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        elsif sig_cnt = "100" then
                            sig_5 <= "10";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        end if;
                    elsif sig_in(i+1) = '0' then
                        if sig_cnt = "000" then
                            sig_1 <= "01";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        elsif sig_cnt = "001" then
                            sig_2 <= "01";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        elsif sig_cnt = "010" then
                            sig_3 <= "01";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        elsif sig_cnt = "011" then
                            sig_4 <= "01";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        elsif sig_cnt = "100" then
                            sig_5 <= "01";
                            sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 3));
                        end if;
                    end if;
                end if;
            end loop;
            output <= "10101010";
        end process p_decoder_16bit;
end architecture Behavioral;
