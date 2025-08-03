library IEEE:
use IEEE_STD_LOGIC_1164.ALL;
use IEEE_NUMERIC_STD.ALL;

entity Triangle_Wave_ROM is
Port
(
    ADDR : in STD_LOGIC_VECTOR (5 downto 0); -- 64 entries
    DATA : out STD_LOGIC_VECTOR (13 downto 0) -- 14 bit entries for 14 bit DAC
);
end Triangle_Wave_ROM;

architecture Behavioral of Triangle_Wave_ROM is
    type Triangle_Wave_Table is array (0 to 63) of STD_LOGIC_VECTOR (13 downto 0);
    
    constant ROM : Triangle_Wave_Table :=
    (
                0 => x"0000",
                1 => x"0210",
                2 => x"0420",
                3 => x"0631",
                4 => x"0841",
                5 => x"0A52",
                6 => x"0C62",
                7 => x"0E73",
                8 => x"1083",
                9 => x"1294",
                10 => x"14A4",
                11 => x"16B5",
                12 => x"18C5",
                13 => x"1AD6",
                14 => x"1CE6",
                15 => x"1EF7",
                16 => x"2107",
                17 => x"2318",
                18 => x"2528",
                19 => x"2739",
                20 => x"2949",
                21 => x"2B5A",
                22 => x"2D6A",
                23 => x"2F7B",
                24 => x"318B",
                25 => x"339C",
                26 => x"35AC",
                27 => x"37BD",
                28 => x"39CD",
                29 => x"3BDE",
                30 => x"3DEE",
                31 => x"3FFF",
                32 => x"3FFF",
                33 => x"3DEE",
                34 => x"3BDE",
                35 => x"39CD",
                36 => x"37BD",
                37 => x"35AC",
                38 => x"339C",
                39 => x"318B",
                40 => x"2F7B",
                41 => x"2D6A",
                42 => x"2B5A",
                43 => x"2949",
                44 => x"2739",
                45 => x"2528",
                46 => x"2318",
                47 => x"2107",
                48 => x"1EF7",
                49 => x"1CE6",
                50 => x"1AD6",
                51 => x"18C5",
                52 => x"16B5",
                53 => x"14A4",
                54 => x"1294",
                55 => x"1083",
                56 => x"0E73",
                57 => x"0C62",
                58 => x"0A52",
                59 => x"0841",
                60 => x"0631",
                61 => x"0420",
                62 => x"0210",
                63 => x"0000"
);

begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end Behavioral;
