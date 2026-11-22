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
// File name    : .v
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
//----------------------------------------------------------------------------//

module mrisc_exe(
    //csr regs
    csr_mepc        ,

    //dec stage output
    dec_vld         ,
    dec_ack         ,
    dec_pc          ,
    dec_c_resp      ,
    dec_opcode      ,
    dec_code        ,
    dec_fun3        ,
    dec_fun7_00     ,
    dec_add_sub     ,
    dec_opd0        ,
    dec_opd1        ,
    dec_op_sign     ,
    dec_opd2        ,
    dec_opd0_use_pc ,
    dec_opd1_use_offset,
    dec_pc_use_gpr  ,
    dec_jal         ,
    dec_branch      ,
    dec_wfi         ,
    dec_ecall       ,
    dec_ebreak      ,
    dec_mret        ,
    dec_mul_div     ,

    dec_reg_wr      ,
    dec_reg_wr_load ,
    dec_reg_dsa     ,
    dec_csr_wr      ,
    dec_csr_dsa     ,
    dec_store       ,
    dec_code_err    ,

    //for mul/div cmd support
    dec_new_op      ,
    dec_exe_cyc     ,

    //pipe control(comb)
    exe_pc_halt     ,
    exe_pc_update   ,
    exe_pc_opd0     ,
    exe_pc_opd1     ,
    exe_wait_trap   ,
    wb_wait_trap    ,

    //exe pipe output (reged)
    exe_vld         ,
    exe_ack         ,
    exe_fun3        ,
    exe_reg_wr      ,
    exe_reg_wr_load ,
    exe_reg_dsa     ,
    exe_csr_wr      ,
    exe_csr_dsa     ,
    exe_ds_val      ,
    exe_ds_val2     ,
    exe_store       ,
    exe_mret        ,
    exe_wfi         ,
    exe_pc          ,
    exe_exp_vld     ,
    exe_exp_cause   ,
    
    //data forward
    multicyc_ok     ,
    exe_comb_ds_val ,   //valid when dec_vld=1
    exe_comb_ds_val2,

    clk             ,
    rstn         
);


input   wire            clk, rstn       ;

input   wire    [31:0]  csr_mepc        ;   //trap return point

input   wire            dec_vld         ;   //dec stage valid
output  wire            dec_ack         ;
input   wire    [31:0]  dec_pc          ;   //pc of this code
input   wire            dec_c_resp      ;   //okay/error info
input   wire    [6:0]   dec_opcode      ;   //bit[6:0] of code, may no use
input   wire    [31:0]  dec_code        ;
input   wire            dec_add_sub     ;   //0:addd, 1:sub
input   wire    [31:0]  dec_opd0        ;   //ALU operand0
input   wire    [31:0]  dec_opd1        ;   //ALU operand1
input   wire            dec_op_sign     ;   //ALU inputs sign flag; 0:unsigned; 1:signed
input   wire    [31:0]  dec_opd2        ;   //third operand
input   wire            dec_opd0_use_pc ;
input   wire            dec_opd1_use_offset;
input   wire            dec_pc_use_gpr  ;
input   wire    [2:0]   dec_fun3        ;   //ALU op type
input   wire            dec_fun7_00     ;   //fun7 == 7'h00
input   wire            dec_jal         ;   //jal or jalr
input   wire            dec_branch      ;   //branch: bxx
input   wire            dec_wfi         ;   //wfi
input   wire            dec_ecall       ;   //ecall
input   wire            dec_ebreak      ;   //ebreak
input   wire            dec_mret        ;   //mret
input   wire            dec_reg_wr      ;   //this code write regs, but not load OP
input   wire            dec_reg_wr_load ;   //load OP write regs
input   wire    [4:0]   dec_reg_dsa     ;   //regs' addr
input   wire            dec_csr_wr      ;   //this code write csr
input   wire    [3:0]   dec_csr_dsa     ;   //csr's addr
input   wire            dec_store       ;   //this code store data to external mem
input   wire            dec_code_err    ;   //invalid OP code
input   wire            dec_new_op      ;   //comb output; 1: dec load a new OP to exe stage
input   wire    [3:0]   dec_exe_cyc     ;   //comb output; exe multicycle number of this OP; 0:1T, 1:2T, 3:4T
input   wire            dec_mul_div     ;   //M extension(mul & div)

