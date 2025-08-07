--Copyright (C)2014-2025 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.11.02 (64-bit)
--Part Number: GW1NSR-LV4CQN48PC7/I6
--Device: GW1NSR-4C
--Created Time: Thu Aug  7 02:15:58 2025

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component ROM_Reverse_Sawtooth_Wave
    port (
        dout: out std_logic_vector(15 downto 0);
        clk: in std_logic;
        oce: in std_logic;
        ce: in std_logic;
        reset: in std_logic;
        ad: in std_logic_vector(5 downto 0)
    );
end component;

your_instance_name: ROM_Reverse_Sawtooth_Wave
    port map (
        dout => dout,
        clk => clk,
        oce => oce,
        ce => ce,
        reset => reset,
        ad => ad
    );

----------Copy end-------------------
