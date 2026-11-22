`ifndef SKY_AXI_MASTER_DEFAULT_SEQUENCE_SVH
`define SKY_AXI_MASTER_DEFAULT_SEQUENCE_SVH

class sky_axi_master_default_sequence extends uvm_sequence #(
  .REQ    (tvip_axi_master_item  ), 
  .RSP    (tvip_axi_master_item  )
);

  `uvm_object_utils(sky_axi_master_default_sequence)
  `uvm_declare_p_sequencer(sky_axi_master_sequencer)

  tvip_axi_configuration    cfg ;

  // Function: new
  // Constructor of object.
  function new(string name="sky_axi_master_default_sequence");
    super.new(name);
  endfunction

  // Task: pre_start
  // UVM built-in method.
  virtual task pre_start();
    void'($cast(cfg, p_sequencer.get_configuration()));
  endtask  

  virtual task body();
    tvip_axi_master_item  resp;

    for(int i=0; i<100; i++) begin
      `uvm_create(req);             //req is defined in uvm_sequence
      req.set_configuration(cfg);   //req item need configuration to constraint the randomize()

      if(!req.randomize()) begin
        `uvm_fatal("sky_axi_master_default_sequence", "axi master item randomize error.")
      end else begin
        `uvm_send(req);

        if(req.need_response) begin
          get_response(resp);
        end
      end
    end
  endtask : body

endclass : sky_axi_master_default_sequence


`endif
