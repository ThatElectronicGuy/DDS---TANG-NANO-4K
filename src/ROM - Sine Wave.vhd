library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Sine_Wave_ROM is
Port
(
    ADDR : in STD_LOGIC_VECTOR (5 downto 0); -- 64 entries
    DATA : out STD_LOGIC_VECTOR (15 downto 0) -- 8 bit entries for 8 bit DAC
);
end Sine_Wave_ROM;

architecture Behavioral of Sine_Wave_ROM is
    type Sine_Wave_Table is array (0 to 63) of STD_LOGIC_VECTOR (15 downto 0);
    
    constant ROM : Sine_Wave_Table :=
    (
                0 => x"007F",
                1 => x"008C",
                2 => x"0098",
                3 => x"00A5",
                4 => x"00B1",
                5 => x"00BC",
                6 => x"00C7",
                7 => x"00D1",
                8 => x"00DA",
                9 => x"00E3",
                10 => x"00EA",
                11 => x"00F0",
                12 => x"00F6",
                13 => x"00FA",
                14 => x"00FD",
                15 => x"00FE",
                16 => x"00FE",
                17 => x"00FE",
                18 => x"00FB",
                19 => x"00F8",
                20 => x"00F3",
                21 => x"00ED",
                22 => x"00E7",
                23 => x"00DF",
                24 => x"00D6",
                25 => x"00CC",
                26 => x"00C1",
                27 => x"00B6",
                28 => x"00AB",
                29 => x"009E",
                30 => x"0092",
                31 => x"0085",
                32 => x"0079",
                33 => x"006C",
                34 => x"0060",
                35 => x"0053",
                36 => x"0048",
                37 => x"003D",
                38 => x"0032",
                39 => x"0028",
                40 => x"001F",
                41 => x"0017",
                42 => x"0011",
                43 => x"000B",
                44 => x"0006",
                45 => x"0003",
                46 => x"0000",
                47 => x"0000",
                48 => x"0000",
                49 => x"0001",
                50 => x"0004",
                51 => x"0008",
                52 => x"000E",
                53 => x"0014",
                54 => x"001B",
                55 => x"0024",
                56 => x"002D",
                57 => x"0037",
                58 => x"0042",
                59 => x"004D",
                60 => x"0059",
                61 => x"0066",
                62 => x"0072",
                63 => x"007F"
);

begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end Behavioral;
