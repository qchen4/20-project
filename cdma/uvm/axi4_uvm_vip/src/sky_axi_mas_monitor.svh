`ifndef SKY_AXI_MAS_MONITOR_SVH
`define SKY_AXI_MAS_MONITOR_SVH

class sky_axi_mas_monitor extends tue_monitor #(
  .CONFIGURATION (tvip_axi_configuration),
  .STATUS        (tvip_axi_status       )
);

  //analysis port output received axi items
  uvm_analysis_port #(tvip_axi_item) out_monitor_port;

  tvip_axi_mas_vif  vif;
  //axi read part var
  tvip_axi_item     axi_read[tvip_axi_id][$]; //hash-array, each entry is a queue

  //axi write part var
  tvip_axi_item     axi_waddr[$];
  tvip_axi_item     axi_wdata[$];
  bit               wd_in_a_burst;            //1: wdata handshake is in a burst; 0: next wdata is the first beat of a burst

  `uvm_component_utils(sky_axi_mas_monitor)
  `tue_component_default_constructor(sky_axi_mas_monitor)


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    out_monitor_port = new("out_monitor_port", this);
  endfunction

  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);
    vif = configuration.mas_vif;
  endfunction

  `include "sky_axi_monitor_common.svh"

endclass : sky_axi_mas_monitor

`endif
