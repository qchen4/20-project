`ifndef TVIP_AXI_SAMPLE_CONFIGURATION_SVH
`define TVIP_AXI_SAMPLE_CONFIGURATION_SVH
class tvip_axi_sample_configuration extends tue_configuration;

  rand  tvip_axi_configuration  axi_cfg[2]; //[0]: for master; [1] for slave

  constraint c_axi_basic {
    foreach (axi_cfg[i]) {
      axi_cfg[i].qos_range[0]     != -1;
      axi_cfg[i].qos_range[1]     != -1;
    }
  }

  //modify the delay and weigth value to control the delay behavior
  constraint c_rd_cmd_delay {
    if (`TVIP_EN_RD_CMD_DELAY) {
      axi_cfg[0].rd_cmd_delay.min_delay          == 0;
      axi_cfg[0].rd_cmd_delay.max_delay          == 10;
      axi_cfg[0].rd_cmd_delay.weight_zero_delay  == 8;
      axi_cfg[0].rd_cmd_delay.weight_short_delay == 1;
      axi_cfg[0].rd_cmd_delay.weight_long_delay  == 1;

      axi_cfg[1].rd_cmd_delay.min_delay          == 0;
      axi_cfg[1].rd_cmd_delay.max_delay          == 10;
      axi_cfg[1].rd_cmd_delay.weight_zero_delay  == 8;
      axi_cfg[1].rd_cmd_delay.weight_short_delay == 1;
      axi_cfg[1].rd_cmd_delay.weight_long_delay  == 1;
    }
  }

  constraint c_read_data_delay {
    if (`TVIP_EN_RDATA_DELAY) {
      axi_cfg[0].read_data_delay.min_delay          == 0;
      axi_cfg[0].read_data_delay.max_delay          == 10;
      axi_cfg[0].read_data_delay.weight_zero_delay  == 8;
      axi_cfg[0].read_data_delay.weight_short_delay == 1;
      axi_cfg[0].read_data_delay.weight_long_delay  == 1;

      axi_cfg[1].read_data_delay.min_delay          == 0;
      axi_cfg[1].read_data_delay.max_delay          == 10;
      axi_cfg[1].read_data_delay.weight_zero_delay  == 8;
      axi_cfg[1].read_data_delay.weight_short_delay == 1;
      axi_cfg[1].read_data_delay.weight_long_delay  == 1;
    }
  }
  
  constraint c_wr_cmd_delay {
    if (`TVIP_EN_WR_CMD_DELAY) {
      axi_cfg[0].wr_cmd_delay.min_delay          == 0;
      axi_cfg[0].wr_cmd_delay.max_delay          == 10;
      axi_cfg[0].wr_cmd_delay.weight_zero_delay  == 8;
      axi_cfg[0].wr_cmd_delay.weight_short_delay == 1;
      axi_cfg[0].wr_cmd_delay.weight_long_delay  == 1;

      axi_cfg[1].wr_cmd_delay.min_delay          == 0;
      axi_cfg[1].wr_cmd_delay.max_delay          == 10;
      axi_cfg[1].wr_cmd_delay.weight_zero_delay  == 8;
      axi_cfg[1].wr_cmd_delay.weight_short_delay == 1;
      axi_cfg[1].wr_cmd_delay.weight_long_delay  == 1;
    }
  }

  constraint c_write_data_delay {
    if (`TVIP_EN_WDATA_DELAY) {
      axi_cfg[0].write_data_delay.min_delay          == 0;
      axi_cfg[0].write_data_delay.max_delay          == 10;
      axi_cfg[0].write_data_delay.weight_zero_delay  == 8;
      axi_cfg[0].write_data_delay.weight_short_delay == 1;
      axi_cfg[0].write_data_delay.weight_long_delay  == 1;

      axi_cfg[1].write_data_delay.min_delay          == 0;
      axi_cfg[1].write_data_delay.max_delay          == 10;
      axi_cfg[1].write_data_delay.weight_zero_delay  == 8;
      axi_cfg[1].write_data_delay.weight_short_delay == 1;
      axi_cfg[1].write_data_delay.weight_long_delay  == 1;
    }
  }

  constraint c_response_delay {
    if (`TVIP_EN_RESP_DELAY) {
      axi_cfg[0].response_delay.min_delay          == 0;
      axi_cfg[0].response_delay.max_delay          == 10;
      axi_cfg[0].response_delay.weight_zero_delay  == 8;
      axi_cfg[0].response_delay.weight_short_delay == 1;
      axi_cfg[0].response_delay.weight_long_delay  == 1;

      axi_cfg[1].response_delay.min_delay          == 0;
      axi_cfg[1].response_delay.max_delay          == 10;
      axi_cfg[1].response_delay.weight_zero_delay  == 8;
      axi_cfg[1].response_delay.weight_short_delay == 1;
      axi_cfg[1].response_delay.weight_long_delay  == 1;
    }
  }

  constraint c_response_weight {
    if(`TVIP_EN_ERROR_RESP) {
      axi_cfg[1].response_weight_okay         == 6;
      axi_cfg[1].response_weight_exokay       == 0;
      axi_cfg[1].response_weight_slave_error  == 1;
      axi_cfg[1].response_weight_decode_error == 1;
    }
  }

  constraint c_response_ordering {
    if (`TVIP_AXI_RESP_ORDER_EN || `TVIP_RDATA_INTERLEAVE_EN) {
      axi_cfg[1].response_ordering == TVIP_AXI_OUT_OF_ORDER;
    }
    else {
      axi_cfg[1].response_ordering == TVIP_AXI_IN_ORDER;
    }
  }

  constraint c_read_interleave {
    if (`TVIP_RDATA_INTERLEAVE_EN) {
      axi_cfg[1].enable_response_interleaving == 1;
    }
    else {
      axi_cfg[1].enable_response_interleaving == 0;
    }
  }

  function new(string name = "tvip_axi_sample_configuration");
    super.new(name);
    axi_cfg[0]  = tvip_axi_configuration::type_id::create("axi_cfg[0]");
    axi_cfg[1]  = tvip_axi_configuration::type_id::create("axi_cfg[1]");
  endfunction

  function void pre_randomize();
  endfunction

  `uvm_object_utils_begin(tvip_axi_sample_configuration)
    `uvm_field_sarray_object(axi_cfg, UVM_DEFAULT)
  `uvm_object_utils_end
endclass
`endif
