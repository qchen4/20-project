`timescale 1ns/100ps

`include "sim_define.svh"

module tb();
  
  import  uvm_pkg::*;
  import  sky_base_pkg::*;
  import  tue_pkg::*;
  import  tvip_axi_types_pkg::*;
  import  tvip_sky_axi_pkg::*;
  import  sky_axi_sample_test_pkg::*;

  logic   aclk, areset_n;

  always #(10.0/2)  aclk = ~aclk;

  //--- 1: sys memory to store data of each axi burst
  sky_sys_mem#(.A_WIDTH(32))    sys_mem;

  //--- 2.1: axi interface instance
  tvip_axi_mas_if axi_mas_if(aclk, areset_n);
  tvip_axi_slv_if axi_slv_if(aclk, areset_n);

  //--- 2.2: connect axi master and slave interface
  //write cmd channel
  assign    axi_slv_if.awvalid  = axi_mas_if.awvalid  ;
  assign    axi_mas_if.awready  = axi_slv_if.awready  ;
  assign    axi_slv_if.awid     = axi_mas_if.awid     ;
  assign    axi_slv_if.awaddr   = axi_mas_if.awaddr   ;
  assign    axi_slv_if.awlen    = axi_mas_if.awlen    ;
  assign    axi_slv_if.awsize   = axi_mas_if.awsize   ;
  assign    axi_slv_if.awburst  = axi_mas_if.awburst  ;
  assign    axi_slv_if.awprot   = axi_mas_if.awprot   ;
  assign    axi_slv_if.awcache  = axi_mas_if.awcache  ;
  assign    axi_slv_if.awqos    = axi_mas_if.awqos    ;

  //write data channel
  assign    axi_slv_if.wvalid   = axi_mas_if.wvalid   ;
  assign    axi_mas_if.wready   = axi_slv_if.wready   ;
  assign    axi_slv_if.wdata    = axi_mas_if.wdata    ;
  assign    axi_slv_if.wstrb    = axi_mas_if.wstrb    ;
  assign    axi_slv_if.wlast    = axi_mas_if.wlast    ;

  //write response channel
  assign    axi_mas_if.bvalid   = axi_slv_if.bvalid   ;
  assign    axi_slv_if.bready   = axi_mas_if.bready   ;
  assign    axi_mas_if.bid      = axi_slv_if.bid      ;
  assign    axi_mas_if.bresp    = axi_slv_if.bresp    ;

  //read cmd channel
  assign    axi_slv_if.arvalid  = axi_mas_if.arvalid  ;
  assign    axi_mas_if.arready  = axi_slv_if.arready  ;
  assign    axi_slv_if.arid     = axi_mas_if.arid     ;
  assign    axi_slv_if.araddr   = axi_mas_if.araddr   ;
  assign    axi_slv_if.arlen    = axi_mas_if.arlen    ;
  assign    axi_slv_if.arsize   = axi_mas_if.arsize   ;
  assign    axi_slv_if.arburst  = axi_mas_if.arburst  ;
  assign    axi_slv_if.arprot   = axi_mas_if.arprot   ;
  assign    axi_slv_if.arcache  = axi_mas_if.arcache  ;
  assign    axi_slv_if.arqos    = axi_mas_if.arqos    ;

  //red data channel
  assign    axi_mas_if.rvalid  = axi_slv_if.rvalid  ;
  assign    axi_slv_if.rready  = axi_mas_if.rready  ;
  assign    axi_mas_if.rid     = axi_slv_if.rid     ;
  assign    axi_mas_if.rdata   = axi_slv_if.rdata   ;
  assign    axi_mas_if.rresp   = axi_slv_if.rresp   ;
  assign    axi_mas_if.rlast   = axi_slv_if.rlast   ;

  //--- 3: initial values and handle connection
  initial begin

    if ($test$plusargs("DUMP_FSDB")) begin
        $display("Sim with fsdb wave dump.");
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, tb);
    end else begin
        $display("Sim without fsdb wave dump.");
    end

    aclk = 0;
    areset_n = 0;

    sys_mem = new();
    axi_slv_if.sys_mem = sys_mem;

    repeat(10) @(posedge aclk);
    areset_n = 1;
  end

  function void uvm_env_glb_setting();
    //chang to print all element in the array
    uvm_default_printer.knobs.begin_elements = -1;
    
  endfunction : uvm_env_glb_setting


  //--- 5: pass vif handle and start a testcase
  initial begin
    $display("Simulation begin.");
    $display("");

    uvm_env_glb_setting();
    uvm_config_db#(tvip_axi_mas_vif)::set(null, "", "mas_vif", axi_mas_if);
    uvm_config_db#(tvip_axi_slv_vif)::set(null, "", "slv_vif", axi_slv_if);
    run_test();
  end

endmodule : tb

