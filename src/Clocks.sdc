create_clock -name CLK27 -period 37.038 [get_ports {CLK_27MHZ}]
create_generated_clock -name CLK594 -source [get_ports {CLK_27MHZ}] -multiply_by 22 -divide_by 1 [get_ports {CLK_594MHZ}]