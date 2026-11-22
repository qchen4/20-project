`ifndef SKY_AXI_SLAVE_AGENT_SVH
`define SKY_AXI_SLAVE_AGENT_SVH

class sky_axi_slave_agent extends tue_agent #(
  .CONFIGURATION        (tvip_axi_configuration ),
  .STATUS               (tvip_axi_status        ) 
);

  `uvm_component_utils(sky_axi_slave_agent)
  `tue_component_default_constructor(sky_axi_slave_agent)

  //analysis port output received axi items
  uvm_analysis_port #(tvip_axi_item) out_monitor_port; 

  sky_axi_slave_read_agent              read_agent  ;
  sky_axi_slave_write_agent             write_agent ;
  sky_axi_slave_virtual_sequencer       v_sqr       ;
  sky_axi_slv_monitor                   monitor     ;
  sky_addr_maps                         maps        ;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    read_agent  = sky_axi_slave_read_agent::type_id::create("read_agent", this);
    write_agent = sky_axi_slave_write_agent::type_id::create("write_agent", this);
    v_sqr       = sky_axi_slave_virtual_sequencer::type_id::create("v_sqr", this);
    monitor     = sky_axi_slv_monitor::type_id::create("monitor", this);
    maps        = sky_addr_maps::type_id::create("axi_slv_maps");

    read_agent.set_configuration(configuration);
    write_agent.set_configuration(configuration);
    v_sqr.set_configuration(configuration);
    monitor.set_configuration(configuration);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    v_sqr.write_sqr = write_agent.sequencer;
    v_sqr.read_sqr  = read_agent.sequencer;

    read_agent.driver.maps  = maps;
    write_agent.driver.maps = maps;

    out_monitor_port= monitor.out_monitor_port;
  endfunction

endclass : sky_axi_slave_agent


`endif
