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

class dma_env_ctl extends uvm_sequence_item;
    bit [31:0]  src_beg_addr    ;   //DMA copy source begin address, include this addr
    bit [31:0]  src_end_addr    ;   //DMA copy source end address, include this addr
    bit [31:0]  des_beg_addr    ;   //DMA copy destination begin address, include this addr
    bit [31:0]  des_end_addr    ;   //DMA copy destination end address, include this addr
    bit [31:0]  cmd_beg_addr    ;   //DMA cmd buffer begin address, include this addr
    bit [31:0]  cmd_end_addr    ;   //DMA cmd buffer end address, include this addr
    bit [15:0]  xsize_min       ;
    bit [15:0]  xsize_max       ;
    bit [15:0]  ysize_min       ;
    bit [15:0]  ysize_max       ;
    bit [15:0]  sa_ystep_min    ;
    bit [15:0]  sa_ystep_max    ;
    bit [15:0]  da_ystep_min    ;
    bit [15:0]  da_ystep_max    ;

    bit         en_offset_constraint ;
    bit         en_intr         ;  //0: disable intr output; 1: enable intr output
    rand bit [3:0]  sar_offset      ;
    rand bit [3:0]  dar_offset      ;
    rand bit [3:0]  sa_ystep_offset ;
    rand bit [3:0]  da_ystep_offset ;
    ////--- axi slave VIP read/write latency control
    //rand uint32     axi_rd_cmd_dly_min, axi_rd_cmd_dly_max;
    //rand uint32     axi_read_data_dly_min, axi_read_data_dly_max;
    //rand uint32     axi_wr_cmd_dly_min, axi_wr_cmd_dly_max;
    //rand uint32     axi_write_data_dly_min, axi_write_data_dly_max;
    //rand uint32     axi_response_dly_min, axi_response_dly_max;

	function new(string name = "dma_env_ctl");
		super.new(name);
	endfunction

