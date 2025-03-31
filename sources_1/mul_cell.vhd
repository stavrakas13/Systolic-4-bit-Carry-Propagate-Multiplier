library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity mul_cell is
    Port (
        clkm, rstm, am, bm, cinm, sinm: in std_logic;
        coutm, soutm, aoutm, boutm: out std_logic
    );
end mul_cell;

architecture cell of mul_cell is
    signal fa_s, fa_cout, btw_ff, fa_and: std_logic; 
begin
    fa_and<= am and bm; -- AND GATE INSIDE THE FA ASTERISK
    
    FA: entity work.sync_fa port map(
        clk=>clkm,
        rst=>rstm,
        A=>fa_and,
        B=>sinm,
        cin=>cinm,
        S=>soutm,
        cout=>coutm
    );
    
    dff0: entity work.dff port map(
        d=>bm,
        clk=>clkm,
        rst=>rstm,
        q=>boutm
    );
    
    dff2: entity work.dff port map(
        d=>am,
        clk=>clkm,
        rst=>rstm,
        q=>btw_ff
    );
    
    dff3: entity work.dff port map(
        d=>btw_ff,
        clk=>clkm,
        rst=>rstm,
        q=>aoutm
    );
end cell;
