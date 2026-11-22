
class cdma_axi_coverage extends uvm_component;

  //analysis port to receive axi items
  uvm_analysis_imp #(tvip_axi_item, cdma_axi_coverage) item_import;

  `uvm_component_utils(cdma_axi_coverage)

  //cover each item
  covergroup cover_item with function sample(tvip_axi_item item);
    option.per_instance = 1;

    rw_type: coverpoint item.access_type {
      bins read = {TVIP_AXI_READ_ACCESS};
      bins write= {TVIP_AXI_WRITE_ACCESS};
    }

    burst_length_incr: coverpoint item.burst_length iff(item.burst_type == TVIP_AXI_INCREMENTING_BURST) {
      bins burst_length_incr[] = {[1 : `TVIP_MAX_BURST_LENGTH]};
    }

    memory_type: coverpoint item.memory_type;

    id:   coverpoint item.id {
        bins id_0 = {0};
        bins id_1 = {1};
    }

    cross_rw_burst_length_incr: cross rw_type, burst_length_incr;
    cross_rw_memory_type:       cross rw_type, memory_type;
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


endclass : cdma_axi_coverage

