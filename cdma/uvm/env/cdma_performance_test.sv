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

class cdma_performance_test #(uint32 xsize=31, ysize=31, rd_cmd_dly=0, rd_data_dly=0, wr_cmd_dly=0, wr_data_dly=0, wr_resp_dly=0) 
extends cdma_dma_test1;

    `uvm_component_param_utils(cdma_performance_test#(xsize, ysize, rd_cmd_dly, rd_data_dly, wr_cmd_dly, wr_data_dly, wr_resp_dly))

    function new(string name = "cdma_performance_test", uvm_component parent = null);
        super.new(name, parent);
        cdma_cmd_base_sequence::type_id::set_type_override(cdma_dma_seq1::get_type());
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        //modify some value settings for this performance test
        env_ctl.xsize_min       = xsize;
        env_ctl.xsize_max       = xsize;
        env_ctl.ysize_min       = ysize;
        env_ctl.ysize_max       = ysize;
        env_ctl.sar_offset      = 0;
        env_ctl.dar_offset      = 0;
        env_ctl.sa_ystep_offset = 0;
        env_ctl.da_ystep_offset = 0;
        env_ctl.en_offset_constraint = 1;
        env_ctl.en_intr         = 1;

        //modify delay value to configuration to value need be tested
        //only modify value related to axi slave agent
        axi_mas_slv_cfg.axi_cfg[1].rd_cmd_delay.max_delay   = rd_cmd_dly;
        axi_mas_slv_cfg.axi_cfg[1].rd_cmd_delay.min_delay   = rd_cmd_dly;
        axi_mas_slv_cfg.axi_cfg[1].read_data_delay.max_delay= rd_data_dly;
        axi_mas_slv_cfg.axi_cfg[1].read_data_delay.min_delay= rd_data_dly;
        axi_mas_slv_cfg.axi_cfg[1].wr_cmd_delay.max_delay   = wr_cmd_dly;
        axi_mas_slv_cfg.axi_cfg[1].wr_cmd_delay.min_delay   = wr_cmd_dly;
        axi_mas_slv_cfg.axi_cfg[1].write_data_delay.max_delay= wr_data_dly;
        axi_mas_slv_cfg.axi_cfg[1].write_data_delay.min_delay= wr_data_dly;
        axi_mas_slv_cfg.axi_cfg[1].response_delay.max_delay =  wr_resp_dly;
        axi_mas_slv_cfg.axi_cfg[1].response_delay.min_delay =  wr_resp_dly;
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask : run_phase

endclass : cdma_performance_test


class cdma_x16y16_r16w4_performance_test extends cdma_performance_test#(.xsize(15), .ysize(15), .rd_cmd_dly(1), .rd_data_dly(15), 
                                                                        .wr_cmd_dly(1), .wr_data_dly(3), .wr_resp_dly(0));

  function new(string name = "cdma_x16y16_r16w4_performance_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_name, $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction

  `uvm_component_utils(cdma_x16y16_r16w4_performance_test)    

endclass : cdma_x16y16_r16w4_performance_test



class cdma_x8KBy16_r16w4_performance_test extends cdma_performance_test#(.xsize(8*1024-1), .ysize(15), .rd_cmd_dly(1), .rd_data_dly(15), 
                                                                        .wr_cmd_dly(1), .wr_data_dly(3), .wr_resp_dly(0));

  function new(string name = "cdma_x8KBy16_r16w4_performance_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_name, $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction

  `uvm_component_utils(cdma_x8KBy16_r16w4_performance_test)    

endclass : cdma_x8KBy16_r16w4_performance_test


class cdma_x8KBy16_r64w4_performance_test extends cdma_performance_test#(.xsize(8*1024-1), .ysize(15), .rd_cmd_dly(1), .rd_data_dly(63), 
                                                                        .wr_cmd_dly(1), .wr_data_dly(3), .wr_resp_dly(0));

  function new(string name = "cdma_x8KBy16_r64w4_performance_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_name, $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction

  `uvm_component_utils(cdma_x8KBy16_r64w4_performance_test)    

endclass : cdma_x8KBy16_r64w4_performance_test


class cdma_x8KBy16_r16w16_performance_test extends cdma_performance_test#(.xsize(8*1024-1), .ysize(15), .rd_cmd_dly(1), .rd_data_dly(15), 
                                                                        .wr_cmd_dly(1), .wr_data_dly(15), .wr_resp_dly(0));

  function new(string name = "cdma_x8KBy16_r16w16_performance_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_name, $sformatf("Initial random seed: %0d", $get_initial_random_seed), UVM_NONE)
  endfunction

  `uvm_component_utils(cdma_x8KBy16_r16w16_performance_test)    

endclass : cdma_x8KBy16_r16w16_performance_test

