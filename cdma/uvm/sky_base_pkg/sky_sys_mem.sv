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
// 1: hash array(associated array) memory to emulation system memory of a large range;
//----------------------------------------------------------------------------//

`ifndef _SKY_BASE_PKG_SYS_MEM_
`define _SKY_BASE_PKG_SYS_MEM_

class sky_sys_mem #(int A_WIDTH=32) extends uvm_component;

typedef bit     [A_WIDTH-1 :0]  addr_type   ;
typedef logic   [7:0]           d_type      ;

protected   d_type  mem [addr_type];    //main memory, 8bit at each addr
    
    `uvm_component_param_utils(sky_sys_mem #(A_WIDTH))

    function new(string name="sys_mem", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    extern virtual function bit  exists(addr_type addr);
    extern virtual function void write(addr_type addr, d_type data);
    extern virtual function void write_32b(addr_type addr, logic [31:0] data);
    extern virtual function logic [31:0] read_32b(addr_type addr);

    
    virtual function d_type read(addr_type addr);
        //addr valid check
        logic   flag    ;
        flag = ^addr;
        if((flag == 1'b0) || (flag == 1'b1)) begin
            if(mem.exists(addr))
                return(mem[addr]);
            else
                return(8'hxx);
        end else begin
            `uvm_warning(get_name(), $sformatf("call read() function with addr contain x/z bit. addr is: %h.", addr))
            return(8'hxx);
        end
    endfunction : read

endclass : sky_sys_mem

function void sky_sys_mem::write(addr_type addr, d_type data);
    mem[addr] = data;
endfunction : write


function bit sky_sys_mem::exists(addr_type addr);
    return mem.exists(addr);
endfunction : exists

function void sky_sys_mem::write_32b(addr_type addr, logic [31:0] data);
    for(int i=0; i<4; i++) begin
        mem[addr+i] = data[i*8 +: 8];
    end
endfunction : write_32b

function logic [31:0] sky_sys_mem::read_32b(addr_type addr);
    logic   [31:0]  rdata   ;
    for(int i=0; i<4; i++) begin
        rdata[8*i +: 8] = read(addr+i);
    end

    return(rdata);
endfunction : read_32b

`endif


