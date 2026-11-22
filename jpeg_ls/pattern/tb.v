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

`include    "sim_define.v"
`timescale  1ns / 100ps

module tb();

parameter   clk_cyc = 10.0;
parameter   xy_bits = 11;

reg         clk, rstn       ;

always #(clk_cyc/2) clk = ~clk;

initial begin
    clk = 0; rstn = 0;

    repeat(10) @(posedge clk);
    #1;
    rstn = 1'b1;
end



wire            sim_end     ;
//cfg info
wire    [15:0]  xsize       ;   //cnt from 1, frame x len should be 2*N pixels (odd pixel number)
wire    [15:0]  ysize       ;   //cnt from 1

//image pixel recv
wire            sof             ;   //1T pulse start a frame
wire    [1:0]   comp_id         ;   //color component id of this sof trigger
wire            pixel_vld       ;
wire    [7:0]   pixel           ;
wire            pixel_ack       ;

//handshake with stream output
wire            stream_vld      ;   //1 or 2 byte is valid in stream
wire            stream_bytes    ;   //0: only stream[7:0] is valid; 1: stream[15:0] is valid

wire            stream_eof      ;   //high level active: stream output end for a frame; align with last stream_vld or later
wire            stream_ack      ;
wire    [23:0]  stream_len      ;   //stream byte length, cnt from 1; valid before last stream_vld
wire    [15:0]  stream          ;   //first bit on bit[7] of a byte, little-endian byte order


wire            pixel_ack_buf   ;
wire            stream_vld_buf  ;
wire            stream_bytes_buf;
wire            stream_eof_buf  ;  
wire    [23:0]  stream_len_buf  ;  
wire    [15:0]  stream_buf      ;  


wire    [xy_bits-1:0]   xsize_0 ;   //cnt from 0
wire    [xy_bits-1:0]   ysize_0 ;

assign  #1 pixel_ack_buf = pixel_ack;
assign  #1 stream_bytes_buf = stream_bytes;
assign  #1 stream_vld_buf= stream_vld;
assign  #1 stream_eof_buf= stream_eof;
assign  #1 stream_len_buf= stream_len;
assign  #1 stream_buf    = stream;

assign  xsize_0 = xsize - 1;
assign  ysize_0 = ysize - 1;

jls_image_file_parse #(.in_fname(`IN_FNAME)) u_jls_image_file_parse(
    //image pixel recv
    .sof            (sof            ),
    .comp_id        (comp_id        ),
    .pixel_vld      (pixel_vld      ),
    .pixel          (pixel          ),
    .pixel_ack      (pixel_ack_buf  ),    
    .xsize          (xsize          ),
    .ysize          (ysize          ),
    .sim_end        (sim_end        ),
                                    
    .clk            (clk            ),
    .rstn           (rstn           ) 
);


jls_enc #(.xy_bits(xy_bits)) u_jls_enc(
    //cfg info
    .xsize          (xsize_0        ),
    .ysize          (ysize_0        ),

    //image pixel recv
    .sof            (sof            ),
    .comp_id        (comp_id        ),
    .pixel_vld      (pixel_vld      ),
    .pixel          (pixel          ),
    .pixel_ack      (pixel_ack      ),
 
    //handshake with stream output
    .stream_vld     (stream_vld     ),
    .stream_bytes   (stream_bytes   ),
    .stream_eof     (stream_eof     ),
    .stream_ack     (stream_ack     ),
    .stream_len     (stream_len     ),
    .stream         (stream         ),

    .clk            (clk            ),
    .rstn           (rstn           )
);


jls_stream_recv u_jls_stream_recv(
    .sof            (sof            ),
    .xsize          (xsize          ),
    .ysize          (ysize          ),

    //handshake with stream output
    .stream_vld     (stream_vld_buf ),
    .stream_bytes   (stream_bytes_buf),
    .stream_eof     (stream_eof_buf ),
    .stream_ack     (stream_ack     ),
    .stream_len     (stream_len_buf ),
    .stream         (stream_buf     ),
                                    
    .clk            (clk            ),
    .rstn           (rstn           ) 
);



jls_sim_trace u_jls_sim_trace(
    .sof            (sof            ),
    .xsize          (xsize          ),
    .ysize          (ysize          ),
                                    
    .sim_end        (sim_end        ),
                                    
    .clk            (clk            ),
    .rstn           (rstn           ) 
);


endmodule

