library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity switch_driver is
    port(
    clk         : in  std_logic;
    rst         : in  std_logic;
    send        : in std_logic;
    SW          : in  std_logic_vector(9 downto 0);
    output      : out  std_logic_vector(9 downto 0)
    );
end entity switch_driver;

architecture Behavioral of switch_driver is
    signal sig_control : std_logic_vector(9 downto 0) := "0000000000";
    begin
        p_switch_driver : process (clk,send) is
            begin
                if (rst = '1') then
                    output        <= "0000000000";
                    sig_control   <= "0000000000";
                elsif rising_edge(clk) then
                    if (send = '1') then
                        sig_control(0) <= SW(0);
                        sig_control(1) <= SW(1);
                        sig_control(2) <= SW(2);
                        sig_control(3) <= SW(3);
                        sig_control(4) <= SW(4);
                        sig_control(5) <= SW(5);
                        sig_control(6) <= SW(6);
                        sig_control(7) <= SW(7);
                        sig_control(8) <= SW(8);
                        sig_control(9) <= SW(9);
                        output <= sig_control;
                    end if;
                end if;
            end process p_switch_driver;
    end architecture Behavioral;

