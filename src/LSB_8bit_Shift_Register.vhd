library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LSB_bit_shift_register_8bit is --LSB on D side which means that it's shifting left and entering from right side
    Port
        (
            D : in STD_LOGIC;
            Q : out STD_LOGIC_VECTOR (7 downto 0);
            CLK : in STD_LOGIC;
            RESET : in STD_LOGIC;
            ENABLE : in STD_LOGIC
        );
end LSB_bit_shift_register_8bit;

architecture Behavioral of LSB_bit_shift_register_8bit is   
    signal Q_s : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
    process (CLK)
    begin
        if RESET = '1' then
        Q_s <= (others => '0');
        elsif ENABLE = '1' then
        if rising_edge(CLK) then
        Q_s <= Q_s (6 downto 0) & D;
        end if;
        end if;
    end process;
    Q <= Q_s;
end Behavioral;
