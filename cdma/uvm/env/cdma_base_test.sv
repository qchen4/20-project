// ---------------------------------------------------------------------------//
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from SiliconThink.
//
//      (C) COPYRIGHT SiliconThink Limited or its affiliates
//                   ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from SiliconThink or its affiliates.
// ---------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// File name    : .sv
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
//----------------------------------------------------------------------------//

class cdma_base_test extends uvm_test;

    `uvm_component_utils(cdma_base_test)
    uvm_event_pool                  events          ;   //event pool for this testcase

    dma_env_ctl                     env_ctl         ;
    cdma_cmd_base_sequence          cdma_seq        ;   //will be override by real test sequence
    sky_axi_slave_r_base_sequence   axi_slv_r_seq   ;
    sky_axi_slave_w_base_sequence   axi_slv_w_seq   ; 
    cdma_virtual_sequence           cdma_vseq       ;   //contain cdma/axi_slv sequence

    cdma_env                        env             ;
    
    //apb_mas/axi_slv agent cfg
    amiq_apb_master_agent_config    apb_mas_cfg     ;
    amiq_apb_vif_t                  apb_vif         ;

    tvip_axi_sample_configuration   axi_mas_slv_cfg ;
    tvip_axi_slv_vif                axi_vif         ;


    //for debug
    uvm_factory         factory;

    function new(string name = "cdma_base_test", uvm_component parent = null);
        super.new(name, parent);

        factory = uvm_factory::get();
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        events = new("axi_events");
        uvm_config_db#(uvm_event_pool)::set(this, "*", "events", events);
        

        if(!uvm_config_db#(amiq_apb_vif_t)::get(this, "", "apb_vif", apb_vif)) begin
            `uvm_fatal(get_name(), "No virtual interface set to apb_vif.")
        end

        env_ctl         = dma_env_ctl::type_id::create("env_ctl");
        if(!env_ctl.randomize())
            `uvm_fatal(get_name(), $sformatf("env_ctl randomize failed."))

        uvm_config_db#(dma_env_ctl)::set(this, "env.*", "env_ctl", env_ctl);

        cdma_seq        = cdma_cmd_base_sequence::type_id::create("cdma_seq");
        axi_slv_r_seq   = sky_axi_slave_r_base_sequence::type_id::create("axi_slv_r_seq");
        axi_slv_w_seq   = sky_axi_slave_w_base_sequence::type_id::create("axi_slv_w_seq");
        cdma_vseq       = cdma_virtual_sequence::type_id::create("cdma_vseq");
        env             = cdma_env::type_id::create("env", this);

        //apb master configure
        apb_mas_cfg = amiq_apb_master_agent_config::type_id::create("apb_mas_cfg", this);
        apb_mas_cfg.set_has_coverage(0);
        apb_mas_cfg.set_is_active(UVM_ACTIVE);
        apb_mas_cfg.set_driving_delay(1);
        apb_mas_cfg.set_number_of_slaves(1);
        apb_mas_cfg.set_dut_vif(apb_vif);
        apb_mas_cfg.set_has_error_signal(0);
        apb_mas_cfg.set_en_x_z_checks(0);
        apb_mas_cfg.set_en_protocol_checks(0);
        apb_mas_cfg.set_en_rst_checks(0);
        uvm_config_db#(amiq_apb_agent_config)::set(this, "env.apb_master", "agent_config", apb_mas_cfg);

        //axi slave configure
        axi_mas_slv_cfg = tvip_axi_sample_configuration::type_id::create("axi_mas_slv_cfg", this);
        if(!(uvm_config_db #(tvip_axi_slv_vif)::get(null, "", "axi_vif", axi_vif))) begin
            `uvm_fatal(get_name(), "No virtual interface set to axi_vif.")
        end

        axi_mas_slv_cfg.axi_cfg[0].mas_vif = null;   //for axi master in axi_cfg[0], not used here
        axi_mas_slv_cfg.axi_cfg[0].slv_vif = null;   //for axi slave in axi_cfg[0], not used here

        axi_mas_slv_cfg.axi_cfg[1].mas_vif = null;   //for axi master in axi_cfg[1], not used here
        axi_mas_slv_cfg.axi_cfg[1].slv_vif = axi_vif;//for axi slave in axi_cfg[1]
        axi_mas_slv_cfg.axi_cfg[1].name    = "axi_slave";
        axi_mas_slv_cfg.axi_cfg[1].events = events;

        if (!axi_mas_slv_cfg.randomize()) begin
          `uvm_fatal(get_name(), "axi agent configuration randomization failed !!")
        end else begin
            axi_mas_slv_cfg.axi_cfg[1].is_active    = 1;
            axi_mas_slv_cfg.axi_cfg[1].has_coverage = 0;
            `uvm_info(get_name(), $sformatf("axi slave configuration...\n%s", axi_mas_slv_cfg.axi_cfg[1].sprint()), UVM_NONE)
        end

        env.axi_slv_cfg = axi_mas_slv_cfg.axi_cfg[1];
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        cdma_seq.env_ctl = env_ctl;
        cdma_seq.cdma_rm = env.cdma_rm;
        cdma_vseq.cdma_sqc= cdma_seq;
        cdma_vseq.axi_slv_vsqc.read_seq  = axi_slv_r_seq;
        cdma_vseq.axi_slv_vsqc.write_seq = axi_slv_w_seq;
        env.axi_slave.maps.set_map(env_ctl.src_beg_addr, env_ctl.src_end_addr);
        env.axi_slave.maps.set_map(env_ctl.des_beg_addr, env_ctl.des_end_addr);
        env.axi_slave.maps.set_map(env_ctl.cmd_beg_addr, env_ctl.cmd_end_addr);
    endfunction : connect_phase

    extern virtual function void ini_sys_ref_mem();

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), $sformatf("Run to run_phase of %s.", get_name()), UVM_LOW)
        factory.print(0);   //debug purpose

        //disable all `uvm_info print for APB master agent
        env.apb_master.set_report_verbosity_level_hier(UVM_NONE);

        ini_sys_ref_mem();

        `uvm_info(get_name(), $sformatf("Wait release of axi_vif.areset_n"), UVM_LOW)
        @(posedge axi_vif.areset_n);
        $display("start cdma virtual sequence.");
        cdma_vseq.start(env.cdma_vsqr);
        phase.drop_objection(this);
    endtask : run_phase

endclass : cdma_base_test


//initial DMA copy original address space with random data
function void cdma_base_test::ini_sys_ref_mem();
    sky_sys_mem #(.A_WIDTH(32)) ref_mem = env.scb.ref_mem;
    logic [7:0]     data;

    //initial 
    for(uint64 i=env_ctl.src_beg_addr; i<=env_ctl.src_end_addr; i++) begin
        data = $random();
        ref_mem.write(i, data);
        axi_vif.sys_mem_byte_wr(i, data);
    end

endfunction : ini_sys_ref_mem



