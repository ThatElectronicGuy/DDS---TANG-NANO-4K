library IEEE:
use IEEE_STD_LOGIC_1164.ALL;
use IEEE_NUMERIC_STD.ALL;

entity Sawtooth_Wave_ROM is
Port
(
    ADDR : in STD_LOGIC_VECTOR (5 downto 0); -- 64 entries
    DATA : out STD_LOGIC_VECTOR (13 downto 0) -- 14 bit entries for 14 bit DAC
);
end Sawtooth_Wave_ROM;

architecture Behavioral of Sawtooth_Wave_ROM is
    type Sawtooth_Wave_Table is array (0 to 63) of STD_LOGIC_VECTOR (13 downto 0);
    
    constant ROM : Sawtooth_Wave_Table :=
    (
                0 => x"0000",
                1 => x"0104",
                2 => x"0208",
                3 => x"030C",
                4 => x"0410",
                5 => x"0514",
                6 => x"0618",
                7 => x"071C",
                8 => x"0820",
                9 => x"0924",
                10 => x"0A28",
                11 => x"0B2C",
                12 => x"0C30",
                13 => x"0D34",
                14 => x"0E38",
                15 => x"0F3C",
                16 => x"1040",
                17 => x"1144",
                18 => x"1248",
                19 => x"134C",
                20 => x"1450",
                21 => x"1555",
                22 => x"1659",
                23 => x"175D",
                24 => x"1861",
                25 => x"1965",
                26 => x"1A69",
                27 => x"1B6D",
                28 => x"1C71",
                29 => x"1D75",
                30 => x"1E79",
                31 => x"1F7D",
                32 => x"2081",
                33 => x"2185",
                34 => x"2289",
                35 => x"238D",
                36 => x"2491",
                37 => x"2595",
                38 => x"2699",
                39 => x"279D",
                40 => x"28A1",
                41 => x"29A5",
                42 => x"2AAA",
                43 => x"2BAE",
                44 => x"2CB2",
                45 => x"2DB6",
                46 => x"2EBA",
                47 => x"2FBE",
                48 => x"30C2",
                49 => x"31C6",
                50 => x"32CA",
                51 => x"33CE",
                52 => x"34D2",
                53 => x"35D6",
                54 => x"36DA",
                55 => x"37DE",
                56 => x"38E2",
                57 => x"39E6",
                58 => x"3AEA",
                59 => x"3BEE",
                60 => x"3CF2",
                61 => x"3DF6",
                62 => x"3EFA",
                63 => x"3FFF"
);

begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end Behavioral;
