library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Sawtooth_Wave_ROM is
Port
(
    ADDR : in STD_LOGIC_VECTOR (5 downto 0); -- 64 entries
    DATA : out STD_LOGIC_VECTOR (15 downto 0) -- 14 bit entries for 14 bit DAC
);
end Sawtooth_Wave_ROM;

architecture Behavioral of Sawtooth_Wave_ROM is
    type Sawtooth_Wave_Table is array (0 to 63) of STD_LOGIC_VECTOR (15 downto 0);
    
    constant ROM : Sawtooth_Wave_Table :=
    (
                0 => x"0000",
                1 => x"0004",
                2 => x"0008",
                3 => x"000C",
                4 => x"0010",
                5 => x"0014",
                6 => x"0018",
                7 => x"001C",
                8 => x"0020",
                9 => x"0024",
                10 => x"0028",
                11 => x"002C",
                12 => x"0030",
                13 => x"0034",
                14 => x"0038",
                15 => x"003C",
                16 => x"0040",
                17 => x"0044",
                18 => x"0048",
                19 => x"004C",
                20 => x"0050",
                21 => x"0055",
                22 => x"0059",
                23 => x"005D",
                24 => x"0061",
                25 => x"0065",
                26 => x"0069",
                27 => x"006D",
                28 => x"0071",
                29 => x"0075",
                30 => x"0079",
                31 => x"007D",
                32 => x"0081",
                33 => x"0085",
                34 => x"0089",
                35 => x"008D",
                36 => x"0091",
                37 => x"0095",
                38 => x"0099",
                39 => x"009D",
                40 => x"00A1",
                41 => x"00A5",
                42 => x"00AA",
                43 => x"00AE",
                44 => x"00B2",
                45 => x"00B6",
                46 => x"00BA",
                47 => x"00BE",
                48 => x"00C2",
                49 => x"00C6",
                50 => x"00CA",
                51 => x"00CE",
                52 => x"00D2",
                53 => x"00D6",
                54 => x"00DA",
                55 => x"00DE",
                56 => x"00E2",
                57 => x"00E6",
                58 => x"00EA",
                59 => x"00EE",
                60 => x"00F2",
                61 => x"00F6",
                62 => x"00FA",
                63 => x"00FF"
);

begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end Behavioral;
