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
// File name    : jls_sim_trace.v
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
// 1: save intermidiate data to file to compare with c model.
//----------------------------------------------------------------------------//

`define DUT         tb.u_jls_enc
`define DUT_PIPE    tb.u_jls_enc.u_jls_pipe_s1_s8

module jls_sim_trace(
    sof         ,
    xsize       ,
    ysize       ,

    sim_end     ,

    clk         ,
    rstn         
);

parameter   xy_bits = 11;


input   wire            clk, rstn   ;
input   wire    [15:0]  xsize, ysize;
input   wire            sof         ;
input   wire            sim_end     ;

integer     fp_s0, fp_s1, fp_s2, fp_s4, fp_s5;
integer     fp_s6, fp_s7, fp_s8;

initial begin
    fp_s0 = $fopen("./trc/trace_s0.txt");
    fp_s1 = $fopen("./trc/trace_s1.txt");
    fp_s2 = $fopen("./trc/trace_s2.txt");
    fp_s4 = $fopen("./trc/trace_s4.txt");
    fp_s5 = $fopen("./trc/trace_s5.txt");
    fp_s6 = $fopen("./trc/trace_s6.txt");
    fp_s7 = $fopen("./trc/trace_s7.txt");
    fp_s8 = $fopen("./trc/trace_s8.txt");

    @(posedge sof);
    //--- header of each trace file
    $fdisplay(fp_s0,"xsize=%4h, ysize=%4h", xsize, ysize);
    $fdisplay(fp_s0,"xloc, yloc, pixel, a,  b,  c,  d");

    $fdisplay(fp_s1,"xloc, yloc, q1, q2, q3, enc_mode, run_hit, pred, ritype");
    $fdisplay(fp_s2,"len, val");
    $fdisplay(fp_s2,"xloc, yloc, q_idx, q_sign, runcnt, j_idx, glimit");
    $fdisplay(fp_s4,"xloc, yloc, a, b, c, n");
    $fdisplay(fp_s5,"xloc, yloc, enc_mode, error");
    $fdisplay(fp_s6,"xloc, yloc, err_modu, abs_err_modu, k");
    $fdisplay(fp_s7,"xloc, yloc, err_map, a, b, c, n");
    $fdisplay(fp_s8,"xloc, yloc, enc_mode, len, val");



    //--- close files
    @(posedge sim_end);
    $fclose(fp_s0);
    $fclose(fp_s1);
    $fclose(fp_s2);
    $fclose(fp_s4);
    $fclose(fp_s5);
    $fclose(fp_s6);
    $fclose(fp_s7);
    $fclose(fp_s8);
end


//--- 1: s0 trace
wire            s0_vld          ;   //handshake between s0 and s1
wire            s0_ack          ;
wire    [xy_bits-1:0]   s0_x    ;   //xloc within a frame, cnt from 0
wire    [xy_bits-1:0]   s0_y    ;   //yloc within a frame, cnt from 0
wire    [7:0]   s0_pixel        ;   //current pixel from JLS encoding
wire    [7:0]   s0_a            ;   //neighbour_a
wire    [7:0]   s0_b            ;   //neighbour_b
wire    [7:0]   s0_c            ;   //neighbour_c
wire    [7:0]   s0_d            ;   //neighbour_d

assign  s0_vld  = `DUT.s0_vld   ;
assign  s0_ack  = `DUT.s0_ack   ;
assign  s0_x    = `DUT.s0_x     ; 
assign  s0_y    = `DUT.s0_y     ; 
assign  s0_pixel= `DUT.s0_pixel ;
assign  s0_a    = `DUT.s0_a     ; 
assign  s0_b    = `DUT.s0_b     ; 
assign  s0_c    = `DUT.s0_c     ; 
assign  s0_d    = `DUT.s0_d     ; 

always @(posedge clk or negedge rstn)
if(rstn && s0_vld && s0_ack) begin
    $fdisplay(fp_s0, "%4h, %4h, %2h, %2h, %2h, %2h, %2h", s0_x, s0_y, s0_pixel, s0_a, s0_b, s0_c, s0_d);
end


//--- 2: s1 trace
wire            s1_vld          ;
wire            s1_ack          ;
wire    [xy_bits-1:0]   s1_x    ;
wire    [xy_bits-1:0]   s1_y    ;
wire    signed  [3:0]   s1_q1, s1_q2, s1_q3 ;   //quanted local gradient
wire            s1_enc_mode     ;   //0:normal mode; 1:run mode
wire            s1_run_hit      ;   //current pixel is encoded in run mode
wire    [7:0]   s1_pred         ;   //muxed pred pixel value
wire            s1_ritype       ;   //run mode un-hit RItype

assign  s1_vld      = `DUT_PIPE.s1_vld      ;
assign  s1_ack      = `DUT_PIPE.s1_ack      ;
assign  s1_x        = `DUT_PIPE.s1_x        ;
assign  s1_y        = `DUT_PIPE.s1_y        ;
assign  s1_q1       = `DUT_PIPE.s1_q1       ;
assign  s1_q2       = `DUT_PIPE.s1_q2       ;
assign  s1_q3       = `DUT_PIPE.s1_q3       ;
assign  s1_enc_mode = `DUT_PIPE.s1_enc_mode ;
assign  s1_run_hit  = `DUT_PIPE.s1_run_hit  ;
assign  s1_pred     = `DUT_PIPE.s1_pred     ;
assign  s1_ritype   = `DUT_PIPE.s1_ritype   ;

