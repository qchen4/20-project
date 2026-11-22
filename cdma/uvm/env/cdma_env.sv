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

class cdma_env extends uvm_env;

    `uvm_component_utils(cdma_env);

    cdma_cmd_parse_agent    cdma_cmd_gen;
    amiq_apb_master_agent   apb_master  ;
    sky_axi_slave_agent     axi_slave   ;
    tvip_axi_configuration  axi_slv_cfg ;   //no instance, just handle pointer
    cdma_virtual_sequencer  cdma_vsqr   ;
    cdma_reg_model          cdma_rm     ;   //uvm regiser model
    amiq_apb2rm_adapter     apb2rm_adapter;

    cdma_scoreboard         scb         ;
    amiq_apb_user_coverage  apb_cov     ;
    cdma_axi_coverage       axi_cov     ;
    cdma_cmd_coverage       dma_cov     ;

    function new(string name = "cdma_env", uvm_component parent);
		super.new(name, parent);
	endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        cdma_cmd_gen = cdma_cmd_parse_agent::type_id::create("cdma_cmd_gen", this);
        //the configure of apb_master use uvm_config_db
        apb_master = amiq_apb_master_agent::type_id::create("apb_master", this);

        axi_slave = sky_axi_slave_agent::type_id::create("axi_slave", this);
        if(axi_slv_cfg == null) begin
           `uvm_fatal(get_name(), $sformatf("axi_slv_cfg is null. Must pass in before use.")) 
        end else begin
            axi_slave.set_configuration(axi_slv_cfg);
        end

        cdma_vsqr = cdma_virtual_sequencer::type_id::create("cdma_vsqr", this);
        cdma_rm   = cdma_reg_model::type_id::create("cdma_rm", this);
        apb2rm_adapter  = amiq_apb2rm_adapter::type_id::create("apb2rm_adapter");
        apb2rm_adapter.provides_responses = 1;

        scb = cdma_scoreboard::type_id::create("scb", this);

        cdma_rm.configure(null, "");
        cdma_rm.build();
        cdma_rm.lock_model();
        cdma_rm.reset();
        cdma_rm.set_hdl_path_root("tb.u_cdma_top.u_cdma_cfg");

        `ifdef SIM_EN_FUNC_COVERAGE
        apb_cov = amiq_apb_user_coverage::type_id::create("apb_cov", this);
        axi_cov = cdma_axi_coverage::type_id::create("axi_cov", this);
        dma_cov = cdma_cmd_coverage::type_id::create("dma_cov", this);
        `endif
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        //pass instance handle to pointers in sub module
        if(!($cast(cdma_vsqr.cmd_sqr, cdma_cmd_gen.sequencer))) begin
            `uvm_fatal(get_name(), "type $cast fail.")
        end

        if(!($cast(cdma_vsqr.axi_slv_vsqr, axi_slave.v_sqr))) begin
            `uvm_fatal(get_name(), "type $cast fail.")
        end
    
        //method 1: use hierarchy assignment: a.b.c
        //if(!($cast(cdma_cmd_gen.driver.apb_sqr, apb_master.sequencer))) begin
        //    `uvm_fatal(get_name(), "type $cast fail.")
        //end
        
        //method 2: use uvm_config_db
        uvm_config_db#(amiq_apb_sequencer#(amiq_apb_master_drv_item))::set(this, "*", "apb_sqr", apb_master.sequencer);

        cdma_rm.default_map.set_sequencer(apb_master.sequencer, apb2rm_adapter);
        cdma_rm.default_map.set_auto_predict(1);

        cdma_cmd_gen.driver.cmd_group_port.connect(scb.cmd_group_imp);
        axi_slave.monitor.out_monitor_port.connect(scb.axi_mon_imp);

        `ifdef SIM_EN_FUNC_COVERAGE
        apb_master.monitor.output_port.connect(apb_cov.mon2cov);
        axi_slave.monitor.out_monitor_port.connect(axi_cov.item_import);
        cdma_cmd_gen.driver.cmd_group_port.connect(dma_cov.cmd_group_imp);
        `endif
    endfunction

endclass : cdma_env

