`ifndef TVIP_SKY_AXI_PKG_SV
`define TVIP_SKY_AXI_PKG_SV

`include  "tvip_axi_types_pkg.sv"
`include  "tvip_axi_if.sv"

package tvip_sky_axi_pkg;
  import  uvm_pkg::*;
  import  tue_pkg::*;
  import  sky_base_pkg::*;
  import  tvip_common_pkg::*;
  import  tvip_axi_types_pkg::*;

  typedef virtual tvip_axi_mas_if tvip_axi_mas_vif;
  typedef virtual tvip_axi_slv_if tvip_axi_slv_vif;

  `include  "uvm_macros.svh"
  `include  "tue_macros.svh"
  `include  "tvip_common_macros.svh"

  `include  "tvip_axi_internal_macros.svh"
  `include  "tvip_axi_configuration.svh"
  `include  "tvip_axi_status.svh"
  `include  "tvip_axi_item.svh"
  `include  "sky_rand_ctrl.svh"

  //slave/master common component
  `include  "sky_axi_coverage.svh"
  //`include  "sky_axi_monitor_common.svh"
  `include  "sky_axi_mas_monitor.svh"
  `include  "sky_axi_slv_monitor.svh"

  //master agent
  `include  "sky_axi_master_driver.svh"
  `include  "sky_axi_master_sequencer.svh"
  `include  "sky_axi_master_agent.svh"
  `include  "sky_axi_master_default_sequence.svh"
  `include  "sky_axi_master_wr_sequence.svh"

  //slave agent
  `include  "sky_axi_slave_read_driver.svh"
  `include  "sky_axi_slave_mem.svh"
  `include  "sky_axi_slave_sequencer.svh"
  `include  "sky_axi_slave_read_agent.svh"
  `include  "sky_axi_slave_write_driver.svh"
  `include  "sky_axi_slave_write_agent.svh"
  `include  "sky_axi_slave_virtual_sequencer.svh"
  `include  "sky_axi_slave_agent.svh"
  `include  "sky_axi_slave_default_sequence.svh"
  `include  "sky_axi_slave_rw_sequence_lib.svh"
  `include  "sky_axi_slave_virtual_sequence.svh"


  `include  "tvip_axi_undef_internal_macros.svh"
endpackage
`endif
