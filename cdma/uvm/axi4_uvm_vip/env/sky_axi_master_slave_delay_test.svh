`ifndef SKY_AXI_MASTER_SLAVE_DELAY_TEST_SVH
`define SKY_AXI_MASTER_SLAVE_DELAY_TEST_SVH

//--- use exact one cycle delay for each channel to do performance test
class sky_axi_master_slave_delay_test#(int rd_cmd_dly=0, int rd_data_dly=0, int wr_cmd_dly=0, int wr_data_dly=0, int wr_resp_dly=0) 
extends sky_axi_master_slave_sample_test;

  function new(string name = "sky_axi_master_slave_delay_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_name(), $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction


  //create_configuration() will be called by apply_config_settings(), which is defined in tue_component_base. 
  //apply_config_settings() is a uvm build-in function in uvm_component, will be called in build_phase when super.build() is called.
  virtual function void create_configuration();
    super.create_configuration();
    
    configuration.axi_cfg[0].rd_cmd_delay.max_delay = rd_cmd_dly;
    configuration.axi_cfg[1].rd_cmd_delay.max_delay = rd_cmd_dly;
    configuration.axi_cfg[0].rd_cmd_delay.min_delay = rd_cmd_dly;
    configuration.axi_cfg[1].rd_cmd_delay.min_delay = rd_cmd_dly;

    configuration.axi_cfg[0].read_data_delay.max_delay = rd_data_dly;
    configuration.axi_cfg[1].read_data_delay.max_delay = rd_data_dly;
    configuration.axi_cfg[0].read_data_delay.min_delay = rd_data_dly;
    configuration.axi_cfg[1].read_data_delay.min_delay = rd_data_dly;
    
    configuration.axi_cfg[0].wr_cmd_delay.max_delay = wr_cmd_dly;
    configuration.axi_cfg[1].wr_cmd_delay.max_delay = wr_cmd_dly;
    configuration.axi_cfg[0].wr_cmd_delay.min_delay = wr_cmd_dly;
    configuration.axi_cfg[1].wr_cmd_delay.min_delay = wr_cmd_dly;
    
    configuration.axi_cfg[0].write_data_delay.max_delay = wr_data_dly;
    configuration.axi_cfg[1].write_data_delay.max_delay = wr_data_dly;
    configuration.axi_cfg[0].write_data_delay.min_delay = wr_data_dly;
    configuration.axi_cfg[1].write_data_delay.min_delay = wr_data_dly;
    
    configuration.axi_cfg[0].response_delay.max_delay = wr_resp_dly;
    configuration.axi_cfg[1].response_delay.max_delay = wr_resp_dly;
    configuration.axi_cfg[0].response_delay.min_delay = wr_resp_dly;
    configuration.axi_cfg[1].response_delay.min_delay = wr_resp_dly;
  endfunction

  `uvm_component_param_utils(sky_axi_master_slave_delay_test#(rd_cmd_dly, rd_data_dly, wr_cmd_dly, wr_data_dly, wr_resp_dly))
endclass


//--- use typedef to create new test case doesn't work, these components are not registered in UVM factory.
//typedef sky_axi_master_slave_delay_test#(.rd_cmd_dly(0), .rd_data_dly(0), .wr_cmd_dly(0), .wr_data_dly(0), .wr_resp_dly(0))     sky_axi_mas_slv_0_delay_test;
//typedef sky_axi_master_slave_delay_test#(.rd_cmd_dly(16), .rd_data_dly(0), .wr_cmd_dly(4), .wr_data_dly(0), .wr_resp_dly(0))    sky_axi_mas_slv_small_delay_test;


class sky_axi_mas_slv_0_delay_test extends sky_axi_master_slave_delay_test#(.rd_cmd_dly(0), .rd_data_dly(0), .wr_cmd_dly(0), .wr_data_dly(0), .wr_resp_dly(0));

  function new(string name = "sky_axi_mas_slv_0_delay_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_name, $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction

  `uvm_component_utils(sky_axi_mas_slv_0_delay_test)

endclass : sky_axi_mas_slv_0_delay_test


class sky_axi_mas_slv_small_delay_test extends sky_axi_master_slave_delay_test#(.rd_cmd_dly(4), .rd_data_dly(16), .wr_cmd_dly(4), .wr_data_dly(5), .wr_resp_dly(0));

  function new(string name = "sky_axi_mas_slv_small_delay_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_name, $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction

  `uvm_component_utils(sky_axi_mas_slv_small_delay_test)

endclass : sky_axi_mas_slv_small_delay_test


class sky_axi_mas_slv_big_delay_test extends sky_axi_master_slave_delay_test#(.rd_cmd_dly(16), .rd_data_dly(128), .wr_cmd_dly(16), .wr_data_dly(0), .wr_resp_dly(0));

  function new(string name = "sky_axi_mas_slv_big_delay_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_name, $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction

  `uvm_component_utils(sky_axi_mas_slv_big_delay_test)

endclass : sky_axi_mas_slv_big_delay_test

`endif
