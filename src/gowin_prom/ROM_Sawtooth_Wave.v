//Copyright (C)2014-2025 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//Tool Version: V1.9.11.02 (64-bit)
//Part Number: GW1NSR-LV4CQN48PC7/I6
//Device: GW1NSR-4C
//Created Time: Thu Aug  7 02:01:47 2025

module ROM_Sawtooth_Wave (dout, clk, oce, ce, reset, ad);

output [15:0] dout;
input clk;
input oce;
input ce;
input reset;
input [5:0] ad;

wire [15:0] prom_inst_0_dout_w;
wire gw_gnd;

assign gw_gnd = 1'b0;

pROM prom_inst_0 (
    .DO({prom_inst_0_dout_w[15:0],dout[15:0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .AD({gw_gnd,gw_gnd,gw_gnd,gw_gnd,ad[5:0],gw_gnd,gw_gnd,gw_gnd,gw_gnd})
);

defparam prom_inst_0.READ_MODE = 1'b0;
defparam prom_inst_0.BIT_WIDTH = 16;
defparam prom_inst_0.RESET_MODE = "SYNC";
defparam prom_inst_0.INIT_RAM_00 = 256'h003C003800340030002C002800240020001C001800140010000C000800040000;
defparam prom_inst_0.INIT_RAM_01 = 256'h007D007900750071006D006900650061005D005900550050004C004800440040;
defparam prom_inst_0.INIT_RAM_02 = 256'h00BE00BA00B600B200AE00AA00A500A1009D009900950091008D008900850081;
defparam prom_inst_0.INIT_RAM_03 = 256'h00000000000000000000000000000000000000000000000000000000000000FF;

endmodule //ROM_Sawtooth_Wave
