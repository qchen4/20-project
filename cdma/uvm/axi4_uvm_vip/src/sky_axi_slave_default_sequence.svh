`ifndef SKY_AXI_SLAVE_DEFAULT_SEQUENCE_SVH
`define SKY_AXI_SLAVE_DEFAULT_SEQUENCE_SVH

class sky_axi_slave_default_sequence extends uvm_sequence #(
  .REQ    (tvip_axi_slave_item  ), 
  .RSP    (tvip_axi_slave_item  )
);

  `uvm_object_utils(sky_axi_slave_default_sequence)
  `uvm_declare_p_sequencer(sky_axi_slave_sequencer)

  tvip_axi_configuration    cfg ;
  tvip_axi_access_type      rw  = TVIP_AXI_READ_ACCESS;

  // Function: new
  // Constructor of object.
  function new(string name="sky_axi_slave_default_sequence");
    super.new(name);
  endfunction

  // Task: pre_start
  // UVM built-in method.
  virtual task pre_start();
    if( !($cast(cfg, p_sequencer.get_configuration())) )
      `uvm_fatal("pre_start", "slave sequence get configuration error.")
  endtask  

  virtual task body();
    tvip_axi_slave_item resp;

    forever begin
      `uvm_create(req);   //req is defined in uvm_sequence
      req.set_configuration(cfg);     //req need use configuration to constraint the randomize()

      //cfg.print();

      if(!req.randomize() with {
                burst_length== cfg.max_burst_length;  //maximal array size to make sure hold the info of any burst;
                                                      //will modify to real burst length after read cmd channel handshake ended;
                access_type == rw;

                //foreach(response[i]) {
                //  response[i] == TVIP_AXI_OKAY;
                //}
              }
        ) begin
        `uvm_fatal("sky_axi_slave_default_sequence", "axi slave item randomize error.")
      end else begin
        `uvm_send(req);

        if(req.need_response)
          get_response(resp);
      end
    end
  endtask : body

endclass : sky_axi_slave_default_sequence

`endif
