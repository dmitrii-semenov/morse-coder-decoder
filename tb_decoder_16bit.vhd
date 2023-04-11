library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity tb_decoder_16bit is
--  Port ( );
end tb_decoder_16bit;

architecture testbench of tb_decoder_16bit is

    signal input             : std_logic_vector(15 downto 0);
    signal output            : std_logic_vector(7 downto 0);


begin
    uut_decoder_16bit: entity work.decoder_16bit
        port map(
            input     => input,
            output    => output
        );

    p_stimulus : process
    begin
    	input <= "0110110110110110";
        wait for 100 ns;
        input <= "0101101101100000";
        wait for 100 ns;
        input <= "0101011010000000";
        wait for 100 ns;
        wait;
    end process p_stimulus;
end architecture testbench;