library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fbit_fa_pl is
    Port (
        clkp, rstp: in std_logic;
        Ap, Bp: in std_logic_vector(3 downto 0);
        cinp: in std_logic;
        Sp: out std_logic_vector(3 downto 0);
        coutp: out std_logic
    );
end fbit_fa_pl;

architecture adder_pipeline of fbit_fa_pl is
    signal carry, sone: std_logic_vector(2 downto 0);
    signal stwo: std_logic_vector(1 downto 0);
    signal sthree: std_logic;
    signal wire0: std_logic_vector(5 downto 0);
    signal wire1: std_logic_vector(3 downto 0);
    signal wire2: std_logic_vector(1 downto 0);
begin 


    --STAGE 0 of the pipeline
    FA0: entity work.sync_fa
        port map (
            clk=>clkp,
            rst=>rstp,
            A=>Ap(0),
            B=>Bp(0),
            cin=>cinp,
            S=>sone(0),
            cout=>carry(0)          
        );
     
     FF0: entity work.Nbit_shift_register --this is 6bit register
        generic map (
            N => 6
        )
        port map (
            clk=>clkp,
            rst=>rstp,
            input(0)=>Bp(1),
            input(1)=>Ap(1),
            input(2)=>Bp(2),
            input(3)=>Ap(2),
            input(4)=>Bp(3),
            input(5)=>Ap(3),
            
            output=>wire0            
        );
      -- -------------------------------------------------------------------------------------------
      
      -- STAGE 1 
      
      
      FA1: entity work.sync_fa
        port map (
            clk=>clkp,
            rst=>rstp,
            A=>wire0(1),
            B=>wire0(0),
            cin=>carry(0),
            S=>stwo(0),
            cout=> carry(1)         
        );
     
     FF1: entity work.Nbit_shift_register --this is 5bit register
        generic map (
            N => 5
        )
        port map (
            clk=>clkp,
            rst=>rstp,
            input(0)=>sone(0),
            input(1)=>wire0(2),
            input(2) => wire0(3),
            input(3) =>wire0(4),
            input(4) => wire0(5),
            
            output(0) => sone(1),
            output(1) => wire1(0),
            output(2) => wire1(1),
            output(3) => wire1(2),
            output(4) => wire1(3)            
        );
      
-- ---------------------------------------------------------------------------------------------------------------

-- STAGE 2 

    FA2: entity work.sync_fa
        port map (
            clk=>clkp,
            rst=>rstp,
            A=>wire1(1),
            B=>wire1(0),
            cin=>carry(1),
            S=>sthree,
            cout=> carry(2)         
        );
     
     FF2: entity work.Nbit_shift_register --this is 4bit register
        generic map (
            N => 4
        )
        port map (
            clk=>clkp,
            rst=>rstp,
            input(0) => sone(1),
            input(1) => stwo(0),
            input(2) => wire1(2),
            input(3) =>wire1(3),
            
            output(0) => sone(2),
            output(1) => stwo(1),
            output(2) => wire2(0),
            output(3) => wire2(1)
        );

      -- -------------------------------------------------------------------------------------------
      
      -- STAGE 3
      
      FA3: entity work.sync_fa
        port map (
            clk=>clkp,
            rst=>rstp,
            A=> wire2(1),
            B=> wire2(0),
            cin=>carry(2),
            S=>Sp(3), -- the MSB
            cout=>coutp        
        );
     
     FF3: entity work.Nbit_shift_register --this is 3bit register
        generic map (
            N => 3
        )
        port map (
            clk=>clkp,
            rst=>rstp,
            input(0)=>sone(2),
            input(1)=>stwo(1),
            input(2)=>sthree,
            
            output(0) => Sp(0),
            output(1) => Sp(1),
            output(2) => Sp(2)          
        );
       

end adder_pipeline;