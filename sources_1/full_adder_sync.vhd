library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;

entity sync_fa is
    port(
        clk, rst, A, B, cin: in std_logic;
        S, cout: out std_logic
    );
end sync_fa;

architecture full_adder_sync of sync_fa is
    signal state_fa: std_logic_vector(2 downto 0);
begin
    process(clk, A, B, cin)
       begin
        state_fa <= A & B & cin;
        if rst='1' then
            S <='0';
            cout<='0';
        end if;
        if rising_edge(clk) then
        case (state_fa) is
            when "000" =>
                S <= '0';
                cout<= '0';
            when "001" =>
                S <= '1';
                cout <= '0';
            when "010" =>
                S <= '1';
                cout <= '0';
            when "011" =>
                S <= '0';
                cout <= '1';
            when "100" =>
                S <= '1';
                cout <= '0';
            when "101" =>
                S <= '0';
                cout <= '1';
             when "110" =>
                S <= '0';
                cout <= '1';
             when "111" =>
                S <= '1';
                cout <= '1';   
             when others =>
            end case;
        end if;
        end process;
end full_adder_sync;
