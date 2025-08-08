create_clock -name CLK27 -period 37.038 [get_ports {CLK_27MHZ}]
//create_generated_clock -name CLK594 -source [get_ports {CLK_27MHZ}] -multiply_by 22 -divide_by 1 [get_ports {CLK_594MHZ}]
create_generated_clock -name CLK302_4 -source [get_ports {CLK_27MHZ}] -multiply_by 56 -divide_by 5 [get_pins {top/PLL/pllvr_inst/CLKOUT}]
create_generated_clock -name CLK100_8_internal -source [get_pins {top/PLL/pllvr_inst/CLKOUT}] -divide_by 3 [get_pins {top/PLL/pllvr_inst/CLKOUTD3}]
create_generated_clock -name CLK100_8_output -source [get_pins {top/PLL/pllvr_inst/CLKOUT}] -divide_by 3 [get_ports {CLK_100MHZ}]

create_clock -name MSCLK -period 41666.667 [get_ports {MSCLK}]

set_clock_groups -asynchronous -group {CLK27 CLK302_4 CLK100_8_internal CLK100_8_output} -group {MSCLK}