always @(posedge clk or negedge rstn)
if(rstn && s1_vld && s1_ack) begin
    $fwrite(fp_s1, "%4h, %4h, %1h, %1h, %1h, %1h, %1h, ", s1_x, s1_y, s1_q1, s1_q2, s1_q3, s1_enc_mode, s1_run_hit);

    if(s1_run_hit)
        $fdisplay(fp_s1, "%2h, %1h", 8'hff, 1'b1);
    else if(s1_enc_mode)
        $fdisplay(fp_s1, "%2h, %1h", s1_pred, s1_ritype);
    else
        $fdisplay(fp_s1, "%2h, %1h", s1_pred, 1'b0);
end

//--- 3: s2 trace
wire            s2_vld          ;
wire            s2_ack          ;
wire    [xy_bits-1:0]   s2_x    ;
wire    [xy_bits-1:0]   s2_y    ;
wire            s2_enc_mode     ;
wire            s2_run_hit      ;
wire    [8:0]   s2_q_idx        ;   //0~364: normal mode context id; 365~366: run mode context id
wire            s2_q_sign       ;   //sign of Q for normal mode(0:postive; 1:negative); ritype for run mode
wire    [14:0]  runcnt          ;
wire    [4:0]   j_idx           ;   //index to J array
wire    [4:0]   s2_run_glimit   ;   //7~22, after sub of "qbpp+1", used in golomb coding
wire    [4:0]   s2_run_syntax_len;  //0~16
wire    [15:0]  s2_run_syntax   ;



assign  s2_vld          = `DUT_PIPE.s2_vld          ;
assign  s2_ack          = `DUT_PIPE.s2_ack          ;
assign  s2_x            = `DUT_PIPE.s2_x            ;
assign  s2_y            = `DUT_PIPE.s2_y            ;
assign  s2_enc_mode     = `DUT_PIPE.s2_enc_mode     ;
assign  s2_run_hit      = `DUT_PIPE.s2_run_hit      ;
assign  s2_q_idx        = `DUT_PIPE.s2_q_idx        ;
assign  s2_q_sign       = `DUT_PIPE.s2_q_sign       ;
assign  runcnt          = `DUT_PIPE.runcnt          ;
assign  j_idx           = `DUT_PIPE.j_idx           ;
assign  s2_run_glimit   = `DUT_PIPE.s2_run_glimit   ;
assign  s2_run_syntax_len=`DUT_PIPE.s2_run_syntax_len;
assign  s2_run_syntax   = `DUT_PIPE.s2_run_syntax;

always @(posedge clk or negedge rstn)
if(rstn && s2_vld && s2_ack) begin
    if(s2_run_syntax_len != 'd0)
        $fdisplay(fp_s2, "%2h, %4h", s2_run_syntax_len, s2_run_syntax);

    if(!s2_run_hit) begin
        $fwrite(fp_s2, "%4h, %4h, %3h, ", s2_x, s2_y, s2_q_idx);
        if(s2_enc_mode)
            $fdisplay(fp_s2, "%1h, %4h, %2h, %2h", s2_q_sign, runcnt, j_idx, s2_run_glimit);
        else
            $fdisplay(fp_s2, "%1h, %4h, %2h, %2h", s2_q_sign, 16'h0, 8'h0, 8'h0);
    end else begin
        $fdisplay(fp_s2, "%4h, %4h, %4h, %2h", s2_x, s2_y, runcnt, j_idx);
    end
end


//--- 4: s4 trace
wire            s4_vld      ;
wire            s4_ack      ;
wire            s4_run_hit  ;
wire            s4_enc_mode ;
wire    [xy_bits-1:0]   s4_x    ;
wire    [xy_bits-1:0]   s4_y    ;
wire    [13+7+8+6-1:0] s4_abcn  ;   //context value for this pixel


assign  s4_vld      = `DUT_PIPE.s4_vld  ;
assign  s4_ack      = `DUT_PIPE.s4_ack  ;
assign  s4_run_hit  = `DUT_PIPE.s4_run_hit;
assign  s4_enc_mode = `DUT_PIPE.s4_enc_mode;
assign  s4_x        = `DUT_PIPE.s4_x    ;
assign  s4_y        = `DUT_PIPE.s4_y    ;
assign  s4_abcn     = `DUT_PIPE.s4_abcn ;


always @(posedge clk or negedge rstn)
if(rstn && s4_vld && s4_ack && (!s4_run_hit)) begin
    if(s4_enc_mode)
        $fdisplay(fp_s4, "%4h, %4h, %4h, %2h, %2h", s4_x, s4_y, s4_abcn[21+:13], s4_abcn[14+:7], (s4_abcn[0+:6] + 7'd1));
    else
        $fdisplay(fp_s4, "%4h, %4h, %4h, %2h, %2h, %2h", s4_x, s4_y, s4_abcn[21+:13], s4_abcn[14+:7], s4_abcn[6+:8], (s4_abcn[0+:6] + 7'd1));
end


//--- 5: s5 trace
wire            s5_vld      ;
wire            s5_ack      ;
wire            s5_run_hit  ;
wire            s5_enc_mode ;
wire    [8:0]   s5_err      ;
wire    [xy_bits-1:0]   s5_x    ;
wire    [xy_bits-1:0]   s5_y    ;


assign  s5_vld      = `DUT_PIPE.s5_vld      ;
assign  s5_ack      = `DUT_PIPE.s5_ack      ;
assign  s5_run_hit  = `DUT_PIPE.s5_run_hit  ;
assign  s5_enc_mode = `DUT_PIPE.s5_enc_mode ;
assign  s5_err      = `DUT_PIPE.s5_err      ;
assign  s5_x        = `DUT_PIPE.s5_x        ;
assign  s5_y        = `DUT_PIPE.s5_y        ;


always @(posedge clk or negedge rstn)
if(rstn && s5_vld && s5_ack && (!s5_run_hit)) begin
    $fdisplay(fp_s5, "%4h, %4h, %1h, %3h", s5_x, s5_y, s5_enc_mode, s5_err);
end


//--- 6: s6 trace
wire            s6_vld      ;
wire            s6_ack      ;
wire            s6_run_hit  ;
wire            s6_enc_mode ;
wire    [7:0]   s6_err_modu ;
wire    [7:0]   s6_abs_err_modu;
wire    [3:0]   s6_k        ;
wire    [xy_bits-1:0]   s6_x    ;
wire    [xy_bits-1:0]   s6_y    ;

assign  s6_vld          = `DUT_PIPE.s6_vld          ;
assign  s6_ack          = `DUT_PIPE.s6_ack          ;
assign  s6_run_hit      = `DUT_PIPE.s6_run_hit      ;
assign  s6_enc_mode     = `DUT_PIPE.s6_enc_mode     ;
assign  s6_err_modu     = `DUT_PIPE.s6_err_modu     ;
assign  s6_abs_err_modu = `DUT_PIPE.s6_abs_err_modu ;
assign  s6_k            = `DUT_PIPE.s6_k            ;
assign  s6_x            = `DUT_PIPE.s6_x            ;
assign  s6_y            = `DUT_PIPE.s6_y            ;


always @(posedge clk or negedge rstn)
if(rstn && s6_vld && s6_ack && (!s6_run_hit)) begin
    $fdisplay(fp_s6, "%4h, %4h, %2h, %2h, %1h", s6_x, s6_y, s6_err_modu, s6_abs_err_modu, s6_k);
end


//--- 7: s7 trace
wire            s7_vld      ;
wire            s7_ack      ;
wire            s7_run_hit  ;
wire            s7_enc_mode ;
wire    [8:0]   s7_err_map  ;
wire    [13+7+8+6-1:0] s7_abcn  ;
wire    [xy_bits-1:0]   s7_x    ;
wire    [xy_bits-1:0]   s7_y    ;

wire    [12:0]  s7_a            ;   //(0~128)*63
wire    [6:0]   s7_b            ;   //normal mode: -63~0; run mode: 0~64
wire    signed [7:0]   s7_c     ;   //-128~127
wire    [6:0]   s7_n            ;   //cnt from 1; 1~64


assign  s7_vld      = `DUT_PIPE.s7_vld      ;
assign  s7_ack      = `DUT_PIPE.s7_ack      ;
assign  s7_run_hit  = `DUT_PIPE.s7_run_hit  ;
assign  s7_enc_mode = `DUT_PIPE.s7_enc_mode ;
assign  s7_err_map  = `DUT_PIPE.s7_err_map  ;
assign  s7_abcn     = `DUT_PIPE.s7_abcn     ;
assign  s7_x        = `DUT_PIPE.s7_x        ;
assign  s7_y        = `DUT_PIPE.s7_y        ;

assign  s7_a        = s7_abcn[21+:13];
assign  s7_b        = s7_abcn[14+:7];
assign  s7_c        = s7_abcn[6+:8];
assign  s7_n        = s7_abcn[0+:6] + 7'd1;


always @(posedge clk or negedge rstn)
if(rstn && s7_vld && s7_ack && (!s7_run_hit)) begin
    if(s7_enc_mode)
        //$fdisplay(fp_s7, "%4h, %4h, %3h, %4h, %2h, %2h", s7_x, s7_y, s7_err_map, s7_abcn[21+:13], s7_abcn[14+:7], (s7_abcn[0+:6] + 7'd1));
        $fdisplay(fp_s7, "%4h, %4h, %3h, %4h, %2h, %2h", s7_x, s7_y, s7_err_map, s7_a, s7_b, s7_n);
    else
        //$fdisplay(fp_s7, "%4h, %4h, %3h, %4h, %2h, %2h, %2h", s7_x, s7_y, s7_err_map, s7_abcn[21+:13], s7_abcn[14+:7], s7_abcn[6+:8], (s7_abcn[0+:6] + 7'd1));
        $fdisplay(fp_s7, "%4h, %4h, %3h, %4h, %2h, %2h, %2h", s7_x, s7_y, s7_err_map, s7_a, s7_b, s7_c, s7_n);
end


//--- 8: s8 trace
wire            s8_vld          ;
wire            s8_ack          ;
wire            s8_run_hit      ;
wire            s8_enc_mode     ;
wire            s8_syntax1_vld  ;   //syntax for golomb coding of mapped error
wire    [5:0]   s8_syntax1_len  ;   //cnt from 1, 1~32
wire    [15:0]  s8_syntax1      ;
wire    [xy_bits-1:0]   s8_x    ;
wire    [xy_bits-1:0]   s8_y    ;

assign  s8_vld          = `DUT_PIPE.s8_vld          ;
assign  s8_ack          = `DUT_PIPE.s8_ack          ;
assign  s8_run_hit      = `DUT_PIPE.s8_run_hit      ;
assign  s8_enc_mode     = `DUT_PIPE.s8_enc_mode     ;
assign  s8_syntax1_vld  = `DUT_PIPE.s8_syntax1_vld  ;
assign  s8_syntax1_len  = `DUT_PIPE.s8_syntax1_len  ;
assign  s8_syntax1      = `DUT_PIPE.s8_syntax1      ;
assign  s8_x            = `DUT_PIPE.s8_x            ;
assign  s8_y            = `DUT_PIPE.s8_y            ;


always @(posedge clk or negedge rstn)
if(rstn && s8_vld && s8_ack && s8_syntax1_vld) begin
    $fdisplay(fp_s8, "%4h, %4h, %1h, %2h, %4h", s8_x, s8_y, s8_enc_mode, s8_syntax1_len, s8_syntax1);
end

/*
always @(posedge clk or negedge rstn)
if(~rstn)

else


always @(posedge clk or negedge rstn)
if(~rstn)

else


always @(posedge clk or negedge rstn)
if(~rstn)

else


always @(posedge clk or negedge rstn)
if(~rstn)

else


always @(posedge clk or negedge rstn)
if(~rstn)

else


always @(posedge clk or negedge rstn)
if(~rstn)

else


always @(posedge clk or negedge rstn)
if(~rstn)

else


always @(posedge clk or negedge rstn)
if(~rstn)

else


always @(posedge clk or negedge rstn)
if(~rstn)

else

*/

endmodule

