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
// 1: decode stage pipe;
//----------------------------------------------------------------------------//

module mrisc_dec(
    //ifetch handshake inf
    if_vld          ,
    if_ack          ,
    if_pc           ,
    if_code         ,
    if_c_resp       ,

    //regs read
    reg_rsa1        ,
    reg_rs1         ,
    reg_rsa2        ,
    reg_rs2         ,
    
    //csrs read
    csr_rsa         ,
    csr_rs          ,

    //downstream pipe status and forward
    multicyc_ok     ,
    exe_comb_ds_val ,   //valid when dec_vld=1
    exe_comb_ds_val2,

    exe_vld         ,
    exe_reg_wr      ,
    exe_reg_wr_load ,
    exe_reg_dsa     ,
    exe_csr_wr      ,
    exe_csr_dsa     ,
    exe_ds_val      ,
    exe_ds_val2     ,
    
    d_aph_vld       ,
    d_aph_ack       ,
    d_aph_reg_wr    ,
    d_aph_reg_wr_load,
    d_aph_reg_dsa   ,
    d_aph_csr_wr    ,
    d_aph_csr_dsa   ,
    d_aph_ds_val    ,
    d_aph_ds_val2   ,

    d_dack          ,
    d_derr          ,
    d_dph_ext_rdata ,

    //pipe line ctrl
    exe_pc_update   ,
    exe_wait_trap   ,
    wb_wait_trap    ,
    dec_pc_halt     ,

    //dec output
    dec_vld         ,
    dec_ack         ,
    dec_pc          ,
    dec_c_resp      ,
    dec_opcode      ,
    dec_fun3        ,
    dec_fun7_00     ,
    dec_code        ,
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

    clk             ,
    rstn         
);


input   wire            clk, rstn       ;

//ifetch handshake inf
input   wire            if_vld          ;   //instruction code valid; if_vld may change from 1'b1
                                            //to 1'b0 when if_ack=0
output  wire            if_ack          ;   //instruction code accepted
input   wire    [31:0]  if_pc           ;   //pc of this code
input   wire    [31:0]  if_code         ;   //instruction code
input   wire            if_c_resp       ;   //instruction code info: okay or error resp

//regs read
output  wire    [4:0]   reg_rsa1        ;   //regs read addr1
input   wire    [31:0]  reg_rs1         ;   //regs read data1
output  wire    [4:0]   reg_rsa2        ;   //regs read addr2
input   wire    [31:0]  reg_rs2         ;   //regs read data2
    
//csrs read
output  reg     [3:0]   csr_rsa         ;   //csr read addr, 0:always return 0, 1:mstatus
                                            //2:mie, 3:mip, 4:mtvec, 5:mepc, 6:mcause
                                            //7:mtval, 15:misa
input   wire    [31:0]  csr_rs          ;   //csr read data

//downstream pipe status and forward
input   wire            multicyc_ok     ;
input   wire    [31:0]  exe_comb_ds_val ;   //valid when dec_vld=1, comb output of exe stage regs value, exe mem addr
input   wire    [31:0]  exe_comb_ds_val2;   //csr value or data of store OP

input   wire            exe_vld         ;   //exe stage ouptut status and forward value
input   wire            exe_reg_wr      ;   //instr update regs, not include load OP
input   wire            exe_reg_wr_load ;   //instr update regs by load OP
input   wire    [4:0]   exe_reg_dsa     ;   //regs' upadte addr
input   wire            exe_csr_wr      ;   //instr update csr
input   wire    [3:0]   exe_csr_dsa     ;   //csr' update addr
input   wire    [31:0]  exe_ds_val      ;   //reg update value
input   wire    [31:0]  exe_ds_val2     ;   //csr update value
    
input   wire            d_aph_vld       ;   //d_aph stage output status and forward value
input   wire            d_aph_ack       ;   //if load OP, need check for ack for load data valid
input   wire            d_aph_reg_wr    ;
input   wire            d_aph_reg_wr_load;
input   wire    [4:0]   d_aph_reg_dsa   ;
input   wire            d_aph_csr_wr    ;
input   wire    [3:0]   d_aph_csr_dsa   ;
input   wire    [31:0]  d_aph_ds_val    ;
input   wire    [31:0]  d_aph_ds_val2   ;

input   wire            d_dack          ;   //external mem rw data phase ack
input   wire            d_derr          ;   //not used now. connect to 0 at top module.
input   wire    [31:0]  d_dph_ext_rdata ;   //d-bus read forward data.

