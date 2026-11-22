`ifndef SKY_AXI_MASTER_SLAVE_TEST_ENV_SVH
`define SKY_AXI_MASTER_SLAVE_TEST_ENV_SVH

class sky_axi_master_slave_test_env extends uvm_env;

  `uvm_component_utils(sky_axi_master_slave_test_env)
  `tue_component_default_constructor(sky_axi_master_slave_test_env)
  
  sky_axi_slave_agent     slave     ;
  sky_axi_master_agent    master    ;
  tvip_axi_configuration  slv_cfg   ;
  tvip_axi_configuration  mas_cfg   ;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    master  = sky_axi_master_agent::type_id::create("master", this);
    slave   = sky_axi_slave_agent::type_id::create("slave", this);

    master.set_configuration(mas_cfg);
    slave.set_configuration(slv_cfg);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

endclass : sky_axi_master_slave_test_env


`endif
