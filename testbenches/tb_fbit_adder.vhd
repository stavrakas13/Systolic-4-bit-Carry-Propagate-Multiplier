library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_fbit_adder is
end tb_fbit_adder;

architecture Behavioral of tb_fbit_adder is
    signal clkp,rstp: std_logic;
    signal Ap, Bp: std_logic_vector(3 downto 0);
    signal cinp: std_logic;
    signal Sp: std_logic_vector(3 downto 0);
    signal coutp: std_logic;
    constant CLK_PERIOD: time := 8 ns;
       
begin
    UUT: entity work.fbit_fa_pl port map(clkp, rstp, Ap, Bp, cinp, Sp, coutp);
    CLOCK: process
        begin
            clkp<='0';
            wait for CLK_PERIOD/2;
            clkp<='1';
            wait for CLK_PERIOD/2;
        end process CLOCK;
    
    
    tb: process
    begin
        rstp <= '1';
        wait for 2*CLK_PERIOD;
        rstp <= '0';
        wait for 2*CLK_PERIOD;

        Ap <= "0101"; -- 5+4
        Bp <= "0100";
        cinp <='0';
        wait for CLK_PERIOD;
        Ap <= "0011"; --3+2+0
        Bp <= "0010";
        cinp <='0';
        wait for CLK_PERIOD;
        Ap <= "0111"; --7+0+1
        Bp <= "0000";
        cinp <='1';
        wait for CLK_PERIOD;
        Ap <= "0101"; --7+4+1
        Bp <= "0111";
        cinp <='1';
        wait for 5*CLK_PERIOD;
    end process tb;
end Behavioral;