/*
    constraint  axi_rw_dly_value {
        axi_rd_cmd_dly_min  dist {0:/90, [1:8]:/10};
        axi_rd_cmd_dly_max  dist {[0:10]:/90, [11:128]:/10};
        axi_read_data_dly_min dist {0:/90, [1:8]:/10};
        axi_read_data_dly_max dist {[0:10]:/90, [11:128]:/10};
        axi_rd_cmd_dly_max      >= axi_rd_cmd_dly_min;
        axi_read_data_dly_max   >= axi_read_data_dly_min;

        axi_wr_cmd_dly_min dist {0:/90, [1:8]:/10};
        axi_wr_cmd_dly_max dist {[0:10]:/90, [11:128]:/10};
        axi_write_data_dly_min dist {0:/90, [1:8]:/10};
        axi_write_data_dly_max dist {[0:10]:/90, [11:128]:/10};
        axi_response_dly_min dist {0:/90, [1:8]:/10};
        axi_response_dly_max dist {[0:10]:/90, [11:128]:/10};
        axi_wr_cmd_dly_max      >= axi_wr_cmd_dly_min;
        axi_write_data_dly_max  >= axi_write_data_dly_min;
        axi_response_dly_max    >= axi_response_dly_min;
    }
*/

	`uvm_object_utils_begin(dma_env_ctl)
        `uvm_field_int(src_beg_addr,    UVM_ALL_ON)
        `uvm_field_int(src_end_addr,    UVM_ALL_ON)
        `uvm_field_int(des_beg_addr,    UVM_ALL_ON)
        `uvm_field_int(des_end_addr,    UVM_ALL_ON)
        `uvm_field_int(cmd_beg_addr,    UVM_ALL_ON)
        `uvm_field_int(cmd_end_addr,    UVM_ALL_ON)
        `uvm_field_int(xsize_min,       UVM_ALL_ON)
        `uvm_field_int(xsize_max,       UVM_ALL_ON)
        `uvm_field_int(ysize_min,       UVM_ALL_ON)
        `uvm_field_int(ysize_max,       UVM_ALL_ON)
        `uvm_field_int(sa_ystep_min,    UVM_ALL_ON)
        `uvm_field_int(sa_ystep_max,    UVM_ALL_ON)
        `uvm_field_int(da_ystep_min,    UVM_ALL_ON)
        `uvm_field_int(da_ystep_max,    UVM_ALL_ON)
        `uvm_field_int(en_offset_constraint, UVM_ALL_ON)
        `uvm_field_int(en_intr,         UVM_ALL_ON)
        `uvm_field_int(sar_offset,      UVM_ALL_ON)
        `uvm_field_int(dar_offset,      UVM_ALL_ON)
        `uvm_field_int(sa_ystep_offset, UVM_ALL_ON)
        `uvm_field_int(da_ystep_offset, UVM_ALL_ON)
        //`uvm_field_int(axi_rd_cmd_dly_min, UVM_ALL_ON)
        //`uvm_field_int(axi_rd_cmd_dly_max, UVM_ALL_ON)
        //`uvm_field_int(axi_read_data_dly_min, UVM_ALL_ON)
        //`uvm_field_int(axi_read_data_dly_max, UVM_ALL_ON)
        //`uvm_field_int(axi_wr_cmd_dly_min, UVM_ALL_ON)
        //`uvm_field_int(axi_wr_cmd_dly_max, UVM_ALL_ON)
        //`uvm_field_int(axi_write_data_dly_min, UVM_ALL_ON)
        //`uvm_field_int(axi_write_data_dly_max, UVM_ALL_ON)
        //`uvm_field_int(axi_response_dly_min, UVM_ALL_ON)
        //`uvm_field_int(axi_response_dly_max, UVM_ALL_ON)
    `uvm_object_utils_end

endclass : dma_env_ctl

//control of a 2D DMA copy
class dma_cmd_ctl extends uvm_sequence_item;

         dma_env_ctl    env_ctl ;   //pointer only, must pass in before use

    rand bit    [31:0]  sar     ;   //source begin byte address
    rand bit    [31:0]  dar     ;   //destination begin byte address
    rand bit    [15:0]  xsize   ;   //copy xsize, cnt from 0
    rand bit    [15:0]  ysize   ;   //copy ysize, cnt from 0
    rand bit    [15:0]  sa_ystep;   //byte offset between each line at source addr, cnt from 1
    rand bit    [15:0]  da_ystep;   //byte offset between each line at destination addr, cnt from 1
    rand bit    [31:0]  llr     ;   //pointer to next DMA cmd. it's constrained in other block

	function new(string name = "dma_cmd_ctl");
		super.new(name);
	endfunction

    function void pre_randomize();
	    if(env_ctl == null) begin
            `uvm_fatal(get_name(), "class instance env_ctl is NULL.")
        end
	endfunction

    constraint simple_val_range {
        sar         inside  {[env_ctl.src_beg_addr : env_ctl.src_end_addr]};
        dar         inside  {[env_ctl.des_beg_addr : env_ctl.des_end_addr]};
        xsize       inside  {[env_ctl.xsize_min : env_ctl.xsize_max]};
        ysize       inside  {[env_ctl.ysize_min : env_ctl.ysize_max]};
        sa_ystep    inside  {[env_ctl.sa_ystep_min : env_ctl.sa_ystep_max]};
        da_ystep    inside  {[env_ctl.da_ystep_min : env_ctl.da_ystep_max]};
        llr         inside  {[env_ctl.cmd_beg_addr : env_ctl.cmd_end_addr]};
        llr[1:0]    == 2'h0;
    }

    constraint val_rate {
        xsize       dist {[3:15] :/70, [16 : ((1<<12) - 1)] :/20, [(1<<12) : ((1<<16) - 2)] :/8, ((1<<16) - 1) :/2};
        ysize       dist {[0:15] :/70, [16 : ((1<<12) - 1)] :/20, [(1<<12) : ((1<<16) - 2)] :/8, ((1<<16) - 1) :/2};
        sa_ystep    dist {[0:15] :/70, [16 : ((1<<12) - 1)] :/20, [(1<<12) : ((1<<16) - 2)] :/8, ((1<<16) - 1) :/2};
        da_ystep    dist {[0:15] :/70, [16 : ((1<<12) - 1)] :/20, [(1<<12) : ((1<<16) - 2)] :/8, ((1<<16) - 1) :/2};
    }

    constraint addr_offset {
        sar[1:0]    == env_ctl.sar_offset[1:0];
        dar[1:0]    == env_ctl.dar_offset[1:0];
        sa_ystep[1:0] == env_ctl.sa_ystep_offset[1:0];
        da_ystep[1:0] == env_ctl.da_ystep_offset[1:0];
    }

    constraint  dma_source_addr_range {
        (uint64'(sar) + ((uint64'(xsize) + 1 + uint64'(sa_ystep)) * (uint64'(ysize)+1)) ) <= (uint64'(env_ctl.src_end_addr) + 1);
    }

    constraint  dma_desination_addr_range {
        (uint64'(dar) + ((uint64'(xsize) + 1 + uint64'(da_ystep)) * (uint64'(ysize)+1)) ) <= (uint64'(env_ctl.des_end_addr) + 1);
    }

	`uvm_object_utils_begin(dma_cmd_ctl)
        `uvm_field_int(sar,     UVM_ALL_ON)
        `uvm_field_int(dar,     UVM_ALL_ON)
        `uvm_field_int(xsize,   UVM_ALL_ON)
        `uvm_field_int(ysize,   UVM_ALL_ON)
        `uvm_field_int(sa_ystep,UVM_ALL_ON)
        `uvm_field_int(da_ystep,UVM_ALL_ON)
        `uvm_field_int(llr,     UVM_ALL_ON)
        `uvm_field_object(env_ctl, UVM_ALL_ON)
    `uvm_object_utils_end

