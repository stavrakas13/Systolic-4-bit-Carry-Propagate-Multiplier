library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity Nbit_shift_register is
    generic (
        N : integer := 6
    );
    Port ( 
        clk, rst: in std_logic;
        input: in std_logic_vector (N-1 downto 0);
        output: out std_logic_vector(N-1 downto 0)
        );
end Nbit_shift_register;

architecture parallel_shift of Nbit_shift_register is

begin
    flipflops: for i in 0 to N-1 generate
        Dff: entity work.dff
            port map(
                d=>input(i),
                clk=>clk,
                rst=>rst,
                q=>output(i)
            );
    end generate flipflops;
end parallel_shift;
