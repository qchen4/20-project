`ifndef SKY_AXI_MASTER_AGENT_SVH
`define SKY_AXI_MASTER_AGENT_SVH

class sky_axi_master_agent extends tue_agent #(
  .CONFIGURATION        (tvip_axi_configuration ),
  .STATUS               (tvip_axi_status        ) 
);

  `uvm_component_utils(sky_axi_master_agent)
  `tue_component_default_constructor(sky_axi_master_agent)
  
  //analysis port output received axi items
  uvm_analysis_port #(tvip_axi_item) out_monitor_port; 

  sky_axi_master_driver                 driver    ;
  sky_axi_master_sequencer              sequencer ;
  sky_axi_mas_monitor                   monitor   ;
  sky_axi_coverage                      coverage  ;


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    monitor = sky_axi_mas_monitor::type_id::create("monitor", this);
    monitor.set_configuration(configuration);

    if(configuration.is_active) begin
        driver  = sky_axi_master_driver::type_id::create("driver", this);
        sequencer=sky_axi_master_sequencer::type_id::create("sequencer", this);

        driver.set_configuration(configuration);
        sequencer.set_configuration(configuration);
    end

    if(configuration.has_coverage) begin
        coverage= sky_axi_coverage::type_id::create("coverage", this);
        coverage.set_configuration(configuration);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if(configuration.is_active)
        driver.seq_item_port.connect(sequencer.seq_item_export);

    out_monitor_port = monitor.out_monitor_port;

    if(configuration.has_coverage)
        out_monitor_port.connect(coverage.item_import);
  endfunction

endclass : sky_axi_master_agent


`endif
