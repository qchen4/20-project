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

class cdma_dma_rand_seq extends cdma_cmd_base_sequence;

    `uvm_object_utils(cdma_dma_rand_seq)

    function new(string name = "cdma_dma_rand_seq");
		super.new(name);
	endfunction

    virtual task body();
        dma_cmd_group       cmd     ;
        dma_cmd_resp        resp    ;
        int                 cmd_cnt=0;

        if(cdma_rm == null) begin
            `uvm_fatal(get_name(), $sformatf("cdma_rm is null. Must pass in before use."));
        end

        if(env_ctl == null) begin
            `uvm_fatal(get_name(), $sformatf("env_ctl is null. Must pass in before use."));
        end
        

        `uvm_info(get_name(), "begin DMA cmd sequence.", UVM_LOW)
        for(int i=0; i<10; i++) begin
        //for(int i=0; i<20; i++) begin
            //send 1 DMA command
            `uvm_create(cmd)
            cmd.env_ctl = env_ctl;
            `uvm_rand_send(cmd)
            `uvm_info(get_name(), "send a DMA cmd.", UVM_LOW)
            get_response(resp);

            cmd_cnt ++;
        end

        //--- report
        `uvm_info(get_name(), $sformatf("Sequence send %0d 2D DMA command groups.", cmd_cnt), UVM_LOW)

    endtask : body
    

endclass : cdma_dma_rand_seq




class cdma_dma_rand_test extends cdma_base_test;

    `uvm_component_utils(cdma_dma_rand_test)

    function new(string name = "cdma_dma_rand_test", uvm_component parent = null);
        super.new(name, parent);
        cdma_cmd_base_sequence::type_id::set_type_override(cdma_dma_rand_seq::get_type());
    endfunction


    virtual function void build_phase(uvm_phase phase);
        int     segment_size = 1<<20;
        super.build_phase(phase);

        `uvm_info(get_name(), $sformatf("Run to build_phase of %s.", get_name()), UVM_LOW)

        env_ctl.src_beg_addr    = 32'h0;                                    //DMA copy source begin address, include this addr
        env_ctl.src_end_addr    = env_ctl.src_beg_addr + segment_size - 1;  //DMA copy source end address, include this addr
        env_ctl.des_beg_addr    = 2 * segment_size;                         //DMA copy destination begin address, include this addr
        env_ctl.des_end_addr    = env_ctl.des_beg_addr + segment_size - 1;  //DMA copy destination end address, include this addr
        env_ctl.cmd_beg_addr    = 4 * segment_size;                         //DMA cmd buffer begin address, include this addr
        env_ctl.cmd_end_addr    = env_ctl.cmd_beg_addr + segment_size - 1;  //DMA cmd buffer end address, include this addr

        env_ctl.xsize_min       = 3;
        env_ctl.xsize_max       = (1<<16) - 1;
        env_ctl.ysize_min       = 0;
        env_ctl.ysize_max       = (1<<16) - 1;
        env_ctl.sa_ystep_min    = 0;
        env_ctl.sa_ystep_max    = (1<<16) - 1;
        env_ctl.da_ystep_min    = 0;
        env_ctl.da_ystep_max    = (1<<16) - 1;
        env_ctl.sar_offset      = 0;
        env_ctl.dar_offset      = 0;
        env_ctl.sa_ystep_offset = 0;
        env_ctl.da_ystep_offset = 0;
        env_ctl.en_offset_constraint = 0;
        env_ctl.en_intr         = 1;
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_name(), $sformatf("Run to run_phase of %s.", get_name()), UVM_LOW)
        super.run_phase(phase);
    endtask : run_phase

endclass : cdma_dma_rand_test

