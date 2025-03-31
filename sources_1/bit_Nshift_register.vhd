library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_Nshift_register is
    generic (
        N : integer := 10  
    );
    Port ( 
        clkf, rstf: in std_logic;
        inputf: in std_logic;
        outputf: out std_logic
        );
end bit_Nshift_register;

architecture serial_shift of bit_Nshift_register is
    signal cf: std_logic_vector(N-1 downto 0);
begin
    main: entity work.dff port map (
        d=>inputf,
        clk=>clkf,
        rst=>rstf,
        q=>cf(0)
    );
    
    flipflops: for i in 1 to N-2 generate
        Dff: entity work.dff
            port map(
                d=>cf(i-1),
                clk=>clkf,
                rst=>rstf,
                q=>cf(i)
            );
    end generate flipflops;
    
    final: entity work.dff port map (
        d=>cf(N-2),
        clk=>clkf,
        rst=>rstf,
        q=>outputf
        );
end serial_shift;