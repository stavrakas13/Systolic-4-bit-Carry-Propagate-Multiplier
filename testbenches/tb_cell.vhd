library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_cell is
end tb_cell;

architecture Behavioral of tb_cell is
    constant CLK_PERIOD: time := 8 ns;
    signal clkm, rstm, am, bm, cinm, sinm, coutm, soutm, aoutm, boutm: std_logic;
begin
    UUT: entity work.mul_cell port map (
        clkm, rstm, am, bm, cinm, sinm, coutm, soutm, aoutm, boutm
    );
    CLOCK: process
     begin
            clkm<='0';
            wait for CLK_PERIOD/2;
            clkm<='1';
            wait for CLK_PERIOD/2;
    end process CLOCK;
    tb: process
    begin
    am<='1';
    bm<='1';
    sinm<='1';
    cinm<='1';
    wait for 1*CLK_PERIOD;
    am<='1';
    bm<='0';
    sinm<='0';
    cinm<='1';
    wait;
    end process tb;
end Behavioral;
