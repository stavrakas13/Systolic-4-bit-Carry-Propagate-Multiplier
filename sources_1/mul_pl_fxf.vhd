library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;


entity mul_pl_fxf is
    Port (
        clk, rst: in std_logic;
        a, b: in std_logic_vector(3 downto 0);
        p: out std_logic_vector(7 downto 0)
    );
end mul_pl_fxf;

architecture fbit_mul of mul_pl_fxf is
    signal d02, d03, d04:std_logic;
    signal h20, h30, h40:std_logic;
    signal c11, s11, d11, h11: std_logic;
    signal c12, s12, d12, h12: std_logic;
    signal c13, s13, d13, h13: std_logic;
    signal c14, s14, d14, h14: std_logic;
    signal c21, s21, d21, h21: std_logic;
    signal c22, s22, d22, h22: std_logic;
    signal c23, s23, d23, h23: std_logic;
    signal c24, s24, d24, h24: std_logic;
    signal c31, s31, d31, h31: std_logic;
    signal c32, s32, d32, h32: std_logic;
    signal c33, s33, d33, h33: std_logic;
    signal c34, s34, d34, h34: std_logic;
    signal c41, s41, d41, h41: std_logic;
    signal c42, s42, d42, h42: std_logic;
    signal c43, s43, d43, h43: std_logic;
    signal c44, s44, d44, h44: std_logic;
    signal c14d, c24d,c34d: std_logic;
--    signal c12, s12, d12, h12: std_logic;
    

    -- c11 means horizontal wire line 1, component 1 (carry)
    -- s11 means vertical wire line 1, component 1 (sum)
    -- d11 means diagonial wire line 1, component 1 (aj)
    -- h11 means horizontal wire line 1, component 1 (bj)
begin
    
    DFFa1: entity work.dff port map (
        d=>a(1),
        clk=>clk,
        rst=>rst,
        q=>d02
    );
    
    DFFa2: entity work.bit_twoshift_register port map(
        clkf=>clk,
        rstf=>rst,
        inputf=>a(2),
        outputf=>d03
    );
    
    DFFa3: entity work.bit_Nshift_register 
        generic map (
            N=>3
        )
        port map (
            clkf=>clk,
            rstf=>rst,
            inputf=>a(3),
            outputf=>d04
        );
    
    
    DFFb1: entity work.bit_twoshift_register port map(
        clkf=>clk,
        rstf=>rst,
        inputf=>b(1),
        outputf=>h20
    );
    
    DFFb2: entity work.bit_Nshift_register 
        generic map (
            N=>4
        )
        port map (
            clkf=>clk,
            rstf=>rst,
            inputf=>b(2),
            outputf=>h30
        );
        
    DFFb3: entity work.bit_Nshift_register 
        generic map (
            N=>6
        )
        port map (
            clkf=>clk,
            rstf=>rst,
            inputf=>b(3),
            outputf=>h40
        );
            
--Stage 1 

    MC11: entity work.mul_cell port map (
        clkm=>clk,
        rstm=>rst,
        am=>a(0),
        bm=>b(0),
        cinm=>'0',
        sinm=>'0',
        coutm=> c11,
        soutm=> s11, 
        aoutm=> d11,
        boutm => h11
    ); 
    
