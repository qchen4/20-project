`ifndef SKY_AXI_MASTER_SLAVE_SAMPLE_TEST_SVH
`define SKY_AXI_MASTER_SLAVE_SAMPLE_TEST_SVH

//--- each channel use random delay
class sky_axi_master_slave_sample_test extends tue_test #(
  .CONFIGURATION  (tvip_axi_sample_configuration)
);

  uvm_event_pool                    events;     //event pool for this testcase

  sky_axi_master_slave_test_env     env;
  tvip_axi_mas_vif                  mas_vif;
  tvip_axi_slv_vif                  slv_vif;

  sky_axi_slave_virtual_sequence    slv_v_seq;
  sky_axi_slave_r_base_sequence     slv_r_seq;
  sky_axi_slave_w_base_sequence     slv_w_seq;


  sky_axi_master_wr_sequence        mas_seq;

  function new(string name = "sky_axi_master_slave_sample_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info("SRANDOM", $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction


  //create_configuration() will be called by apply_config_settings(), which is defined in tue_component_base. 
  //apply_config_settings() is a uvm build-in function in uvm_component, will be called in build_phase when super.build() is called.
  virtual function void create_configuration();
    super.create_configuration();

    void'(uvm_config_db #(tvip_axi_mas_vif)::get(null, "", "mas_vif", mas_vif));
    void'(uvm_config_db #(tvip_axi_slv_vif)::get(null, "", "slv_vif", slv_vif));
    configuration.axi_cfg[0].mas_vif = mas_vif;
    configuration.axi_cfg[0].slv_vif = slv_vif;
    configuration.axi_cfg[0].name    = "axi_master";

    configuration.axi_cfg[1].mas_vif = mas_vif;
    configuration.axi_cfg[1].slv_vif = slv_vif;
    configuration.axi_cfg[1].name    = "axi_slave";

    if (configuration.randomize()) begin
      `uvm_info(get_name(), $sformatf("configuration...\n%s", configuration.sprint()), UVM_NONE)
    end
    else begin
      `uvm_fatal(get_name(), "test env configuration randomization failed !!")
    end

    configuration.axi_cfg[0].is_active  = 1;
    configuration.axi_cfg[1].is_active  = 1;

    configuration.axi_cfg[0].has_coverage=1;
    configuration.axi_cfg[1].has_coverage=1;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = sky_axi_master_slave_test_env::type_id::create("env", this);
    events = new("axi_events");
    configuration.axi_cfg[0].events = events;
    configuration.axi_cfg[1].events = events;

    env.mas_cfg = configuration.axi_cfg[0];
    env.slv_cfg = configuration.axi_cfg[1];

    slv_v_seq = sky_axi_slave_virtual_sequence::type_id::create("slv_r_seq");
    slv_r_seq = sky_axi_slave_r_base_sequence::type_id::create("slv_r_seq");
    slv_w_seq = sky_axi_slave_w_base_sequence::type_id::create("slv_w_seq");

    slv_v_seq.read_seq = slv_r_seq;   //pass sequence instance to lower sequence object handle
    slv_v_seq.write_seq= slv_w_seq;
    mas_seq   = sky_axi_master_wr_sequence::type_id::create("mas_seq");
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    env.slave.maps.set_map(0, (1*1024*1024-1));
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    fork
      slv_v_seq.start(env.slave.v_sqr);
      mas_seq.start(env.master.sequencer);
    join_any

    repeat(100) @(mas_vif.master_cb);
    phase.drop_objection(this);
  endtask

  `uvm_component_utils(sky_axi_master_slave_sample_test)
endclass
`endif
