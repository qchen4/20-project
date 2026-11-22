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
// 文件说明 sky_reg_model.sv
// 带逐位写使能的抽象寄存器参考模型，不是完整的 UVM RAL 寄存器块。
// 派生类实现初值和写使能初始化；reg_write 保留不可写位，set_reg_value 可直接覆盖。
// 当前 sky_base_pkg 未启用其 include，属于可选辅助代码。

//----------------------------------------------------------------------------//
// File name    : .sv
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
// 1: register model for a IP;
// 2: this class can't be instanced. Must externd this class and define function
//    set_all_ini_val() and set_all_bit_wen();
//----------------------------------------------------------------------------//

`ifndef _SKY_BASE_PKG_REG_MODEL_
`define _SKY_BASE_PKG_REG_MODEL_

virtual class sky_reg_model #(int REG_WIDTH=32, int REG_NUM=16) extends uvm_object;

typedef logic   [REG_WIDTH-1 :0]    reg_type    ;
typedef bit     [REG_WIDTH-1 :0]    wen_type    ;

            reg_type    regs    [0 : REG_NUM-1];    //store regs' value
protected   wen_type    bit_wen [0 : REG_NUM-1];    //each regs' bit write enable

    //`uvm_object_param_utils(sky_reg_model #(REG_WIDTH, REG_NUM))

    function new(string name="reg_model");
        super.new(name);
    endfunction

    pure virtual function void set_all_ini_val();
    pure virtual function void set_all_bit_wen();


    virtual function bit regidx_vld(int unsigned idx);
        if((idx >= 0) && (idx < REG_NUM))
            return(1);
        else
            return(0);
    endfunction : regidx_vld

    //used to set default value or force a value(ignore the reg_wen flags)
    virtual function bit set_reg_value(int unsigned idx, reg_type data);
        if(regidx_vld(idx)) begin
            regs[idx] = data;
            return 1;
        end else begin
            return 0;
        end
    endfunction : set_reg_value

    virtual function reg_type get_reg_value(int unsigned idx);
        if(regidx_vld(idx))
            return regs[idx];
        else
            return 'x;
    endfunction : get_reg_value

    //used to set reg write bit enable
    virtual function bit set_bit_wen(int unsigned idx, wen_type flags);
        if(regidx_vld(idx)) begin
            bit_wen[idx] = flags;
            return 1;
        end else begin
            return 0;
        end
    endfunction : set_bit_wen

    virtual function wen_type get_bit_wen(int unsigned idx);
        if(regidx_vld(idx)) begin
            return bit_wen[idx];
        end else begin
            return '0;
        end
    endfunction : get_bit_wen

    virtual function bit reg_write(int unsigned idx, reg_type din);
        if(regidx_vld(idx)) begin
            wen_type    en_bits ;
            reg_type    old_data;
            reg_type    new_data;

            en_bits = bit_wen[idx];
            old_data= regs[idx];

            new_data= (old_data & ~(en_bits)) | (din & en_bits);
            regs[idx] = new_data;
            return 1;
        end else begin
            return 0;
        end
    endfunction : reg_write

    virtual function reg_type reg_read(int unsigned idx);
        return get_reg_value(idx);
    endfunction : reg_read

endclass : sky_reg_model

`endif

