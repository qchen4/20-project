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
// 1: instance 6-stage pipeline, regs, csr and internal intr control.
//----------------------------------------------------------------------------//

module mrisc_core(
    ext_irq         ,
    clk_req         ,

    //instr read bus(ahb-lite master)
	i_haddr			,
	i_hburst		,
	i_htrans		,
	i_hsize			,
	i_hprot			,
	i_hwrite		,
	i_hwdata		,
    i_hmastlock     ,
	i_hready		,
	i_hrdata		,
	i_hresp			,  

    //data r/w bus(ahb-lite master)
	d_haddr			,
	d_hburst		,
	d_htrans		,
	d_hsize			,
	d_hprot			,
	d_hwrite		,
    d_hmastlock     ,
    d_hwdata        ,
    d_hready        ,
    d_hrdata        ,
    d_hresp         ,

    clk             ,
    clk_awo         ,
    rstn         
);


input   wire            clk, rstn       ;   //when clk_req=0, clk can be gated off
input   wire            clk_awo         ;   //always on clk, sync with clk, can't be clock gated

input   wire            ext_irq         ;   //external interrupt input, high level active;
output  wire            clk_req         ;   //1: need clk running; 0: clk can be gated off

//instr read ahb-lite bus inf
output  wire	[31:0]	i_haddr		    ;
output  wire	[2:0]	i_hburst	    ;
output  wire	[1:0]	i_htrans	    ;
output  wire	[2:0]	i_hsize		    ;
output  wire	[3:0]	i_hprot		    ;
output  wire		    i_hwrite	    ;
output  wire            i_hmastlock     ;
output  wire	[31:0]	i_hwdata	    ;
input   wire            i_hready        ;
input   wire    [31:0]  i_hrdata        ;
input   wire            i_hresp         ;


//data r/w bus(ahb-lite)
output  wire	[31:0]	d_haddr		    ;
output  wire	[2:0]	d_hburst	    ;
output  wire	[1:0]	d_htrans	    ;
output  wire	[2:0]	d_hsize		    ;
output  wire	[3:0]	d_hprot		    ;
output  wire		    d_hwrite	    ;
output  wire            d_hmastlock     ;
output  wire    [31:0]  d_hwdata        ;
input   wire            d_hready        ;
input   wire    [31:0]  d_hrdata        ;
input   wire            d_hresp         ;


//flow ctrl with core pipeline
wire            dec_pc_halt     ;   //dec stage detect not pc+4, indicate only, this signal maybe missed
wire            exe_pc_halt     ;   //exe stage detect not pc+4, indicate only, this signal maybe missed
wire            exe_pc_update   ;   //exe stage pc branched(branch/jal/jalr/mret/wfi), 1T pulse
wire    [31:0]  exe_pc_opd0     ;   //opd0 to cal new PC, keep stable until pc update ended
wire    [20:0]  exe_pc_opd1     ;   //opd1 to cal new PC, keep stable until pc update ended
wire            exe_wait_trap   ;   //exe detect sync exception or wfi, 1T pulse
wire            wb_wait_trap    ;   //wb stage get sync exception, 1T pulse
wire            irq_wait_trap   ;   //async interrupt is pending, level active

//core pipe stage flags
wire            dec_vld         ;   //valid output at dec stage
wire            exe_vld         ;   //valid output at exe stage
wire            d_aph_vld       ;   //valid output at d_aph stage

//CSR and intr inf
wire            trap_req        ;   //trap req, high level active; must keep 1'b1 until trap_ack=1
wire            trap_ack        ;   //== cpu_idle
wire            i_go_trap       ;   //1T pulse, the next cycle, pc change to trap begin addr.
                                    //when 1'b1, i-bus and all pipe stages are in idle state, d-bus may working.
wire            cpu_idle        ;   //from ifetch to write back stage and i-bus are all idle, d-bus may working.
wire    [31:0]  csr_mtvec       ;   //trap begin vector
wire    [31:0]  csr_mcause      ;   //{intr, cause}
wire    [31:0]  csr_mepc        ;   //trap return pc value;
                                    //when intr: point to next code to fetch
                                    //when exception: point to the code that cause the exception
wire    [31:0]  pc              ;   //i-bus read PC value

//ifetch handshake inf
wire            if_vld          ;   //instruction code valid; if_vld may change from 1'b1
                                    //to 1'b0 when if_ack=0
