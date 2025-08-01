0,library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFLIPFLOP is
    Port (
        clk : in STD_LOGIC;
        d   : in STD_LOGIC;
        q   : out_STD_LOGIC;
         );
end main;

architecture Behavioral of DFLIPFLOP is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            q <=d;
        end if;
    end process;
end Behavioral;
    