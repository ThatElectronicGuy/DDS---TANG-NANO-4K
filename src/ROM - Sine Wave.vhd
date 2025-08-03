library IEEE:
use IEEE_STD_LOGIC_1164.ALL;
use IEEE_NUMERIC_STD.ALL;

entity Sine_Wave_ROM is
Port
(
    ADDR : in STD_LOGIC_VECTOR (5 downto 0); -- 64 entries
    DATA : out STD_LOGIC_VECTOR (13 downto 0) -- 14 bit entries for 14 bit DAC
);
end Sine_Wave_ROM;

architecture Behavioral of Sine_Wave_ROM is
    type Sine_Wave_Table is array (0 to 63) of STD_LOGIC_VECTOR (13 downto 0);
    
    constant ROM : Sine_Wave_Table :=
    (
                0 => x"1FFF",
                1 => x"232F",
                2 => x"2656",
                3 => x"296D",
                4 => x"2C6D",
                5 => x"2F4D",
                6 => x"3205",
                7 => x"3490",
                8 => x"36E7",
                9 => x"3903",
                10 => x"3AE0",
                11 => x"3C78",
                12 => x"3DC8",
                13 => x"3ECC",
                14 => x"3F82",
                15 => x"3FE8",
                16 => x"3FFC",
                17 => x"3FBF",
                18 => x"3F31",
                19 => x"3E54",
                20 => x"3D2A",
                21 => x"3BB5",
                22 => x"39FA",
                23 => x"37FD",
                24 => x"35C3",
                25 => x"3351",
                26 => x"30AE",
                27 => x"2DE1",
                28 => x"2AF1",
                29 => x"27E4",
                30 => x"24C4",
                31 => x"2197",
                32 => x"1E67",
                33 => x"1B3A",
                34 => x"181A",
                35 => x"150D",
                36 => x"121D",
                37 => x"0F50",
                38 => x"0CAD",
                39 => x"0A3B",
                40 => x"0801",
                41 => x"0604",
                42 => x"0449",
                43 => x"02D4",
                44 => x"01AA",
                45 => x"00CD",
                46 => x"003F",
                47 => x"0002",
                48 => x"0016",
                49 => x"007C",
                50 => x"0132",
                51 => x"0236",
                52 => x"0386",
                53 => x"051E",
                54 => x"06FB",
                55 => x"0917",
                56 => x"0B6E",
                57 => x"0DF9",
                58 => x"10B1",
                59 => x"1391",
                60 => x"1691",
                61 => x"19A8",
                62 => x"1CCF",
                63 => x"1FFF"
);

begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end Behavioral;