wire            if_ack          ;   //instruction code accepted
wire    [31:0]  if_pc           ;   //pc of this code
wire    [31:0]  if_code         ;   //instruction code
wire            if_c_resp       ;   //instruction resp: 0: okay,  1: error

//dec stage signals
wire    [4:0]   reg_rsa1        ;   //regs read addr1
wire    [31:0]  reg_rs1         ;   //regs read data1, can drive opd0 only
wire    [4:0]   reg_rsa2        ;   //regs read addr2
wire    [31:0]  reg_rs2         ;   //regs read data2, can drive opd1 only
wire    [3:0]   csr_rsa         ;   //csr read addr, 0:always return 0, 1:mstatus
                                    //2:mie, 3:mip, 4:mtvec, 5:mepc, 6:mcause
                                    //7:mtval, 15:misa
wire    [31:0]  csr_rs          ;   //csr read data, can drive opd1 only
wire            dec_ack         ;
wire    [31:0]  dec_pc          ;   //pc of this code
wire            dec_c_resp      ;   //okay/error info
wire    [6:0]   dec_opcode      ;   //bit[6:0] of code, may no use, rtl debug only
wire    [2:0]   dec_fun3        ;   //ALU op type
wire            dec_fun7_00     ;   //fun7 == 7'h00
wire    [31:0]  dec_code        ;   //may no use, rtl debug only
wire            dec_add_sub     ;   //0:addd, 1:sub
wire    [31:0]  dec_opd0        ;   //ALU operand0
wire    [31:0]  dec_opd1        ;   //ALU operand1
wire            dec_op_sign     ;   //ALU inputs sign flag; 0:unsigned; 1:signed
wire    [31:0]  dec_opd2        ;   //third operand
wire            dec_opd0_use_pc ;
wire            dec_opd1_use_offset;
wire            dec_pc_use_gpr  ;
wire            dec_jal         ;   //jal or jalr
wire            dec_branch      ;   //branch: bxx
wire            dec_wfi         ;   //wfi
wire            dec_ecall       ;   //ecall
wire            dec_ebreak      ;   //ebreak
wire            dec_mret        ;   //mret
wire            dec_mul_div     ;   //M extension(mul, div)
wire            dec_reg_wr      ;   //this code write regs, but not load OP
wire            dec_reg_wr_load ;   //load OP write regs
wire    [4:0]   dec_reg_dsa     ;   //regs' addr
wire            dec_csr_wr      ;   //this code write csr, mret also set it to 1
wire    [3:0]   dec_csr_dsa     ;   //csr's addr
wire            dec_store       ;   //this code store data to external mem
wire            dec_code_err    ;   //invalid OP code
wire            dec_new_op      ;   //comb output; 1: dec load a new OP to exe stage
wire    [3:0]   dec_exe_cyc     ;   //comb output; exe multicycle number of this OP; 0:1T, 1:2T, 3:4T

//exe stage signals
wire            multicyc_ok     ;
wire    [31:0]  exe_comb_ds_val ;   //valid when dec_vld=1, comb output of exe stage regs value, regs value, exe mem addr
wire    [31:0]  exe_comb_ds_val2;   //csr value or data of store OP
wire            exe_ack         ;
wire    [2:0]   exe_fun3        ;
wire            exe_reg_wr      ;
wire            exe_reg_wr_load ;
wire    [4:0]   exe_reg_dsa     ;
wire            exe_csr_wr      ;   //mret also set it to 1
wire    [3:0]   exe_csr_dsa     ;
wire    [31:0]  exe_ds_val      ;   //hold value: regs, ext mem addr
wire    [31:0]  exe_ds_val2     ;   //hold value: csrs, ext mem wdata
wire            exe_store       ;
wire            exe_mret        ;
wire            exe_wfi         ;
wire    [31:0]  exe_pc          ;   //pc of this code, rtl debug only
wire            exe_exp_vld     ;
wire    [3:0]   exe_exp_cause   ;

//d_aph signals
wire            d_aph_ack       ;
wire    [2:0]   d_aph_fun3      ;
wire            d_aph_reg_wr    ;
wire            d_aph_reg_wr_load;
wire    [4:0]   d_aph_reg_dsa   ;
wire            d_aph_csr_wr    ;
wire    [3:0]   d_aph_csr_dsa   ;
wire    [31:0]  d_aph_ds_val    ;   //hold value: regs, ext mem addr
wire    [31:0]  d_aph_ds_val2   ;   //hold value: csrs, ext mem wdata
wire            d_aph_store     ;
wire            d_aph_mret      ;
wire            d_aph_wfi       ;
wire    [31:0]  d_aph_pc        ;   //pc of this operation, rtl debug only
wire            d_aph_exp_vld   ;
wire    [3:0]   d_aph_exp_cause ;

