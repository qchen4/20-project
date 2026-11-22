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
// File name    : jls_stream_recv.v
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
//----------------------------------------------------------------------------//

`include    "sim_define.v"

module jls_stream_recv(
    sof         ,
    xsize       ,
    ysize       ,

    //handshake with stream output
    stream_vld  ,
    stream_bytes,
    stream_eof  ,
    stream_ack  ,
    stream_len  ,
    stream      ,

    clk         ,
    rstn         
);


input   wire            clk, rstn       ;
input   wire            sof             ;
input   wire    [15:0]  xsize, ysize    ;   //cnt from 1

//handshake with stream output
input   wire            stream_vld      ;   //1 or 2 byte is valid in stream
input   wire            stream_bytes    ;   //0: only stream[7:0] is valid; 1: stream[15:0] is valid
input   wire            stream_eof      ;   //high level active: stream output end for a frame; align with last stream_vld or later
output  reg             stream_ack      ;
input   wire    [23:0]  stream_len      ;   //stream byte length, cnt from 1; valid before last stream_vld
input   wire    [15:0]  stream          ;   //first bit on bit[7] of a byte, little-endian byte order


integer     fp  ;

task wait_cyc;
input   [15:0]  n;
begin
    if(n != 0) begin 
        repeat(n) @(posedge clk);
        #1;
    end
end
endtask

initial begin
    @(posedge rstn);

    fp = $fopen("./trc/out.jls", "wb");
    if(fp == 0) begin
        $display("Sim Error: File ./trc/out.jls can't open for write. Which is needed by %m .");
        $finish();
    end

    //--- SW generate jls iamge header
    //16'hffd8
    $fwrite(fp, "%c", 8'hff); 
    $fwrite(fp, "%c", 8'hd8); 

    //SOF header
    //16'hfff7
    $fwrite(fp, "%c", 8'hff); 
    $fwrite(fp, "%c", 8'hf7); 
    //header length: 16'h000b, for grayscale image
    $fwrite(fp, "%c", 8'h00); 
    $fwrite(fp, "%c", 8'h0b); 
    //bit per pixel
    $fwrite(fp, "%c", 8'h08); 
    //ysize
    $fwrite(fp, "%c", ysize[15:8]); 
    $fwrite(fp, "%c", ysize[7:0]); 
    //xsize
    $fwrite(fp, "%c", xsize[15:8]); 
    $fwrite(fp, "%c", xsize[7:0]); 
    //number of color component
    $fwrite(fp, "%c", 8'h1); 
    //color componet info
    $fwrite(fp, "%c", 8'h01); 
    $fwrite(fp, "%c", 8'h11); 
    $fwrite(fp, "%c", 8'h00); 

    @(posedge stream_eof);

    //wait last stream been received
    wait_cyc(1);
    while(!stream_ack) begin
        @(posedge clk);
    end
    
    wait_cyc(2);
    
    //write file eof indentifier: 16'hffd9
    $fwrite(fp, "%c", 8'hff); 
    $fwrite(fp, "%c", 8'hd9); 
    
    $fclose(fp);
end

reg     [7:0]   rand        ;
reg     [4:0]   wcyc        ;


initial begin
    stream_ack   = 1'b0;

    while(1) begin
        if(`SIM_OUT_EN_WAIT == 1) begin
            rand = $unsigned($random());
            if(rand < 128)              wcyc = 0;
            else if(rand < (128+64))    wcyc = 1;
            else if(rand < (128+96))    wcyc = 2;
            else                        wcyc = rand[4:0];
        end else begin
            wcyc = 0;
        end

        wait_cyc(wcyc);
        stream_ack = 1'b1;

        @(posedge clk);
        while(!stream_vld) begin
            @(posedge clk);
        end

        #1; stream_ack = 1'b0;
    end
end


always @(posedge clk)
if(rstn && stream_vld && stream_ack) begin
    if(stream_bytes) begin
        $fwrite(fp, "%c", stream[7:0]); 
        $fwrite(fp, "%c", stream[15:8]); 
    end else begin
        $fwrite(fp, "%c", stream[7:0]); 
    end
end

endmodule

