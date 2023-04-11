library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity shifter_16bit is
    port(
    clk         : in  std_logic;
    rst         : in  std_logic;
    input       : in  std_logic;
    output      : out  std_logic_vector(15 downto 0)
    );
end entity shifter_16bit;

architecture Behavioral of shifter_16bit is
    signal sig_in : std_logic;
    signal sig_out : std_logic_vector(15 downto 0);
    signal sig_cnt    : std_logic_vector(3 downto 0) := "0000";
begin
    p_shifter_16bit : process (clk,input) is
        begin
            if (rst = '1') then
                sig_out <= (others => '0');
                output <= (others => '0');
                sig_cnt <= "0000";
            elsif rising_edge(clk) then
                sig_in <= input;
                for i in 14 downto 0 loop
                    sig_out(i+1) <= sig_out(i);
                end loop;
                sig_out(0) <= input;
                if sig_cnt = "0000" then
                    output <= sig_out;
                end if;
                if sig_cnt = "1111" then
                    --output <= sig_out;
                    sig_cnt <= "0000";
                else
                    sig_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_cnt)) + 1, 4));
                end if;
            end if;
        end process p_shifter_16bit;
end architecture Behavioral;
