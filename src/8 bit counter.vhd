library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_8bit is
    Port (
        CLK : in STD_LOGIC;
        ENABLE : in STD_LOGIC;
        RESET : in STD_LOGIC;
        D : in STD_LOGIC_VECTOR(7 downto 0); -- 8 bit input
        Q : out STD_LOGIC_VECTOR(7 downto 0); -- 8 bit output
        ARESET : in STD_LOGIC
         );
end counter_8bit;

architecture Behavioral of counter_8bit is
    signal count : unsigned(7 downto 0) := (others => '0');
begin
    process(CLK,ARESET)
    begin   
        if ARESET = '1' then
            count <= (others => '0');
        elsif rising_edge(CLK) then
            if RESET = '1' then
                count <= (others => '0');
            elsif ENABLE = '1' then
                count <= count + unsigned(D);
            end if;
        end if;
    end process;

    Q <= STD_LOGIC_VECTOR (count);
end Behavioral;