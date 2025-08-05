library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reverse_Sawtooth_Wave_ROM is
Port
(
    ADDR : in STD_LOGIC_VECTOR (5 downto 0); -- 64 entries
    DATA : out STD_LOGIC_VECTOR (15 downto 0) -- 8 bit entries for 8 bit DAC
);
end Reverse_Sawtooth_Wave_ROM;

architecture Behavioral of Reverse_Sawtooth_Wave_ROM is
    type Reverse_Sawtooth_Wave_Table is array (0 to 63) of STD_LOGIC_VECTOR (15 downto 0);
    
    constant ROM : Reverse_Sawtooth_Wave_Table :=
    (
                0 => x"00FF",
                1 => x"00FA",
                2 => x"00F6",
                3 => x"00F2",
                4 => x"00EE",
                5 => x"00EA",
                6 => x"00E6",
                7 => x"00E2",
                8 => x"00DE",
                9 => x"00DA",
                10 => x"00D6",
                11 => x"00D2",
                12 => x"00CE",
                13 => x"00CA",
                14 => x"00C6",
                15 => x"00C2",
                16 => x"00BE",
                17 => x"00BA",
                18 => x"00B6",
                19 => x"00B2",
                20 => x"00AE",
                21 => x"00AA",
                22 => x"00A5",
                23 => x"00A1",
                24 => x"009D",
                25 => x"0099",
                26 => x"0095",
                27 => x"0091",
                28 => x"008D",
                29 => x"0089",
                30 => x"0085",
                31 => x"0081",
                32 => x"007D",
                33 => x"0079",
                34 => x"0075",
                35 => x"0071",
                36 => x"006D",
                37 => x"0069",
                38 => x"0065",
                39 => x"0061",
                40 => x"005D",
                41 => x"0059",
                42 => x"0055",
                43 => x"0050",
                44 => x"004C",
                45 => x"0048",
                46 => x"0044",
                47 => x"0040",
                48 => x"003C",
                49 => x"0038",
                50 => x"0034",
                51 => x"0030",
                52 => x"002C",
                53 => x"0028",
                54 => x"0024",
                55 => x"0020",
                56 => x"001C",
                57 => x"0018",
                58 => x"0014",
                59 => x"0010",
                60 => x"000C",
                61 => x"0008",
                62 => x"0004",
                63 => x"0000"
);

begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end Behavioral;
