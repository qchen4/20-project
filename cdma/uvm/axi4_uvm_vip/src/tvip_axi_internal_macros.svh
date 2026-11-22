`ifndef TVIP_AXI_INTERNAL_MACROS_SVH
`define TVIP_AXI_INTERNAL_MACROS_SVH

//bit[31:12]='0
//bit[11:0]: burst_size align bits are '0, other bits are '1
`define tvip_axi_4kb_boundary_mask(BURST_SIZE) \
(tvip_axi_address'('h1000 - BURST_SIZE))

`endif