//d_dph(wb) signals
wire    [31:0]  d_dph_ext_rdata ;   //comb output
wire            reg_wr          ;
wire    [31:0]  reg_wdata       ;
wire    [4:0]   reg_waddr       ;
wire            csr_wr          ;
wire    [31:0]  csr_wdata       ;
wire    [3:0]   csr_waddr       ;
wire            wb_wfi          ;
wire            wb_mret         ;
wire            wb_exp_vld      ;   //level active
wire    [3:0]   wb_exp_cause    ;
wire    [31:0]  wb_pc           ;   //pc addr that cause exception 
wire    [31:0]  wb_dbus_addr    ;   //d-bus load/store addr



mrisc_ifetch u_mrisc_ifetch(
    //instr read bus inf
	.i_haddr		(i_haddr		),
	.i_hburst		(i_hburst		),
	.i_htrans		(i_htrans		),
	.i_hsize		(i_hsize		),
	.i_hprot		(i_hprot		),
	.i_hwrite		(i_hwrite		),
	.i_hwdata		(i_hwdata		),
    .i_hmastlock    (i_hmastlock    ),
	.i_hready		(i_hready		),
	.i_hrdata		(i_hrdata		),
	.i_hresp		(i_hresp		),    

    //flow ctrl with core pipeline
    .dec_pc_halt    (dec_pc_halt    ),
    .exe_pc_halt    (exe_pc_halt    ),
    .exe_pc_update  (exe_pc_update  ),
    .exe_pc_opd0    (exe_pc_opd0    ),
    .exe_pc_opd1    (exe_pc_opd1    ),
                                    
    .exe_wait_trap  (exe_wait_trap  ),
    .wb_wait_trap   (wb_wait_trap   ),
    .irq_wait_trap  (irq_wait_trap  ),

    //core pipe stage flags
    .dec_vld        (dec_vld        ),
    .exe_vld        (exe_vld        ),
    .d_aph_vld      (d_aph_vld      ),

    //CSR and intr inf
    .trap_req       (trap_req       ),
    .trap_ack       (trap_ack       ),
    .i_go_trap      (i_go_trap      ),
    .cpu_idle       (cpu_idle       ),
    .csr_mtvec      (csr_mtvec      ),
    .csr_mcause     (csr_mcause     ),
    .pc             (pc             ),

    //ifetch handshake inf
    .if_vld         (if_vld         ),
    .if_ack         (if_ack         ),
    .if_pc          (if_pc          ),
    .if_code        (if_code        ),
    .if_c_resp      (if_c_resp      ),
                                    
    .clk            (clk            ),
    .rstn           (rstn           ) 
);


