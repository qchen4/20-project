`ifndef SKY_AXI_SLAVE_WRITE_AGENT_SVH
`define SKY_AXI_SLAVE_WRITE_AGENT_SVH

class sky_axi_slave_write_agent extends tue_agent #(
  .CONFIGURATION        (tvip_axi_configuration ),
  .STATUS               (tvip_axi_status        ) 
);

  `uvm_component_utils(sky_axi_slave_write_agent)
  `tue_component_default_constructor(sky_axi_slave_write_agent)
  
  protected mailbox_slv               drv2mem   ;   //much better if put this mailbox handle in VIP user component
  protected mailbox_slv               mem2drv   ;   //much better if put this mailbox handle in VIP user component
  sky_axi_slave_write_driver driver   ;
  sky_axi_slave_sequencer   sequencer ;
  sky_axi_slave_mem         mem       ;             //much better if put this memory model in VIP user component

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv2mem = new(`TVIP_MAX_OUTSTANDING);
    mem2drv = new(`TVIP_MAX_OUTSTANDING);
    driver  = sky_axi_slave_write_driver::type_id::create("driver", this);
    sequencer=sky_axi_slave_sequencer::type_id::create("sequencer", this);
    mem     = sky_axi_slave_mem::type_id::create("mem", this);

    driver.set_configuration(configuration);
    sequencer.set_configuration(configuration);
    mem.set_configuration(configuration);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.drv2mem  = drv2mem;      //pass mailbox instance pointor
    driver.mem2drv  = mem2drv;
    mem.drv2mem     = drv2mem;
    mem.mem2drv     = mem2drv;
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction

endclass : sky_axi_slave_write_agent


`endif
