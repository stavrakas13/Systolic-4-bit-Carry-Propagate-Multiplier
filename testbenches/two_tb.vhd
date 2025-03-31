library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_two is
end tb_two;

architecture Behavioral of tb_two is
    constant CLK_PERIOD: time := 8 ns;
    signal clkf, rstf,inputf,outputf: std_logic;
begin
    UUT: entity work.bit_twoshift_register port map (
        clkf, rstf,inputf,outputf
    );
    CLOCK: process
     begin
            clkf<='0';
            wait for CLK_PERIOD/2;
            clkf<='1';
            wait for CLK_PERIOD/2;
    end process CLOCK;
    inputf<='1';

end Behavioral;
