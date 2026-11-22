`ifndef SKY_AXI_SLAVE_VIRTUAL_SEQUENCER_SVH
`define SKY_AXI_SLAVE_VIRTUAL_SEQUENCER_SVH

class sky_axi_slave_virtual_sequencer extends tue_sequencer #(
  .CONFIGURATION        (tvip_axi_configuration ), 
  .STATUS               (tvip_axi_status        ), 
  .REQ                  (tvip_axi_slave_item    ), 
  .RSP                  (tvip_axi_slave_item    ), 
  .PROXY_CONFIGURATION  (tvip_axi_configuration ), 
  .PROXY_STATUS         (tvip_axi_status        ) 
);

  `uvm_component_utils(sky_axi_slave_virtual_sequencer)
  `tue_component_default_constructor(sky_axi_slave_virtual_sequencer)

  sky_axi_slave_sequencer   write_sqr ;
  sky_axi_slave_sequencer   read_sqr  ;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

endclass : sky_axi_slave_virtual_sequencer


`endif
