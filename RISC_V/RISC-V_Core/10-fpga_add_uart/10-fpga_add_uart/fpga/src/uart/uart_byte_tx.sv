`timescale 1ns / 1ps
/****************************************Copyright (c)**************************************************
**----------------------------------------File Info-----------------------------------------------------
** File name					:	uart_byte_tx                                                                   
** Last modified Date	:	2025-09-02                                                                      
** Last Version				:	1.0                                                                             
** Descriptions       :	uart tx module                                                           
**------------------------------------------------------------------------------------------------------
** Created by					: FPGACoreCG                                                                              
** Created date				:	2025-09-02                                                                      
** Version						: 1.0                                                                             
** Descriptions				:	The original version                                                            
**------------------------------------------------------------------------------------------------------
** Modified by				:				                                                                          
** Modified date			:			                                                                            
** Version						:					                                                                        
** Descriptions				:		                                                                                                      
**------------------------------------------------------------------------------------------------------
*******************************************************************************************************/

module uart_byte_tx#(
	parameter CLK_FRE 		= 100000000							, 
	parameter BAUDRATE		=	115200								,
	parameter PARITY    	= 1'b1									, 
	parameter	ODD_EVEN		=	1'b1 		      				
	)(                                    				
	input		logic						clk										,
	input		logic						rst_n									,
	input		logic						din_vld     					,
	input		logic	[7:0]			din										,
	output	logic						txd										,
	output	logic						txd_done	  				
);

parameter BYTE_NUM      = PARITY ? 11 : 10			;
parameter BANURATE_NUM 	= CLK_FRE/BAUDRATE - 8	;

logic           send_domain				;
logic [ 7:0]		byte_cnt					;
logic [15:0]		baudrate_cnt 			;

logic          one_byte_cnt_done	;
logic          all_byte_cnt_done	;
logic					 parity_bit					;

assign			  one_byte_cnt_done	=	(baudrate_cnt == (BANURATE_NUM - 16'h1));	
assign        all_byte_cnt_done	= (byte_cnt == (BYTE_NUM - 8'h1));
assign 				parity_bit        = ^{din,ODD_EVEN};

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		send_domain <=	1'h0;
	else if(din_vld) 
		send_domain <=	1'h1;
	else if(txd_done)
		send_domain <=	1'h0;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		baudrate_cnt <=	16'h0;
	else if(send_domain) begin
		if(one_byte_cnt_done)
			baudrate_cnt <=	16'h0;
		else
			baudrate_cnt <=	baudrate_cnt + 16'h1;
	end
	else
		baudrate_cnt <=	16'h0;
	
always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		byte_cnt <=	8'h0;
	else if(send_domain) begin
		if(one_byte_cnt_done) begin
			if(all_byte_cnt_done)
				byte_cnt <=	8'h0;
			else
				byte_cnt <=	byte_cnt + 8'h1;
		end
	end
	else
		byte_cnt <=	8'h0;

logic	[10:0]		din_tmp;
always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		din_tmp <=	11'd0;
	else if(din_vld) 
		din_tmp <=	PARITY ? {1'b1,parity_bit,din,1'b0}:{1'b1,1'b1,din,1'b0};
	else if(send_domain && one_byte_cnt_done)
		din_tmp <=	{1'b1,din_tmp[10:1]};

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		txd <=	1'h1;
	else if(send_domain)
		txd <=	din_tmp[0];
	else
		txd <=	1'h1;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		txd_done <=	1'h0;
	else if(send_domain && one_byte_cnt_done && all_byte_cnt_done)
		txd_done <=	1'h1;
	else
		txd_done <=	1'h0;

endmodule
