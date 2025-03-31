library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;


entity mul is
end mul;

architecture Behavioral of mul is
    signal clk, rst: std_logic;
    signal a,b: std_logic_vector(3 downto 0);
    signal p: std_logic_vector(7 downto 0);
    constant CLK_PERIOD: time := 8 ns;
       
begin
    UUT: entity work.mul_pl_fxf port map(clk, rst, a, b, p);
    CLOCK: process
        begin
            clk<='0';
            wait for CLK_PERIOD/2;
            clk<='1';
            wait for CLK_PERIOD/2;
        end process CLOCK;
    
    
    tb: process
    begin
        rst<='0';
        a <= "1101"; -- 13*5
        b <= "0101";
        wait for CLK_PERIOD;
        a <= "0011"; --3*2
        b <= "0010";
        wait for CLK_PERIOD;
        a <= "0111"; --7*0
        b <= "0000";
        wait for CLK_PERIOD;
        a <= "0101"; --7*5
        b <= "0111";
        wait for CLK_PERIOD;
        a <= "0000";
        b <= "0000";
         wait for CLK_PERIOD;
        a <= "0011"; --3*3
        b <= "0011";
        wait for CLK_PERIOD;
        a <= "0111"; --7*15
        b <= "1111";
        wait for CLK_PERIOD;
        a <= "1111"; --15*15
        b <= "1111";
        wait for CLK_PERIOD;
        a <= "1000"; -- 8*6
        b <= "0110";
        
        wait;
    end process tb;
end Behavioral;
