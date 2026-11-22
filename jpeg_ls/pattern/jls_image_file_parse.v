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
// File name    : jls_image_file_parse.v
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
// 1: Read in *.pgm or *.ppm(not support yet) file, send pixel value to DUT;
//----------------------------------------------------------------------------//

`include "sim_define.v"

module jls_image_file_parse(
    //image pixel recv
    sof         ,
    comp_id     ,
    pixel_vld   ,
    pixel       ,
    pixel_ack   ,
    xsize       ,
    ysize       ,
    
    sim_end     ,

    clk         ,
    rstn         
);


parameter   in_fname = "./in.pgm";

input   wire            clk, rstn       ;
output  reg             sim_end         ;

//image pixel recv
output  reg             sof             ;   //1T pulse start a frame
output  reg     [1:0]   comp_id         ;
output  reg             pixel_vld       ;
output  reg     [7:0]   pixel           ;
input   wire            pixel_ack       ;
output  reg     [15:0]  xsize, ysize    ;   //cnt from 1


integer         fp      ;
reg     [7:0]   c       ;
reg     [31:0]  max     ;
reg     [31:0]  x, y    ;
reg     [7:0]   rand    ;
reg     [5:0]   wcyc    ;

task wait_cyc;
input   [15:0]  n;
begin
    if(n != 0) begin 
        repeat(n) @(posedge clk);
        #1;
    end
end
endtask

task pgm_head_err;
begin
    $display("Sim Error: PGM header error in file %s.", in_fname);
    $finish();
end
endtask

initial begin
    sim_end = 0;
    sof = 0; pixel_vld = 0; pixel = 8'hff; comp_id = 1;

    fp = $fopen(in_fname, "rb");
    if(fp == 0) begin
        $display("Sim Error: File %s doesn't exist. Which is needed by %m .", in_fname);
        $finish();
    end

    //parse pgm file header
    c = $fgetc(fp);
    if(c != "P")    pgm_head_err;
    
    c = $fgetc(fp);
    if(c != "5")    pgm_head_err;   //5:gray scale; 6: 3 color component

    $fscanf(fp, "%d%d%d", xsize, ysize, max);
    if((xsize >(1 << 16)) || (ysize >(1 << 16)) || (max>255))
        pgm_head_err;

    c = $fgetc(fp);                 //line front char

    @(posedge rstn);
    wait_cyc(5);

    sof = 1;
    wait_cyc(1);
    sof = 0;

    //send pixel of this frame
    for(y=0; y<ysize; y=y+1) begin
        for(x=0; x<xsize; x=x+1) begin
            wcyc=0;
            if(`SIM_IN_EN_WAIT == 1) begin
                rand = $unsigned($random());    //0~255
                if(rand < 128)              wcyc = 0;
                else if(rand < (128+64))    wcyc = 1;
                else if(rand < (128+96))    wcyc = 2;
                else                        wcyc = rand[4:0];
            end

            wait_cyc(wcyc);
            c = $fgetc(fp);
            pixel_vld = 1'b1; pixel = c;

            @(posedge clk);
            while(!pixel_ack) begin
                @(posedge clk);
            end
            
            #1; pixel_vld = 0;
        end
    end

    wait_cyc(1000);
    sim_end = 1;
    @(posedge clk);
    $fclose(fp);
    $finish();

end


endmodule