//pipeline ctrl
input   wire            exe_pc_update   ;   //exe stage ack pc update(branched), 1T pulse
input   wire            exe_wait_trap   ;   //exception or wfi detected at exe stage
input   wire            wb_wait_trap    ;   //d-bus error resp detected at wb stage
//dec output
output  wire            dec_pc_halt     ;   //comb output, halt instr fetch, pc will jump

output  reg             dec_vld         ;   //dec stage valid
input   wire            dec_ack         ;
output  reg     [31:0]  dec_pc          ;   //pc of this code
output  reg             dec_c_resp      ;   //i-bus okay/error response
output  reg     [6:0]   dec_opcode      ;   //bit[6:0] of code, may no use, rtl debug only
output  reg     [2:0]   dec_fun3        ;   //ALU op type
output  reg             dec_fun7_00     ;   //fun7 == 7'h00
output  reg     [31:0]  dec_code        ;   //may not used, rtl debug only
output  reg             dec_add_sub     ;   //0:addd, 1:sub
output  reg     [31:0]  dec_opd0        ;   //ALU operand0
output  reg     [31:0]  dec_opd1        ;   //ALU operand1
output  reg             dec_op_sign     ;   //ALU inputs sign flag; 0:unsigned; 1:signed
output  reg     [31:0]  dec_opd2        ;   //third operand, mostly imm value in instr
output  reg             dec_opd0_use_pc ;   //1: ALU operand0 use PC value; 0: use dec_opd0
output  reg             dec_opd1_use_offset;//1: ALU operand1 use dec_opd2; 0: use dec_opd1
output  reg             dec_pc_use_gpr  ;   //1: use dec_opd0 to cal new pc; 0: use pc
output  reg             dec_jal         ;   //jal or jalr
output  reg             dec_branch      ;   //branch: bxx
output  reg             dec_wfi         ;   //wfi
output  reg             dec_ecall       ;   //ecall
output  reg             dec_ebreak      ;   //ebreak
output  reg             dec_mret        ;   //mret
output  reg             dec_mul_div     ;   //M extension(mul, div)

output  reg             dec_reg_wr      ;   //this code write regs, not include load OP
output  reg             dec_reg_wr_load ;   //load OP write regs
output  reg     [4:0]   dec_reg_dsa     ;   //regs' addr
output  reg             dec_csr_wr      ;   //this code write csr, mret also set it to 1, it will write mstatus
output  reg     [3:0]   dec_csr_dsa     ;   //csr's addr
output  reg             dec_store       ;   //this code store data to external mem
output  reg             dec_code_err    ;   //illegal instruction

output  wire            dec_new_op      ;   //comb output; 1: dec load a new OP to exe stage
output  reg     [3:0]   dec_exe_cyc     ;   //comb output; exe multicycle number of this OP; 0:1T, 1:2T, 3:4T


//--- 1: decoder

wire    [6:0]   opcode      ;
reg             pc_halt     ;   //pc will jump, halt fetch instruction
reg             add_sub     ;   //0:addd, 1:sub
reg signed[31:0]opd0        ;   //ALU operand0
reg signed[31:0]opd1        ;   //ALU operand1
reg             op_sign     ;   //0:unsigned OP; 1:signed OP
reg signed[31:0]opd2        ;   //third operand
reg             opd0_use_pc ;   //1: opd0 of add_sub logic in exe stage use dec_pc, 0: opd0 use dec_opd0
reg             opd1_use_offset;//1: opd1 of add_sub logic in exe stage use dec_opd2, 0: opd1 use dec_opd1
reg             pc_use_gpr  ;   //1: when pc jump and cal for new pc, use dec_opd0; 0: use dec_pc
wire    [2:0]   fun3        ;   //ALU op type
reg     [6:0]   fun7        ;
wire            fun7_00     ;   //fun7 == 7'h00
reg             jal         ;   //jal or jalr
reg             branch      ;   //branch: bxx
reg             wfi         ;   //wfi
reg             ecall       ;   //ecall
reg             ebreak      ;   //ebreak
reg             mret        ;   //mret
reg             mul_div     ;   //M extension(mul & div)
reg     [3:0]   exe_cyc     ;   //exe cycle needed of this instruction, cnt from 0

reg             reg_wr      ;   //this code write regs, but not load OP
reg             reg_wr_load ;   //load OP write regs
wire    [4:0]   reg_dsa     ;   //regs' addr
reg             csr_wr      ;   //this code read/write csr
reg     [3:0]   csr_dsa     ;   //csr's addr
reg             store       ;   //this code store data to external mem
reg             code_err    ;   //invalid OP code
reg             use_rs1     ;   //1: use reg_rs1
reg             use_rs2     ;   //1: use reg_rs2

