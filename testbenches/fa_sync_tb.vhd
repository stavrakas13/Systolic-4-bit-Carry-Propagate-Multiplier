library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity fa_sync_tb is
end fa_sync_tb;

architecture Behavioral of fa_sync_tb is
    signal clk, A, B, cin, S, cout: std_logic;
    constant CLK_PERIOD: time := 8 ns;
begin
    UUT: entity work.sync_fa port map(clk, A, B, cin, S, cout);
    CLOCK: process
        begin
        
            clk<='0';
            wait for CLK_PERIOD*1.2;
            clk<='1';
            wait for CLK_PERIOD*0.8;
        end process CLOCK;
    tb: process

        begin
            wait for CLK_PERIOD;
            A <= '0'; B <= '0'; cin <= '0';
            wait for CLK_PERIOD;
            A <= '1'; B <= '0'; cin <= '0';
            wait for CLK_PERIOD;
            A <= '0'; B <= '1'; cin <= '0';
            wait for CLK_PERIOD;
            A <= '1'; B <= '1'; cin <= '0';
            wait for CLK_PERIOD;
            A <= '0'; B <= '0'; cin <= '1';
            wait for CLK_PERIOD;
            A <= '1'; B <= '0'; cin <= '1';
            wait for CLK_PERIOD;
            A <= '0'; B <= '1'; cin <= '1';
            wait for CLK_PERIOD;
            A <= '1'; B <= '1'; cin <= '1';
            wait for CLK_PERIOD;
            
    end process tb;
end Behavioral;
