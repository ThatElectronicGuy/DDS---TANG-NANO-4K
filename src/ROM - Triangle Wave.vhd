library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Triangle_Wave_ROM is
Port
(
    ADDR : in STD_LOGIC_VECTOR (5 downto 0); -- 64 entries
    DATA : out STD_LOGIC_VECTOR (15 downto 0) -- 8 bit entries for 8 bit DAC but 16 bits vector to ensure space
);
end Triangle_Wave_ROM;



architecture Behavioral of Triangle_Wave_ROM is
    type Triangle_Wave_Table is array (0 to 63) of STD_LOGIC_VECTOR (15 downto 0);

    constant ROM : Triangle_Wave_Table :=
    (
                0 => x"0000",
                1 => x"0008",
                2 => x"0010",
                3 => x"0018",
                4 => x"0020",
                5 => x"0029",
                6 => x"0031",
                7 => x"0039",
                8 => x"0041",
                9 => x"004A",
                10 => x"0052",
                11 => x"005A",
                12 => x"0062",
                13 => x"006A",
                14 => x"0073",
                15 => x"007B",
                16 => x"0083",
                17 => x"008B",
                18 => x"0094",
                19 => x"009C",
                20 => x"00A4",
                21 => x"00AC",
                22 => x"00B4",
                23 => x"00BD",
                24 => x"00C5",
                25 => x"00CD",
                26 => x"00D5",
                27 => x"00DE",
                28 => x"00E6",
                29 => x"00EE",
                30 => x"00F6",
                31 => x"00FF",
                32 => x"00FF",
                33 => x"00F6",
                34 => x"00EE",
                35 => x"00E6",
                36 => x"00DE",
                37 => x"00D5",
                38 => x"00CD",
                39 => x"00C5",
                40 => x"00BD",
                41 => x"00B4",
                42 => x"00AC",
                43 => x"00A4",
                44 => x"009C",
                45 => x"0094",
                46 => x"008B",
                47 => x"0083",
                48 => x"007B",
                49 => x"0073",
                50 => x"006A",
                51 => x"0062",
                52 => x"005A",
                53 => x"0052",
                54 => x"004A",
                55 => x"0041",
                56 => x"0039",
                57 => x"0031",
                58 => x"0029",
                59 => x"0020",
                60 => x"0018",
                61 => x"0010",
                62 => x"0008",
                63 => x"0000"
);
    attribute syn_romstyle:string;
    attribute syn_romstyle of ROM : constant is "block_rom";

begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end Behavioral;
