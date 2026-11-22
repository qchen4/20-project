`ifndef TVIP_AXI_DEFINES_SVH
`define TVIP_AXI_DEFINES_SVH

`define TVIP_AXI_MAX_ID_WIDTH       4

`define TVIP_AXI_MAX_ADDRESS_WIDTH  32

`define TVIP_AXI_MAX_DATA_WIDTH     32

`define TVIP_AXI_RESP_ORDER_EN      1 //0: in order resp; 1: out of order resp

`define TVIP_RDATA_INTERLEAVE_EN    1 //0:disable read data interleave; 1:enable

`define TVIP_MAX_OUTSTANDING        8 //1 ~ N


`define TVIP_MAX_BURST_LENGTH     16    //maximal burst length for all the axi burst
`define TVIP_EN_RD_CMD_DELAY      1     //enable delay on read cmd
`define TVIP_EN_WR_CMD_DELAY      1     //enable delay on write cmd
`define TVIP_EN_RDATA_DELAY       1     //enable delay on read data
`define TVIP_EN_WDATA_DELAY       1     //enbale delay on write data
`define TVIP_EN_RESP_DELAY        1     //enable delay on write response
`define TVIP_EN_ERROR_RESP        0     //enable error response
`define TVIP_READY_WAIT_VALID     0     //enable ready=1 will wait until valid=1 in handshake of each channel
`define TVIP_WDATA_WAIT_CMD       1     //enable wready=1 will wait until write cmd channel handshke finish

//For read, if set to 1, only first read data beat has cycle delay before rvalid=1, related to acception of this read burst cmd;
//if set to 0, every read data beat has cycle delay before rvalid=1 for each data beat;
//For write, if set to 1, only first write data beat has cycle delay before wready=1, may/may not related to acception of this write burst cmd;
//if set to 0, every write data beat has cycle delay before wready=1 for each data beat;
`define TVIP_DATA_DELAY_ONLY_FIRST_BEAT 1

`define TVIP_DATA_CYC_LOG         1     //1: log cycle number for each data beat of RW trans

`endif

