library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_twoshift_register is
    
    Port ( 
        clkf, rstf: in std_logic;
        inputf: in std_logic;
        outputf: out std_logic
        );
end bit_twoshift_register;

architecture two_serial_shift of bit_twoshift_register is
    signal cf: std_logic;
begin
    main: entity work.dff port map (
        d=>inputf,
        clk=>clkf,
        rst=>rstf,
        q=>cf
    );    
    final: entity work.dff port map (
        d=>cf,
        clk=>clkf,
        rst=>rstf,
        q=>outputf
        );
end two_serial_shift;