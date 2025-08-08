--Copyright (C)2014-2025 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.11.02 (64-bit)
--Part Number: GW1NSR-LV4CQN48PC7/I6
--Device: GW1NSR-4C
--Created Time: Fri Aug  8 14:18:47 2025

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component Gowin_PLLVR
    port (
        clkout: out std_logic;
        lock: out std_logic;
        clkoutd3: out std_logic;
        clkin: in std_logic
    );
end component;

your_instance_name: Gowin_PLLVR
    port map (
        clkout => clkout,
        lock => lock,
        clkoutd3 => clkoutd3,
        clkin => clkin
    );

----------Copy end-------------------