endclass : dma_cmd_ctl


class dma_cmd_group extends uvm_sequence_item;
         dma_env_ctl    env_ctl     ;       //pointer only, must pass in before use
         bit            status      ;       //0: idle or in process; 1: finished
    rand bit    [31:0]  cmd_num     ;       //cnt from 1
    rand bit    [31:0]  llr_addr[]  ;
    rand tvip_axi_memory_type   mtype_rd;   //axi read channel memory type attribute
    rand tvip_axi_memory_type   mtype_wr;   //axi write channle memory type arrtibute
         tvip_axi_cache         arcache;
         tvip_axi_cache         awcache;
         dma_cmd_ctl    cmds[]      ;

	function new(string name = "dma_cmd_group");
		super.new(name);
        status = 0;
	endfunction

    function void pre_randomize();
	    if(env_ctl == null) begin
            `uvm_fatal(get_name(), "class instance env_ctl is NULL.")
        end
	endfunction

    constraint  val_range {
        //assume maximal value of cmd_num == 255
        cmd_num inside {[1 : ((1<<8) - 1 )]};

        cmd_num dist {[1:8] :/ 60, [9:127] :/30, [128:254] :/ 8, 255 :/2};

        //total byte size for all DMA cmds in a group
        (cmd_num * 6 * 4) <= (env_ctl.cmd_end_addr - env_ctl.cmd_beg_addr + 1);
        llr_addr.size() == cmd_num;
    }

    constraint  llr_addr_range {
        foreach(llr_addr[i]) {
            llr_addr[i][1:0] == 2'h0;
            llr_addr[i] inside {[env_ctl.cmd_beg_addr : env_ctl.cmd_end_addr]};

            //cmd info located in cmd buffer addr space
            (int64'(llr_addr[i]) + 6*4) <= (int64'(env_ctl.cmd_end_addr) + 1);
            
            //no addr overlap between cmds, in accending order
            if(i > 0) {
                (int64'(llr_addr[i]) - int64'(llr_addr[i-1])) >= 4*6;
            }
            
            //--- //each cmd will not across 4KB boundary
            //--- llr_addr[i][11:0] <= (4096 - 4*6);
        }

    }

    function void post_randomize();
        int i;

        arcache = encode_memory_type(mtype_rd, 1);
        awcache = encode_memory_type(mtype_wr, 0);


        cmds = new[cmd_num];
        for(i=0; i<cmd_num; i++) begin
            cmds[i] = dma_cmd_ctl::type_id::create($sformatf("dma_cmd_ctl_%d", i));
            cmds[i].env_ctl = env_ctl;

            cmds[i].addr_offset.constraint_mode(env_ctl.en_offset_constraint);

            assert(cmds[i].randomize())
            else
                `uvm_fatal("dma_cmd_group", "randomize a DMA cmd failed.")

            cmds[i].llr = llr_addr[i];
        end
        cmds[i-1].llr = 0;  //cmd group end flag
    endfunction

    
    `uvm_object_utils_begin(dma_cmd_group)
        `uvm_field_int(status,          UVM_ALL_ON)
        `uvm_field_int(cmd_num,         UVM_ALL_ON)
        `uvm_field_array_int(llr_addr,  UVM_ALL_ON)
        `uvm_field_enum(tvip_axi_memory_type, mtype_rd, UVM_ALL_ON)
        `uvm_field_enum(tvip_axi_memory_type, mtype_wr, UVM_ALL_ON)
        `uvm_field_int(arcache,         UVM_ALL_ON)
        `uvm_field_int(awcache,         UVM_ALL_ON)
        //`uvm_field_array_object(cmds,   UVM_ALL_ON)
    `uvm_object_utils_end

endclass : dma_cmd_group


class dma_cmd_resp extends uvm_sequence_item;
    bit     resp    ;   //0:ok; 1:err


    function new(string name = "dma_cmd_resp");
		super.new(name);
	endfunction

	`uvm_object_utils_begin(dma_cmd_resp)
        `uvm_field_int(resp,    UVM_ALL_ON)
    `uvm_object_utils_end