mrisc_dec u_mrisc_dec(
    //ifetch handshake inf
    .if_vld         (if_vld         ),
    .if_ack         (if_ack         ),
    .if_pc          (if_pc          ),
    .if_code        (if_code        ),
    .if_c_resp      (if_c_resp      ),

    //regs read
    .reg_rsa1       (reg_rsa1       ),
    .reg_rs1        (reg_rs1        ),
    .reg_rsa2       (reg_rsa2       ),
    .reg_rs2        (reg_rs2        ),
    
    //csrs read
    .csr_rsa        (csr_rsa        ),
    .csr_rs         (csr_rs         ),

    //downstream pipe status and forward
    .multicyc_ok    (multicyc_ok    ),
    .exe_comb_ds_val (exe_comb_ds_val ),   //valid when dec_vld=1
    .exe_comb_ds_val2(exe_comb_ds_val2),

    .exe_vld        (exe_vld        ),
    .exe_reg_wr     (exe_reg_wr     ),
    .exe_reg_wr_load(exe_reg_wr_load),
    .exe_reg_dsa    (exe_reg_dsa    ),
    .exe_csr_wr     (exe_csr_wr     ),
    .exe_csr_dsa    (exe_csr_dsa    ),
    .exe_ds_val     (exe_ds_val     ),
    .exe_ds_val2    (exe_ds_val2    ),
    
    .d_aph_vld      (d_aph_vld      ),
    .d_aph_ack      (d_aph_ack      ),
    .d_aph_reg_wr   (d_aph_reg_wr   ),
    .d_aph_reg_wr_load(d_aph_reg_wr_load),
    .d_aph_reg_dsa  (d_aph_reg_dsa  ),
    .d_aph_csr_wr   (d_aph_csr_wr   ),
    .d_aph_csr_dsa  (d_aph_csr_dsa  ),
    .d_aph_ds_val   (d_aph_ds_val   ),
    .d_aph_ds_val2  (d_aph_ds_val2  ),

    .d_dack         (d_hready       ),
    //.d_derr         (d_hresp        ),
    .d_derr         (1'b0   ),          //if d_resp=1, will clear d_aph_vld to 0 at first T of 
    .d_dph_ext_rdata(d_dph_ext_rdata),  //ahb-lite error response. Then use value read from regs.

    //pipe line ctrl
    .exe_pc_update  (exe_pc_update  ),
    .exe_wait_trap  (exe_wait_trap  ),
    .wb_wait_trap   (wb_wait_trap   ),
    .dec_pc_halt    (dec_pc_halt    ),

    //dec output
    .dec_vld        (dec_vld        ),
    .dec_ack        (dec_ack        ),
    .dec_pc         (dec_pc         ),
    .dec_c_resp     (dec_c_resp     ),
    .dec_opcode     (dec_opcode     ),
    .dec_fun3       (dec_fun3       ),
    .dec_fun7_00    (dec_fun7_00    ),
    .dec_code       (dec_code       ),
    .dec_add_sub    (dec_add_sub    ),
    .dec_opd0       (dec_opd0       ),
    .dec_opd1       (dec_opd1       ),
    .dec_op_sign    (dec_op_sign    ),
    .dec_opd2       (dec_opd2       ),
    .dec_opd0_use_pc(dec_opd0_use_pc),
    .dec_opd1_use_offset(dec_opd1_use_offset),
    .dec_pc_use_gpr (dec_pc_use_gpr ),
    .dec_jal        (dec_jal        ),
    .dec_branch     (dec_branch     ),
    .dec_wfi        (dec_wfi        ),
    .dec_ecall      (dec_ecall      ),
    .dec_ebreak     (dec_ebreak     ),
    .dec_mret       (dec_mret       ),
    .dec_mul_div    (dec_mul_div    ),

    .dec_reg_wr     (dec_reg_wr     ),
    .dec_reg_wr_load(dec_reg_wr_load),
    .dec_reg_dsa    (dec_reg_dsa    ),
    .dec_csr_wr     (dec_csr_wr     ),
    .dec_csr_dsa    (dec_csr_dsa    ),
    .dec_store      (dec_store      ),
    .dec_code_err   (dec_code_err   ),

    //for mul/div cmd support
    .dec_new_op     (dec_new_op     ),
    .dec_exe_cyc    (dec_exe_cyc    ),
                                    
    .clk            (clk            ),
    .rstn           (rstn           )
);


mrisc_regs u_mrisc_regs(
    //read
    .reg_rsa1           (reg_rsa1           ),
    .reg_rs1            (reg_rs1            ),
    .reg_rsa2           (reg_rsa2           ),
    .reg_rs2            (reg_rs2            ),

    //write
    .reg_wr             (reg_wr             ),
    .reg_wdata          (reg_wdata          ),
    .reg_waddr          (reg_waddr          ),    
                                            
    .clk                (clk                ),
    .rstn               (rstn               ) 
);


mrisc_exe u_mrisc_exe(
    //csr regs
    .csr_mepc       (csr_mepc       ),

    //dec stage output
    .dec_vld        (dec_vld        ),
    .dec_ack        (dec_ack        ),
    .dec_pc         (dec_pc         ),
    .dec_c_resp     (dec_c_resp     ),
    .dec_opcode     (dec_opcode     ),
    .dec_code       (dec_code       ),
    .dec_fun3       (dec_fun3       ),
    .dec_fun7_00    (dec_fun7_00    ),
    .dec_add_sub    (dec_add_sub    ),
    .dec_opd0       (dec_opd0       ),
    .dec_opd1       (dec_opd1       ),
    .dec_op_sign    (dec_op_sign    ),
    .dec_opd2       (dec_opd2       ),
    .dec_opd0_use_pc(dec_opd0_use_pc),
    .dec_opd1_use_offset(dec_opd1_use_offset),
    .dec_pc_use_gpr (dec_pc_use_gpr ),
    .dec_jal        (dec_jal        ),
    .dec_branch     (dec_branch     ),
    .dec_wfi        (dec_wfi        ),
    .dec_ecall      (dec_ecall      ),
    .dec_ebreak     (dec_ebreak     ),
    .dec_mret       (dec_mret       ),
    .dec_mul_div    (dec_mul_div    ),

    .dec_reg_wr     (dec_reg_wr     ),
    .dec_reg_wr_load(dec_reg_wr_load),
    .dec_reg_dsa    (dec_reg_dsa    ),
    .dec_csr_wr     (dec_csr_wr     ),
    .dec_csr_dsa    (dec_csr_dsa    ),
    .dec_store      (dec_store      ),
    .dec_code_err   (dec_code_err   ),

    //for mul/div cmd support
    .dec_new_op     (dec_new_op     ),
    .dec_exe_cyc    (dec_exe_cyc    ),

    //pipe control(comb)
    .exe_pc_halt    (exe_pc_halt    ),
    .exe_pc_update  (exe_pc_update  ),
    .exe_pc_opd0    (exe_pc_opd0    ),
    .exe_pc_opd1    (exe_pc_opd1    ),
    .exe_wait_trap  (exe_wait_trap  ),
    .wb_wait_trap   (wb_wait_trap   ),

    //exe pipe output (reged)
    .exe_vld        (exe_vld        ),
    .exe_ack        (exe_ack        ),
    .exe_fun3       (exe_fun3       ),
    .exe_reg_wr     (exe_reg_wr     ),
    .exe_reg_wr_load(exe_reg_wr_load),
    .exe_reg_dsa    (exe_reg_dsa    ),
    .exe_csr_wr     (exe_csr_wr     ),
    .exe_csr_dsa    (exe_csr_dsa    ),
    .exe_ds_val     (exe_ds_val     ),
    .exe_ds_val2    (exe_ds_val2    ),
    .exe_store      (exe_store      ),
    .exe_mret       (exe_mret       ),
    .exe_wfi        (exe_wfi        ),
    .exe_pc         (exe_pc         ),
    .exe_exp_vld    (exe_exp_vld    ),
    .exe_exp_cause  (exe_exp_cause  ),
    
    //data forward
    .multicyc_ok    (multicyc_ok    ),
    .exe_comb_ds_val (exe_comb_ds_val ),   //valid when dec_vld=1
    .exe_comb_ds_val2(exe_comb_ds_val2),

    .clk            (clk            ),
    .rstn           (rstn           )
);


mrisc_d_aph u_mrisc_d_aph(
    //exe pipe output (reged)
    .exe_vld        (exe_vld        ),
    .exe_ack        (exe_ack        ),
    .exe_fun3       (exe_fun3       ),
    .exe_reg_wr     (exe_reg_wr     ),
    .exe_reg_wr_load(exe_reg_wr_load),
    .exe_reg_dsa    (exe_reg_dsa    ),
    .exe_csr_wr     (exe_csr_wr     ),
    .exe_csr_dsa    (exe_csr_dsa    ),
    .exe_ds_val     (exe_ds_val     ),
    .exe_ds_val2    (exe_ds_val2    ),
    .exe_store      (exe_store      ),
    .exe_mret       (exe_mret       ),
    .exe_wfi        (exe_wfi        ),
    .exe_pc         (exe_pc         ),
    .exe_exp_vld    (exe_exp_vld    ),
    .exe_exp_cause  (exe_exp_cause  ),

    //flow ctrl signal
    .wb_wait_trap   (wb_wait_trap   ),

    //d_aph pipe output(reged)
    .d_aph_vld      (d_aph_vld      ),
    .d_aph_ack      (d_aph_ack      ),
    .d_aph_fun3     (d_aph_fun3     ),
    .d_aph_reg_wr   (d_aph_reg_wr   ),
    .d_aph_reg_wr_load(d_aph_reg_wr_load),
    .d_aph_reg_dsa  (d_aph_reg_dsa  ),
    .d_aph_csr_wr   (d_aph_csr_wr   ),
    .d_aph_csr_dsa  (d_aph_csr_dsa  ),
    .d_aph_ds_val   (d_aph_ds_val   ),
    .d_aph_ds_val2  (d_aph_ds_val2  ),
    .d_aph_store    (d_aph_store    ),
    .d_aph_mret     (d_aph_mret     ),
    .d_aph_wfi      (d_aph_wfi      ),
    .d_aph_pc       (d_aph_pc       ),
    .d_aph_exp_vld  (d_aph_exp_vld  ),
    .d_aph_exp_cause(d_aph_exp_cause),

    //d-bus(ahb-lite) cmd phase singals
	.d_haddr		(d_haddr		),
	.d_hburst		(d_hburst		),
	.d_htrans		(d_htrans		),
	.d_hsize		(d_hsize		),
	.d_hprot		(d_hprot		),
	.d_hwrite		(d_hwrite		),
    .d_hmastlock    (d_hmastlock    ),
    .d_hready       (d_hready       ),
                                    
    .clk            (clk            ),
    .rstn           (rstn           )  
);


mrisc_wb u_mrisc_wb(
    //d_aph pipe output(reged)
    .d_aph_vld      (d_aph_vld      ),
    .d_aph_ack      (d_aph_ack      ),
    .d_aph_fun3     (d_aph_fun3     ),
    .d_aph_reg_wr   (d_aph_reg_wr   ),
    .d_aph_reg_wr_load(d_aph_reg_wr_load),
    .d_aph_reg_dsa  (d_aph_reg_dsa  ),
    .d_aph_csr_wr   (d_aph_csr_wr   ),
    .d_aph_csr_dsa  (d_aph_csr_dsa  ),
    .d_aph_ds_val   (d_aph_ds_val   ),
    .d_aph_ds_val2  (d_aph_ds_val2  ),
    .d_aph_store    (d_aph_store    ),
    .d_aph_mret     (d_aph_mret     ),
    .d_aph_wfi      (d_aph_wfi      ),
    .d_aph_pc       (d_aph_pc       ),
    .d_aph_exp_vld  (d_aph_exp_vld  ),
    .d_aph_exp_cause(d_aph_exp_cause),

    //d-bus(ahb-lite) data phase signals
    .d_hwdata       (d_hwdata       ),
    .d_hwbe         (   ),
    .d_hready       (d_hready       ),
    .d_hrdata       (d_hrdata       ),
    .d_hresp        (d_hresp        ),

    //load OP data forward
    .d_dph_ext_rdata(d_dph_ext_rdata),

    //regs/csr write back
    .reg_wr         (reg_wr         ),
    .reg_wdata      (reg_wdata      ),
    .reg_waddr      (reg_waddr      ),
    .csr_wr         (csr_wr         ),
    .csr_wdata      (csr_wdata      ),
    .csr_waddr      (csr_waddr      ),

    //wb output ctrl signal
    .wb_wfi         (wb_wfi         ),
    .wb_mret        (wb_mret        ),

    //exception detected
    .wb_wait_trap   (wb_wait_trap   ),
    .wb_exp_vld     (wb_exp_vld     ),
    .wb_exp_cause   (wb_exp_cause   ),
    .wb_pc          (wb_pc          ),
    .wb_dbus_addr   (wb_dbus_addr   ),
    .i_go_trap      (i_go_trap      ),
                                    
    .clk            (clk            ),
    .rstn           (rstn           ) 
);


mrisc_csr_intr u_mrisc_csr_intr(
    //csr read/write
    .csr_rsa        (csr_rsa        ),
    .csr_rs         (csr_rs         ),
    .csr_wr         (csr_wr         ),
    .csr_wdata      (csr_wdata      ),
    .csr_waddr      (csr_waddr      ),
    
    //external irq
    .ext_irq        (ext_irq        ),
    .clk_req        (clk_req        ),

    //wb to intr_ctrl(comb)
    .wb_wfi         (wb_wfi         ),
    .wb_mret        (wb_mret        ),

    //write back to intr_ctrl
    .wb_exp_vld     (wb_exp_vld     ),
    .wb_exp_cause   (wb_exp_cause   ),
    .wb_pc          (wb_pc          ),
    .wb_dbus_addr   (wb_dbus_addr   ),

    //CSR and interrupt req inf
    .irq_wait_trap  (irq_wait_trap  ),
    .trap_req       (trap_req       ),
    .trap_ack       (trap_ack       ),
    .i_go_trap      (i_go_trap      ),
    .cpu_idle       (cpu_idle       ),
    .csr_mtvec      (csr_mtvec      ),
    .csr_mcause     (csr_mcause     ),
    .csr_mepc       (csr_mepc       ),
    .pc             (pc             ),
                                    
    .clk            (clk            ),
    .clk_awo        (clk_awo        ),
    .rstn           (rstn           ) 
);



endmodule

