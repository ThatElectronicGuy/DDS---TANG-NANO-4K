library IEEE:
use IEEE_STD_LOGIC_1164.ALL;
use IEEE_NUMERIC_STD.ALL;

entity Reverse_Sawtooth_Wave_ROM is
Port
(
    ADDR : in STD_LOGIC_VECTOR (5 downto 0); -- 64 entries
    DATA : out STD_LOGIC_VECTOR (13 downto 0) -- 14 bit entries for 14 bit DAC
);
end Reverse_Sawtooth_Wave_ROM;

architecture Behavioral of Reverse_Sawtooth_Wave_ROM is
    type Reverse_Sawtooth_Wave_Table is array (0 to 63) of STD_LOGIC_VECTOR (13 downto 0);
    
    constant ROM : Reverse_Sawtooth_Wave_Table :=
    (
                0 => x"3FFF",
                1 => x"3EFA",
                2 => x"3DF6",
                3 => x"3CF2",
                4 => x"3BEE",
                5 => x"3AEA",
                6 => x"39E6",
                7 => x"38E2",
                8 => x"37DE",
                9 => x"36DA",
                10 => x"35D6",
                11 => x"34D2",
                12 => x"33CE",
                13 => x"32CA",
                14 => x"31C6",
                15 => x"30C2",
                16 => x"2FBE",
                17 => x"2EBA",
                18 => x"2DB6",
                19 => x"2CB2",
                20 => x"2BAE",
                21 => x"2AAA",
                22 => x"29A5",
                23 => x"28A1",
                24 => x"279D",
                25 => x"2699",
                26 => x"2595",
                27 => x"2491",
                28 => x"238D",
                29 => x"2289",
                30 => x"2185",
                31 => x"2081",
                32 => x"1F7D",
                33 => x"1E79",
                34 => x"1D75",
                35 => x"1C71",
                36 => x"1B6D",
                37 => x"1A69",
                38 => x"1965",
                39 => x"1861",
                40 => x"175D",
                41 => x"1659",
                42 => x"1555",
                43 => x"1450",
                44 => x"134C",
                45 => x"1248",
                46 => x"1144",
                47 => x"1040",
                48 => x"0F3C",
                49 => x"0E38",
                50 => x"0D34",
                51 => x"0C30",
                52 => x"0B2C",
                53 => x"0A28",
                54 => x"0924",
                55 => x"0820",
                56 => x"071C",
                57 => x"0618",
                58 => x"0514",
                59 => x"0410",
                60 => x"030C",
                61 => x"0208",
                62 => x"0104",
                63 => x"0000"
);

begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end Behavioral;
