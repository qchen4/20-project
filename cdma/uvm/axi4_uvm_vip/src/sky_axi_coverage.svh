`ifndef SKY_AXI_COVERAGE_SVH
`define SKY_AXI_COVERAGE_SVH

class sky_axi_coverage extends tue_component #(
  .CONFIGURATION (tvip_axi_configuration),
  .STATUS        (tvip_axi_status       )
);

  //analysis port to receive axi items
  uvm_analysis_imp #(tvip_axi_item, sky_axi_coverage) item_import;

  `uvm_component_utils(sky_axi_coverage)

  //cover each item
  covergroup cover_item with function sample(tvip_axi_item item);
    option.per_instance = 1;

    rw_type: coverpoint item.access_type {
      bins read = {TVIP_AXI_READ_ACCESS};
      bins write= {TVIP_AXI_WRITE_ACCESS};
    }

    burst_type: coverpoint item.burst_type {
      bins incr = {TVIP_AXI_INCREMENTING_BURST};
      bins wrap = {TVIP_AXI_WRAPPING_BURST};
      bins fixed= {TVIP_AXI_FIXED_BURST};
    }

    burst_size: coverpoint $clog2(item.burst_size) {
      bins burst_size[] = {[0 : $clog2(`TVIP_AXI_MAX_DATA_WIDTH >> 3)]};
    }

    burst_length_incr: coverpoint item.burst_length iff(item.burst_type == TVIP_AXI_INCREMENTING_BURST) {
      bins burst_length_incr[] = {[1 : `TVIP_MAX_BURST_LENGTH]};
    }
  
    burst_length_fixed: coverpoint item.burst_length iff(item.burst_type == TVIP_AXI_FIXED_BURST) {
      bins len_small[] = {[1:4]};
      bins len_big     = {[5 : `TVIP_MAX_BURST_LENGTH]};
    }

    burst_length_wrap: coverpoint item.burst_length iff(item.burst_type == TVIP_AXI_WRAPPING_BURST) {
      bins burst_length_wrap[] = {2, 4, 8, 16};
    }


    addr_offset: coverpoint item.address[($clog2(`TVIP_AXI_MAX_DATA_WIDTH >> 3))-1 : 0] {
      bins begin_offset[] = {[0 : ((`TVIP_AXI_MAX_DATA_WIDTH >> 3) -1)]};
    }

    cache: coverpoint item.cache;
    id:   coverpoint item.id;
    protection: coverpoint item.protection;
    memory_type:coverpoint item.memory_type;
  
    cross_rw_burst_size: cross rw_type, burst_size;
    cross_rw_burst_type: cross rw_type, burst_type;
    cross_rw_burst_length_incr: cross rw_type, burst_length_incr;
    cross_rw_burst_length_fixed: cross rw_type, burst_length_fixed;
    cross_rw_burst_length_wrap: cross rw_type, burst_length_wrap;
    cross_rw_cache: cross rw_type, cache;
    cross_rw_protection: cross rw_type, protection;

  endgroup



  function new(string name = "inst", uvm_component parent = null);
    super.new(name, parent);
    cover_item = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_import = new("item_import", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

  endtask


  function void write(tvip_axi_item item);
    cover_item.sample(item);
  endfunction : write


endclass : sky_axi_coverage

`endif