endclass : dma_cmd_resp


class dma_1d_ctl extends uvm_sequence_item;
    bit     [31:0]  sar ;
    bit     [31:0]  dar ;
    bit             sa_cross_4kb;
    bit             da_cross_4kb;
    bit     [15:0]  sa_byte_len_seg0;   //cnt from 0
    bit     [15:0]  sa_byte_len_seg1;
    bit     [15:0]  da_byte_len_seg0;
    bit     [15:0]  da_byte_len_seg1;
    bit     [15:0]  xsize;              //cnt from 0

    function new(string name = "dma_1d_ctl");
		super.new(name);
	endfunction

	`uvm_object_utils_begin(dma_1d_ctl)
        `uvm_field_int(sar             ,    UVM_ALL_ON)
        `uvm_field_int(dar             ,    UVM_ALL_ON)
        `uvm_field_int(sa_cross_4kb    ,    UVM_ALL_ON)
        `uvm_field_int(da_cross_4kb    ,    UVM_ALL_ON)
        `uvm_field_int(sa_byte_len_seg0,    UVM_ALL_ON)
        `uvm_field_int(sa_byte_len_seg1,    UVM_ALL_ON)
        `uvm_field_int(da_byte_len_seg0,    UVM_ALL_ON)
        `uvm_field_int(da_byte_len_seg1,    UVM_ALL_ON)
        `uvm_field_int(xsize           ,    UVM_ALL_ON)
    `uvm_object_utils_end

endclass : dma_1d_ctl


class bus_rw_chk_item extends uvm_object;
    bit     [31:0]  addr    ;
    bit     [7:0]   data    ;
    bit             rw      ;   //0: read; 1:write
    bit             chk_data;   //0: don't check data, 1: check data

    function new(string name = "bus_rw_chk_item");
		super.new(name);
	endfunction

	`uvm_object_utils_begin(bus_rw_chk_item)
        `uvm_field_int(addr     ,    UVM_ALL_ON)
        `uvm_field_int(data     ,    UVM_ALL_ON)
        `uvm_field_int(rw       ,    UVM_ALL_ON)
        `uvm_field_int(chk_data ,    UVM_ALL_ON)
    `uvm_object_utils_end

endclass : bus_rw_chk_item

