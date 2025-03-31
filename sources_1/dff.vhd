library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
    Port (
        d, clk, rst: in std_logic;
        q: out std_logic
    );
    
end dff;

architecture dff_bh of dff is

begin
    process(clk, rst)
        begin
            if rst = '1' then
                q <= '0'; 
            elsif rising_edge(clk) then
                q <= d;
            end if;
    end process;
end dff_bh;
