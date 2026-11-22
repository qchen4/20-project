`ifndef SKY_AXI_SAMPLE_TEST_PKG_SV
`define SKY_AXI_SAMPLE_TEST_PKG_SV
package sky_axi_sample_test_pkg;
  import  uvm_pkg::*;
  import  tue_pkg::*;
  import  tvip_axi_types_pkg::*;
  import  tvip_sky_axi_pkg::*;

  `include  "uvm_macros.svh"
  `include  "tue_macros.svh"

  `include  "sky_axi_master_slave_test_env.svh"
  `include  "tvip_axi_sample_configuration.svh"
  `include  "sky_axi_master_slave_sample_test.svh"
  `include  "sky_axi_master_slave_delay_test.svh"
endpackage
`endif