wire    [20:0]  imme_21     ;
wire    [11:0]  imme_12     ;
wire    [11:0]  imme_12_s   ;
wire    [12:0]  imme_13     ;

reg     [31:0]  reg_rs1_fwd ;   //reg_rs1 value after forward, only drive opd0(critical path)
reg     [31:0]  reg_rs2_fwd ;   //only drive opd1(critical path)
reg     [31:0]  csr_rs_fwd  ;   //only drive opd1

assign  opcode  = if_code[6:0];
assign  reg_rsa1= if_code[19:15];
assign  reg_rsa2= if_code[24:20];
assign  imme_12 = if_code[31:20];
assign  imme_12_s={if_code[31:25], if_code[11:7]};
assign  imme_21 = {if_code[31], if_code[19:12], if_code[20], if_code[30:21], 1'b0};
assign  imme_13 = {if_code[31], if_code[7], if_code[30:25], if_code[11:8], 1'b0};
assign  reg_dsa = if_code[11:7];
assign  fun3    = if_code[14:12];
assign  fun7_00 = (fun7 == 'd0)? 1'b1 : 1'b0;


//decode for CSR addr(self encoded)
//0:always return 0, 1:mstatus
//2:mie, 3:mip, 4:mtvec, 5:mepc, 6:mcause
//7:mtval, 15:misa

always @(*) begin
    csr_dsa     = 'd0;

    if(fun3 == 'd0) //mret will update mstatus
        csr_dsa = 'd1;
    else begin
        case(imme_12)
        12'h300:    csr_dsa = 'd1;  //mstatus
        12'h304:    csr_dsa = 'd2;  //mie
        12'h344:    csr_dsa = 'd3;  //mip
        12'h305:    csr_dsa = 'd4;  //mtvec
        12'h341:    csr_dsa = 'd5;  //mepc
        12'h342:    csr_dsa = 'd6;  //mcause
        12'h343:    csr_dsa = 'd7;  //mtval
        12'h301:    csr_dsa = 'd15; //misa
        endcase
    end
end

always @(*) begin
    if(fun3 == 'd0) //mret will read mepc
        csr_rsa = 'd5;  //mepc
    else
        csr_rsa = csr_dsa;
end


//--- forward data path. 
//previous instr that more close to this instr has higher forward priority.
always @(*) begin
    if(reg_rsa1 != 'd0) begin
        if(dec_vld && (reg_rsa1 == dec_reg_dsa) && dec_reg_wr)
            reg_rs1_fwd = exe_comb_ds_val;
        else if(exe_vld && (reg_rsa1 == exe_reg_dsa) && exe_reg_wr)
            reg_rs1_fwd = exe_ds_val;
        else if(d_aph_vld && (reg_rsa1 == d_aph_reg_dsa) && d_aph_reg_wr)
            reg_rs1_fwd = d_aph_ds_val;
        //else if(d_aph_vld && (reg_rsa1 == d_aph_reg_dsa) && d_aph_reg_wr_load && d_dack && (!d_derr))
        else if(d_aph_vld && (reg_rsa1 == d_aph_reg_dsa) && d_aph_reg_wr_load)
            reg_rs1_fwd = d_dph_ext_rdata;  //if d-bus error resp, d_aph_vld will be clear to 0 at
        else                                //first T of ahb-lite error response. then use reg_rs1.
            reg_rs1_fwd = reg_rs1;
    end else begin
        reg_rs1_fwd = 'd0;
    end
end

always @(*) begin
    if(reg_rsa2 != 'd0) begin
        if(dec_vld && (reg_rsa2 == dec_reg_dsa) && dec_reg_wr)
            reg_rs2_fwd = exe_comb_ds_val;
        else if(exe_vld && (reg_rsa2 == exe_reg_dsa) && exe_reg_wr)
            reg_rs2_fwd = exe_ds_val;
        else if(d_aph_vld && (reg_rsa2 == d_aph_reg_dsa) && d_aph_reg_wr)
            reg_rs2_fwd = d_aph_ds_val;
        //else if(d_aph_vld && (reg_rsa2 == d_aph_reg_dsa) && d_aph_reg_wr_load && d_dack && (!d_derr))
        else if(d_aph_vld && (reg_rsa2 == d_aph_reg_dsa) && d_aph_reg_wr_load)
            reg_rs2_fwd = d_dph_ext_rdata;
        else
            reg_rs2_fwd = reg_rs2;
    end else begin
        reg_rs2_fwd = 'd0;
    end
end

//bug fix: can't use forward path to solve csr data dependance, as
//some write-mask bits is valid when write to that csr at wb stage.
always @(*) begin
    csr_rs_fwd = csr_rs;
end


//--- main decoder
always @(*) begin
    pc_halt = 'd0;

    add_sub     = 'd0;
    opd0        = reg_rs1_fwd;
    opd1        = reg_rs2_fwd;
    op_sign     = 'd0;
    opd2        = $signed(imme_13);
    opd0_use_pc = 'd0;
    opd1_use_offset = 'd0;
    pc_use_gpr  = 'd0;
    fun7        = if_code[31:25];
    jal         = 'd0;
    branch      = 'd0;
    wfi         = 'd0;
    ecall       = 'd0;
    ebreak      = 'd0;
    mret        = 'd0;
    mul_div     = 'd0;
    exe_cyc     = 'd0;
    reg_wr      = 'd0;
    reg_wr_load = 'd0;
    csr_wr      = 'd0;
    store       = 'd0;

    code_err    = 'd1;
    use_rs1     = 'd1;
    use_rs2     = 'd1;

    case(opcode)
    7'h6f:  begin   //JAL, pc+4 will be done at exe stage
        pc_halt     = 'd1;
        add_sub     = 'd0;
        opd1        = 'd4;
        opd2        = $signed(imme_21); //new pc= pc + opd2
        opd0_use_pc = 'd1;              //x[rd] = pc + opd1
        jal         = 'd1;
        reg_wr      = 'd1;
        code_err    = 'd0;
        use_rs1     = 'd0;
        use_rs2     = 'd0;
    end

    7'h67:  begin   //JALR, pc+4 will be done at exe stage
        pc_halt     = 'd1;
        add_sub     = 'd0;
        opd0        = reg_rs1_fwd;
        opd1        = 'd4;
        opd2        = $signed(imme_12);
        opd0_use_pc = 'd1;              //x[rd] = pc + opd1
        pc_use_gpr  = 'd1;              //new pc= opd0 + opd2
        jal         = 'd1;
        reg_wr      = 'd1;

        if(fun3 == 'd0)
            code_err    = 'd0;        

        use_rs2     = 'd0;
    end

    7'h73:  begin
        case(fun3)
        'd0:    begin
            if((reg_dsa == 'd0) && (reg_rsa1 == 'd0)) begin
                use_rs1 = 'd0;
                use_rs2 = 'd0;
                pc_halt = 'd1;

                case(imme_12)
                12'h105:begin   //wfi
                    wfi         = 'd1;
                    code_err    = 1'b0;
                end

                12'h0:  begin   //ecall
                    ecall       = 'd1;
                    code_err    = 1'b0;
                end

                12'h1:  begin   //ebreak
                    ebreak      = 'd1;
                    code_err    = 1'b0;
                end

                12'h302: begin  //mret
                    mret        = 'd1;
                    code_err    = 1'b0;
                end
                endcase
            end
        end

        'd1, 'd2, 'd3:    begin   //CSRRW/CSRRS/CSRRC
            code_err= 'd0;
            use_rs2 = 'd0;
        end

        'd5, 'd6, 'd7:  begin   //CSRRWI/CSRRSI/CSRRCI
            code_err= 'd0;
            use_rs1 = 'd0;
            use_rs2 = 'd0;
        end

        'd4: begin              //invalid instr, simple logic
            code_err= 'd1;
            use_rs1 = 'd0;
            use_rs2 = 'd0;
        end
        endcase

        //function for fun3 = 0~7
        opd0    = reg_rs1_fwd;
        opd1    = csr_rs_fwd;

        if(fun3 == 'd0)     //just to cal pc+4 for wfi instruction
            opd2    = 'd4;
        else
            opd2    = {27'h0, if_code[19:15]};
        

        if(fun3 == 'd0) begin
            if(imme_12 == 12'h302) begin    //MRET will update mstatus
                csr_wr = 'd1;
            end
        end else if(fun3 != 'd4) begin
            reg_wr  = 'd1;
            csr_wr  = 'd1;
        end
    end

    7'h63:  begin   //branch OPs
        if((fun3 != 'd2) && (fun3 != 'd3))
            code_err = 'd0;
        
        if((fun3== 'd6) || fun3 == 'd7)
            op_sign = 'd0;
        else
            op_sign = 'd1;

        opd2    = $signed(imme_13);
        add_sub = 'd1;  //sub
        branch  = 'd1;
    end

    7'h03:  begin   //load
        if((fun3 != 'd3) && (fun3 != 'd7) && (fun3 != 'd6))
            code_err = 'd0;
        
        reg_wr_load = 'd1;

        opd0    = reg_rs1_fwd;
        opd2    = $signed(imme_12);
        opd1_use_offset = 'd1;          //ext_mem_addr = opd0 + opd2;
        use_rs2 = 'd0;
    end

    7'h23:  begin   //store
        if((fun3 == 'd0) || (fun3 == 'd1) || (fun3 == 'd2)) begin
            code_err = 'd0;
        end
        store   = 'd1;
        opd0    = reg_rs1_fwd;
        opd1    = reg_rs2_fwd;          //write data
        opd2    = $signed(imme_12_s);   //addr offset
        opd1_use_offset = 'd1;          //ext_mem_addr = opd0 + opd2;
    end

    7'h37:  begin   //LUI
        code_err= 'd0;
        reg_wr  = 'd1;
        opd2    = {if_code[31:12], 12'h0};
        use_rs1 = 'd0;
        use_rs2 = 'd0;
    end

    7'h17:  begin   //AUIPC
        code_err= 'd0;
        reg_wr  = 'd1;
        opd2    = {if_code[31:12], 12'h0};
        opd0_use_pc = 'd1;
        opd1_use_offset = 'd1;      //x[rd] = pc + opd2
        use_rs1 = 'd0;
        use_rs2 = 'd0;
    end

    7'h33:  begin   //mul/div/shift/ALU/logic/cmp
        reg_wr  = 'd1;

        if(fun3 == 'd2)
            op_sign = 'd1;  //not used for mul_div OPs
        else
            op_sign = 'd0;

        if(fun7 == 7'h01) begin //mul & div
            mul_div = 1'b1;
            code_err= 1'b0;

            if(fun3[2])
                exe_cyc = 'd7;  //div/rem: 8 cycles
            else
                exe_cyc = 'd1;  //mul: 2 cycles
        end else begin
            case(fun3)
                'd0:    begin   //add/sub
                    if(fun7_00) add_sub = 'd0;
                    else        add_sub = 'd1;

                    if((fun7 == 'h0) || (fun7 == 'h20))
                        code_err= 'd0;
                end

                'd1, 'd5: begin //shift
                    if((fun7 == 'h0) || (fun7 == 'h20))
                        code_err= 'd0;
                end

                'd2, 'd3: begin //cmp
                    add_sub = 'd1;
                    if(fun7 == 'd0)
                        code_err= 'd0;
                end

                'd4, 'd6, 'd7: begin//logic
                    if(fun7 == 'd0)
                        code_err= 'd0;
                end
            endcase
        end
    end

    7'h13:  begin
        reg_wr  = 'd1;
        use_rs2 = 'd0;

        if(fun3 == 'd2)
            op_sign = 'd1;
        else
            op_sign = 'd0;

        case(fun3)
            'd0:    begin   //addi
                add_sub = 'd0;
                opd1    = $signed(imme_12);
                code_err= 'd0;
            end

            'd1, 'd5: begin //shift
                opd1 = $signed(imme_12);    //higher bits will be discard in exe stage
                fun7 = {if_code[31:26], 1'b0};

                if(if_code[25] == 'd0)
                    code_err = 'd0;
            end

            'd2, 'd3: begin //cmp
                add_sub = 'd1;
                opd1    = $signed(imme_12);
                code_err= 'd0;
            end

            'd4, 'd6, 'd7: begin//logic
                opd1    = $signed(imme_12);
                code_err= 'd0;
            end

        endcase
    end

    endcase //case(opcode[6:0])
end

//note: pc_halt=1 when decode jal/jalr/wfi/ecall/ebreak/mret instr. This instr may not be executed 
//if previous instr is a branch instr with branch taken. But this will not cause problem. As:
//1: If previous branch instr is taken, it also assert exe_pc_halt=1 at exe stage, and must 
//   assert exe_pc_update to load new pc value.
//2: If previous branch instr isn't taken, this instr will execute.
assign  dec_pc_halt = pc_halt & if_vld;


//--- 3: halt condition
wire        dec_halt        ;
wire        reg_rs1_conflict;
wire        reg_rs2_conflict;
wire        csr_conflict    ;


assign  reg_rs1_conflict = use_rs1 & (reg_rsa1 != 'd0) & 
                    ( //if multicyc_ok=0, dec_ack must be 0. if dec_vld=1, dec_opd0 will not latch opd0, so reg_rs1_fwd isn't used when multicyc_ok=0.
                      //(dec_vld & (reg_rsa1 == dec_reg_dsa) & dec_reg_wr & (!multicyc_ok)) |   //multicyc instr not finish in exe stage
                      (dec_vld & (reg_rsa1 == dec_reg_dsa) & dec_reg_wr_load) |                 //need d-bus read data
                      (exe_vld & (reg_rsa1 == exe_reg_dsa) & exe_reg_wr_load) |
                      (d_aph_vld & (reg_rsa1 == d_aph_reg_dsa) & d_aph_reg_wr_load & (!d_dack)) );

assign  reg_rs2_conflict = use_rs2 & (reg_rsa2 != 'd0) &
                    ( //if multicyc_ok=0, dec_ack must be 0. if dec_vld=1, dec_opd1 will not latch opd1, so reg_rs2_fwd isn't used when multicyc_ok=0.
                      //(dec_vld & (reg_rsa2 == dec_reg_dsa) & dec_reg_wr & (!multicyc_ok)) |   //multicyc instr not finish in exe stage
                      (dec_vld & (reg_rsa2 == dec_reg_dsa) & dec_reg_wr_load) |                 //need d-bus read data
                      (exe_vld & (reg_rsa2 == exe_reg_dsa) & exe_reg_wr_load) |
                      (d_aph_vld & (reg_rsa2 == d_aph_reg_dsa) & d_aph_reg_wr_load & (!d_dack)) );

//r/w mepc before mret; r/w mstatus after mret will also be halted by this condition
assign  csr_conflict = csr_wr &  
                    ( (dec_vld & (csr_rsa == dec_csr_dsa) & dec_csr_wr)         |
                      (exe_vld & (csr_rsa == exe_csr_dsa) & exe_csr_wr)         |
                      (d_aph_vld & (csr_rsa == d_aph_csr_dsa) & d_aph_csr_wr) );

assign  dec_halt = reg_rs1_conflict | reg_rs2_conflict | csr_conflict;


//---4: pipe output
wire    flush       ;

assign  if_ack      = ((!dec_vld) | dec_ack) & (!dec_halt);
assign  dec_new_op  = if_ack & if_vld;
assign  flush       = exe_pc_update | exe_wait_trap | wb_wait_trap;

always @(posedge clk or negedge rstn)
if(~rstn)
    dec_vld <= 1'b0;
else if(flush)
    dec_vld <= 1'b0;
else if(dec_new_op)
    dec_vld <= 1'b1;
else if(dec_ack)
    dec_vld <= 1'b0;

always @(posedge clk)   // or negedge rstn)
if(dec_new_op && (!flush)) begin        //if flush, don't load new info from instr_fetch stage.
    dec_pc          <= if_pc        ;   //keep info of the instr that cause exe_pc_update | exe_wait_trap.
    dec_c_resp      <= if_c_resp    ;   //These info need keep stable before new_pc update to pc reg.
    dec_opcode      <= opcode       ;
    dec_code        <= if_code      ;
    dec_add_sub     <= add_sub      ;
    dec_opd0        <= opd0         ;
    dec_opd1        <= opd1         ;
    dec_op_sign     <= op_sign      ;
    dec_opd2        <= opd2         ;
    dec_opd0_use_pc <= opd0_use_pc  ;
    dec_opd1_use_offset <= opd1_use_offset;
    dec_pc_use_gpr  <= pc_use_gpr   ;
    dec_fun3        <= fun3         ;
    dec_fun7_00     <= fun7_00      ;
    dec_jal         <= jal          ;
    dec_branch      <= branch       ;
    dec_wfi         <= wfi          ;
    dec_ecall       <= ecall        ;
    dec_ebreak      <= ebreak       ;
    dec_mret        <= mret         ;
    dec_reg_wr      <= reg_wr       ;
    dec_reg_wr_load <= reg_wr_load  ;
    dec_reg_dsa     <= reg_dsa      ;
    dec_csr_wr      <= csr_wr       ;
    dec_csr_dsa     <= csr_dsa      ;
    dec_store       <= store        ;
    dec_code_err    <= code_err     ;
    dec_mul_div     <= mul_div      ;
end

always @(*) begin
    dec_exe_cyc = exe_cyc;
end

endmodule

