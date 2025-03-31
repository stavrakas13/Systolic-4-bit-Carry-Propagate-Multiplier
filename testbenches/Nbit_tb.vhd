library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_N is
end tb_N;

architecture Behavioral of tb_N is
    constant CLK_PERIOD: time := 8 ns;
    signal clkf, rstf,inputf,outputf: std_logic;
begin
    UUT: entity work.bit_Nshift_register
    port map (
        clkf, rstf,inputf,outputf
    );
    CLOCK: process
     begin
            clkf<='0';
            wait for CLK_PERIOD/2;
            clkf<='1';
            wait for CLK_PERIOD/2;
    end process CLOCK;
    tb: process
    begin
    inputf<='1';
    wait for CLK_PERIOD;
    inputf<='0';
    wait for CLK_PERIOD;
    inputf<='1';
    end process tb;
end Behavioral;