-- Stage 2
    MC21: entity work.mul_cell port map ( -- MC21 means stage 2, component 1
        clkm=>clk,
        rstm=>rst,
        am=>d02,
        bm=>h11,
        cinm=>c11,
        sinm=>'0',
        coutm=> c12,
        soutm=> s12, 
        aoutm=> d12,
        boutm => h12
    ); 
 -- Stage 3
 
    MC31: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d03,
        bm=>h12,
        cinm=>c12,
        sinm=>'0',
        coutm=>c13,
        soutm=>s13, 
        aoutm=>d13,
        boutm =>h13
    );

    MC32: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d11,
        bm=>h20,
        cinm=>'0',
        sinm=>s12,
        coutm=>c21,
        soutm=>s21, 
        aoutm=>d21,
        boutm => h21
    ); 
    
    --Stage 4
    
    MC41: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d04,
        bm=>h13,
        cinm=>c13,
        sinm=>'0',
        coutm=>c14,
        soutm=>s14, 
        aoutm=>d14,
        boutm => h14
    ); 
    
    
    MC42: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d12,
        bm=>h21,
        cinm=>c21,
        sinm=>s13,
        coutm=>c22,
        soutm=>s22, 
        aoutm=>d22,
        boutm =>h22
    ); 
    
    --Stage 5
    
    DFFc14: entity work.dff port map (
        d=>c14,
        clk=>clk,
        rst=>rst,
        q=>c14d
    );
    
    MC51: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d13,
        bm=>h22,
        cinm=>c22,
        sinm=>s14,
        coutm=>c23,
        soutm=>s23, 
        aoutm=>d23,
        boutm =>h23
    ); 
    
    
    
     MC52: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d21,
        bm=>h30,
        cinm=>'0',
        sinm=>s22,
        coutm=>c31,
        soutm=>s31, 
        aoutm=>d31,
        boutm =>h31
    ); 
    
    --Stage 6
    
    MC61: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d14,
        bm=>h23,
        cinm=>c23,
        sinm=>c14d,
        coutm=>c24,
        soutm=>s24, 
        aoutm=>d24,
        boutm =>h24
    ); 
    

     MC62: entity work.mul_cell port map (
        clkm=>clk,
        rstm=>rst,
        am=>d22,
        bm=>h31,
        cinm=>c31,
        sinm=>s23,
        coutm=>c32,
        soutm=>s32, 
        aoutm=>d32,
        boutm =>h32
    ); 
    
    --Stage 7
    
    
    DFFc24: entity work.dff port map (
        d=> c24,
        clk=> clk,
        rst=>rst,
        q=> c24d
    );
     MC71: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d23,
        bm=>h32,
        cinm=>c32,
        sinm=>s24,
        coutm=>c33,
        soutm=>s33, 
        aoutm=>d33,
        boutm =>h33
    ); 
    
     MC72: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d31,
        bm=>h40,
        cinm=>'0',
        sinm=>s32,
        coutm=>c41,
        soutm=>s41, 
        aoutm=>d41,
        boutm =>h41
    ); 
    
    --Stage 8
    
    MC81: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d24,
        bm=>h33,
        cinm=>c33,
        sinm=>c24d,
        coutm=>c34,
        soutm=>s34, 
        aoutm=>d34,
        boutm =>h34
    );  
    
    
     MC82: entity work.mul_cell port map ( 
        clkm=>clk,
        rstm=>rst,
        am=>d32,
        bm=>h41,
        cinm=>c41,
        sinm=>s33,
        coutm=>c42,
        soutm=>s42, 
        aoutm=>d42,
        boutm =>h42
    ); 
    
    --Stage 9
    
    DFFc34: entity work.dff port map (
        d=>c34,
        clk=>clk,
        rst=>rst,
        q=>c34d
        );
    
     MC91: entity work.mul_cell port map ( -- MC21 means stage 2, component 1
        clkm=>clk,
        rstm=>rst,
        am=>d33,
        bm=>h42,
        cinm=>c42,
        sinm=>s34,
        coutm=>c43,
        soutm=>s43, 
        aoutm=>d43,
        boutm =>h43
    ); 
    
    
    --Stage 10
    
     MC101: entity work.mul_cell port map ( -- MC21 means stage 2, component 1
        clkm=>clk,
        rstm=>rst,
        am=>d34,
        bm=>h43,
        cinm=>c43,
        sinm=>c34d,
        coutm=>p(7),
        soutm=>p(6), 
        aoutm=>d44,
        boutm =>h44
    ); 
    
    --delays
    
    DFFp5: entity work.dff port map (
        d=>s43,
        clk=>clk,
        rst=>rst,
        q=>p(5)
    );
     DFFp4: entity work.bit_twoshift_register port map(
        clkf=>clk,
        rstf=>rst,
        inputf=>s42,
        outputf=>p(4)
    ); 
    DFFp3: entity work.bit_Nshift_register 
        generic map (
            N=>3
        )
        port map (
            clkf=>clk,
            rstf=>rst,
            inputf=>s41,
            outputf=>p(3)
        );
    DFFp2: entity work.bit_Nshift_register 
        generic map (
            N=>5
        )
        port map (
            clkf=>clk,
            rstf=>rst,
            inputf=>s31,
            outputf=>p(2)
    );
    
    DFFp1: entity work.bit_Nshift_register 
        generic map (
            N=>7
        )
        port map (
            clkf=>clk,
            rstf=>rst,
            inputf=>s21,
            outputf=>p(1)
   );
   DFFp0: entity work.bit_Nshift_register 
        generic map (
            N=>9
        )
        port map (
            clkf=>clk,
            rstf=>rst,
            inputf=>s11,
            outputf=>p(0)
   );
   
   
end fbit_mul;