//pipe control(comb)
output  wire            exe_pc_halt     ;   //exe stage detect pc branch(branch/jal/jalr/exception/mret/wfi), level active
output  wire            exe_pc_update   ;   //exe stage pc branched(branch/jal/jalr/mret/wfi), 1T pulse
output  reg     [31:0]  exe_pc_opd0     ;   //opd0 to cal new PC, keep stable until pc update ended
output  reg     [20:0]  exe_pc_opd1     ;
output  wire            exe_wait_trap   ;   //exe detect sync exception or wfi, 1T pulse
input   wire            wb_wait_trap    ;   //wb stage get sync exception, 1T pulse

//exe pipe handshake (reged)
output  reg             exe_vld         ;
input   wire            exe_ack         ;
output  reg     [2:0]   exe_fun3        ;
output  reg             exe_reg_wr      ;
output  reg             exe_reg_wr_load ;
output  reg     [4:0]   exe_reg_dsa     ;
output  reg             exe_csr_wr      ;   //mret also set it to 1, it will write mstatus
output  reg     [3:0]   exe_csr_dsa     ;
output  reg     [31:0]  exe_ds_val      ;   //value stored in: regs, ext mem addr
output  reg     [31:0]  exe_ds_val2     ;   //value stored in: csrs, ext mem wdata
output  reg             exe_store       ;
output  reg             exe_mret        ;
output  reg             exe_wfi         ;
output  reg     [31:0]  exe_pc          ;   //pc of this code, rtl debug only
output  reg             exe_exp_vld     ;
output  reg     [3:0]   exe_exp_cause   ;

//data forward
output  wire            multicyc_ok     ;
output  reg     [31:0]  exe_comb_ds_val ;   //valid when dec_vld=1; regs value, exe mem addr
output  reg     [31:0]  exe_comb_ds_val2;   //csr value or wdata of store OP


//--- 1: operands for new PC

always @(*) begin
    if(dec_mret) begin
        exe_pc_opd0 = csr_mepc;
        exe_pc_opd1 = 21'd0;
    end else begin
        exe_pc_opd1 = dec_opd2[20:0];

        if(dec_pc_use_gpr)
            exe_pc_opd0 = dec_opd0;
        else
            exe_pc_opd0 = dec_pc;
    end
end

//--- 2: ALU
reg             branch_perr ;   //branch prediction error
wire            dec_opd1_zero;

//important note:
//the reason of putting 33bit addsub, 33x33bit mul and 33/33bit div combination logic to sub-module is:
//make DC give smaller logic delay for these combination logics.
//It seems DC(V2016 and V2018) doesn't does well for design with path: 
//same DFF start/end points with both single-cycle path(addsub) and multi-cycle path(mul, div).

wire    [32:0]  add_sub33   ;
wire    [31:0]  add_sub     ;


assign  dec_opd1_zero = (dec_opd1 == 32'h0)? 1'b1 : 1'b0;

mrisc_exe_addsub u_mrisc_exe_addsub(
    .dec_opd0_use_pc(dec_opd0_use_pc),
    .dec_opd1_use_offset(dec_opd1_use_offset),
    .dec_op_sign    (dec_op_sign    ),
    .dec_add_sub    (dec_add_sub    ),
    .dec_opd0       (dec_opd0       ),
    .dec_opd1       (dec_opd1       ),
    .dec_opd2       (dec_opd2       ),
    .dec_pc         (dec_pc         ),
                                    
    .add_sub33      (add_sub33      ) 
);


assign  add_sub = add_sub33[31:0];


//---2.1: shift OPs

reg     [31:0]  sf_val ;

always @(*) begin
    if(dec_fun3[2]) begin   //right shift
        if(dec_fun7_00) begin   //logic shift
            sf_val  = dec_opd0 >> dec_opd1[4:0];
        end else begin          //arithmetic shift
            sf_val  = $signed(dec_opd0) >>> dec_opd1[4:0];
        end
    end else begin          //left shift, only logic shift
        sf_val  = dec_opd0 << dec_opd1[4:0];
    end
end

//--- 2.2: arithmetic/logic/shift/cmp/csr/lui/auipc OPs(not one-hot decode OPs)

reg     [31:0]  comb_val_seq    ;   
reg     [31:0]  comb_val2_seq   ;

always @(*) begin
    comb_val_seq    = add_sub;
    comb_val2_seq   = dec_opd2;

    if(dec_csr_wr) begin    //must be CSR OPs, and dec_reg_wr must also be 1'b1
        //dec_opd0: regs read value;
        //dec_opd1: csrs read value;
        //dec_opd2: immediate value;
        comb_val_seq = dec_opd1;        //csr read value

        case(dec_fun3)
        'd1: comb_val2_seq= dec_opd0;

        'd5: comb_val2_seq= dec_opd2;

        'd2: comb_val2_seq= dec_opd1 | dec_opd0;
        
        'd6: comb_val2_seq= dec_opd1 | dec_opd2;

        'd3: comb_val2_seq= (~dec_opd0) & dec_opd1;

        'd7: comb_val2_seq= (~dec_opd2) & dec_opd1;
        endcase
    end else if(dec_opcode == 7'h37) begin  //LUI
        comb_val_seq = dec_opd2;
    end else if(dec_opcode == 7'h17) begin  //AUIPC
        comb_val_seq = add_sub;
    end else begin   //arithmetic/logic/shift/logic/cmp
        case(dec_fun3)
        'd1, 'd5:   comb_val_seq = sf_val;
        'd0:        comb_val_seq = add_sub;
        'd2, 'd3:   if(add_sub33[32])    //SLT/SLTI/SLTU/SLTIU
                        comb_val_seq = 'd1;
                    else
                        comb_val_seq = 'd0;
        'd4:        comb_val_seq = dec_opd0 ^ dec_opd1;  //XOR/XORI
        'd6:        comb_val_seq = dec_opd0 | dec_opd1;  //OR/ORI
        'd7:        comb_val_seq = dec_opd0 & dec_opd1;  //AND/ANDI
        endcase
    end
end

//--- 2.3 branch/jla/jlar/ecall/ebreak/wfi/mret, load/store, and mul/div(one-hot decode OPs)
//--- 2.3.1: mul & div
reg     [32:0]  mul_div_op0_ext;//sign extersion of operand_0
reg     [32:0]  mul_div_op1_ext;//sign extersion of operand_1

always @(*) begin
    mul_div_op0_ext = {1'b0, dec_opd0}; //default unsigned
    mul_div_op1_ext = {1'b0, dec_opd1};

    case(dec_fun3)
    'd0, 'd3:begin   //op0:unsigned; op1:unsigned
    end

    'd1:    begin   //op0:signed; op1:signed 
        mul_div_op0_ext = {dec_opd0[31], dec_opd0};
        mul_div_op1_ext = {dec_opd1[31], dec_opd1};
    end

    'd2:    begin   //op0:signed; op1:unsigned 
        mul_div_op0_ext = {dec_opd0[31], dec_opd0};
        mul_div_op1_ext = {1'b0, dec_opd1};
    end

    'd4, 'd6:begin   //op0:signed; op1:signed 
        mul_div_op0_ext = {dec_opd0[31], dec_opd0};
        mul_div_op1_ext = {dec_opd1[31], dec_opd1};
    end

    'd5, 'd7:begin  //op0:unsigned; op1:unsigned
    end
    endcase
end


//--- 2.3.2 mul & div DesignWare IP instance
wire    [33+33-1 :0]    mul_w;
wire    [32:0]  div_w, rem_w ;

mrisc_exe_mul u_mul(
    .A          (mul_div_op0_ext),
    .B          (mul_div_op1_ext),
    .PRODUCT    (mul_w          )
);

mrisc_exe_div u_div(
    .a          (mul_div_op0_ext),
    .b          (mul_div_op1_ext),
    .b_zero     (dec_opd1_zero  ),
    .quotient   (div_w          ),
    .remainder  (rem_w          )
);


//--- 2.3.3 merge all one-hot decoded cal result together
wire            exp_nom     ;   //exception caused by ecall/ebreak
wire    [3:0]   exp_type_nom;
wire            exp_abnom   ;   //exception caused by abnormal errors
reg     [31:0]  comb_val_br ;   //one-hot decoded cal results_0
reg     [31:0]  comb_val2_br;   //one-hot decoded cal results_1
reg             pc_update   ;   //branch/jal/jalr/mret and wfi caused pc jump.
                                //for wfi, change pc to next instr after wfi.
                                //exception caused pc jump will be handled when (trap_req && trap_ack)
always @(*) begin
    comb_val_br     = 'd0; 
    comb_val2_br    = 'd0;
    pc_update       = 1'b0;
    branch_perr     = 1'b0;

    case(1'b1)      //synopsys full_case parallel_case
    dec_jal:begin
        comb_val_br     = add_sub;
        pc_update       = 1'b1;
    end

    dec_wfi:begin
        pc_update       = 1'b1; //pc+4, point to instr after wfi
    end

    dec_ecall: begin
        pc_update       = 1'b0;
    end

    dec_ebreak:begin
        pc_update       = 1'b0;
    end

    dec_branch:begin
        
        case(dec_fun3)
        'd0:    //beq
            if(dec_opd0 == dec_opd1) begin
                pc_update   = 1'b1;
                branch_perr = 1'b1;
            end

        'd1:    //bne
            if(dec_opd0 != dec_opd1) begin
                pc_update   = 1'b1;
                branch_perr = 1'b1;
            end

        'd4, 'd6://blt/bltu
            if(add_sub33[32]) begin
                pc_update   = 1'b1;
                branch_perr = 1'b1;
            end
        
        'd5, 'd7://bge/bgeu
            if(!add_sub33[32]) begin
                pc_update   = 1'b1;
                branch_perr = 1'b1;
            end
        endcase
    end

    dec_reg_wr_load: begin
        comb_val_br = add_sub;  //read addr on d-bus
    end

    dec_store:  begin
        comb_val_br = add_sub;  //write addr on d-bus
        comb_val2_br= dec_opd1; //write data on d-bus
    end

    dec_mret:   begin
        pc_update   = 1'b1;
    end

    dec_mul_div:begin
        case(dec_fun3)
        'd0:    comb_val_br = mul_w[31:0];

        'd1, 'd2, 'd3:    
                comb_val_br = mul_w[63:32];

        'd4, 'd5:
                comb_val_br = div_w[31:0];

        'd6, 'd7:
                comb_val_br = rem_w[31:0];
        endcase
    end

    default:    begin
        pc_update       = 1'b0;
        comb_val_br     = 'd0; 
        comb_val2_br    = 'd0;
        branch_perr     = 1'b0;
    end
    endcase
end

//--- 2.4 mux to select final exe_comb_ds_val/exe_comb_ds_val2
wire            onehot_sel;

assign  onehot_sel  = (dec_jal | dec_wfi | dec_ecall | dec_ebreak | dec_branch | dec_mret 
                     | dec_reg_wr_load | dec_store | dec_mul_div);

always @(*) begin
    if(!onehot_sel) begin
        exe_comb_ds_val  = comb_val_seq;
        exe_comb_ds_val2 = comb_val2_seq;
    end else begin
        exe_comb_ds_val  = comb_val_br;
        exe_comb_ds_val2 = comb_val2_br;
    end
end

//---2.5 normal and abnormal exception check

wire            exe_new_op          ;
reg             load_addr_err       ;   //load with un-aligned addr
reg             store_addr_err      ;   //store with un-aligned addr
reg     [3:0]   exe_cyc             ;   //multi-cycle OP cyc cnt, used for multi/div OPs
wire            exp_vld             ;   //exception is detected for this instr(doesn't include d-bus error)
reg     [3:0]   exp_cause           ;


assign  multicyc_ok = (exe_cyc == 'd0)? 1'b1 : 1'b0;
assign  dec_ack     = ((!exe_vld) | exe_ack) & multicyc_ok;
assign  exe_new_op  = dec_vld & dec_ack;

assign  exp_nom     = dec_ecall | dec_ebreak;
assign  exp_type_nom= (dec_ecall)? 'd11 : 'd3;
assign  exp_abnom   = dec_c_resp | dec_code_err | load_addr_err | store_addr_err;
assign  exe_pc_update= exe_new_op & pc_update;
assign  exe_wait_trap = exe_new_op & (exp_nom | exp_abnom | dec_wfi);
assign  exe_pc_halt = dec_vld & (pc_update | exp_nom | exp_abnom);      //pc_update has include dec_wfi case
assign  exp_vld     = exp_abnom | exp_nom;


always @(posedge clk or negedge rstn)
if(~rstn)
    exe_cyc <= 'd0;
else if(dec_new_op)
    exe_cyc <= dec_exe_cyc;
else if(exe_cyc != 'd0)
    exe_cyc <= exe_cyc - 'd1;


always @(*) begin
    load_addr_err = 1'b0;

    if(dec_reg_wr_load) begin
        case(dec_fun3[1:0])
        'd0:    //8bit access
            load_addr_err = 1'b0;

        'd1:    //16bit access
            if(add_sub[0])
                load_addr_err = 1'b1;

        'd2:    //32bit access
            if(add_sub[1:0] != 'd0)
                load_addr_err = 1'b1;
        endcase
    end
end

always @(*) begin
    store_addr_err = 1'b0;

    if(dec_store) begin
        case(dec_fun3[1:0])
        'd0:    //8bit access
            store_addr_err = 1'b0;

        'd1:    //16bit access
            if(add_sub[0])
                store_addr_err = 1'b1;

        'd2:    //32bit access
            if(add_sub[1:0] != 'd0)
                store_addr_err = 1'b1;
        endcase
    end
end

//one instr can at most cause one exception.
always @(*) begin
    if(dec_c_resp) 
        exp_cause = 'd1;
     else if(dec_code_err) 
        exp_cause = 'd2;
     else if(load_addr_err) 
        exp_cause = 'd4;
     else if(store_addr_err) 
        exp_cause = 'd6;
     //else if(exp_nom)
     else
        exp_cause = exp_type_nom;
end


//---2.6 exe pipe handshake

always @(posedge clk or negedge rstn)
if(~rstn)
    exe_vld <= 1'b0;
else if(wb_wait_trap)
    exe_vld <= 1'b0;
else if(exe_new_op) begin
    exe_vld <= 1'b1;
end else if(exe_ack) begin
    exe_vld <= 1'b0;
end

always @(posedge clk)   // or negedge rstn)
if(exe_new_op && (!wb_wait_trap)) begin     //1: all instrs will update these values, 
                                            //include abnormal exceptions/branch/jal/jalr/mret/wfi/ecall/ebreak.
    exe_fun3        <= dec_fun3         ;   //2: all cpu status update(write reg/csr, exception lunch, load/store)
    exe_reg_wr      <= dec_reg_wr       ;   //will take place at wb stage to make sure exceptions are all sync exceptions.
    exe_reg_wr_load <= dec_reg_wr_load  ;   //3: So, some instrs passed exe stage will be flushed(don't update cpu status) 
    exe_reg_dsa     <= dec_reg_dsa      ;   //by wb stage if load/store get d-bus error response.
    exe_csr_wr      <= dec_csr_wr       ;
    exe_csr_dsa     <= dec_csr_dsa      ;
    exe_ds_val      <= exe_comb_ds_val  ;
    exe_ds_val2     <= exe_comb_ds_val2 ;
    exe_store       <= dec_store        ;
    exe_mret        <= dec_mret         ;
    exe_wfi         <= dec_wfi          ;
    exe_pc          <= dec_pc           ;
    exe_exp_vld     <= exp_vld          ;
    exe_exp_cause   <= exp_cause        ;
end

endmodule

