`timescale 1ns / 1ps
/****************************************Copyright (c)**************************************************                               
**----------------------------------------File Info-----------------------------------------------------
** File name:							uart_tx
** Last modified Date:		2025-09-02
** Last Version:					1.0 
** Descriptions:					uart rx module
**------------------------------------------------------------------------------------------------------
** Created by:      			FPGACoreCG
** Created date:					2025-09-02
** Version:         			0.1
** Descriptions:					The original version
**------------------------------------------------------------------------------------------------------
** Modified by				:				                                                                          
** Modified date			:			                                                                            
** Version						:					                                                                        
** Descriptions				:		  
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/
module uart_byte_rx#(
	parameter CLK_FRE 	= 100000000			, 
	parameter BAUDRATE	=	115200				,
	parameter PARITY    = 1'b1					, 
	parameter	ODD_EVEN	=	1'b1 		  
	)( 
  input		logic						clk					,
  input		logic						rst_n				,
  input		logic						rxd					,
	output	logic						dout_vld		,
	output	logic [7:0]  		dout		     
);

parameter BYTE_NUM  		= PARITY ? 11 : 10      ;
parameter DATA_BYTE_NUM = PARITY ? BYTE_NUM - 3 : BYTE_NUM - 2;
parameter BAUDRATE_NUM 	= CLK_FRE/BAUDRATE - 8	;
parameter GET_DATA_NUM  = BAUDRATE_NUM/2    		;

logic           rx_sync0					;
logic           rx_sync1					;
logic           rx_sync2					;
logic           rx_detect					;
logic           recv_domain				;
logic [ 7:0]		byte_cnt					;
logic [15:0]		baudrate_cnt 			;
logic          	one_byte_cnt_done	;
logic          	all_byte_cnt_done	;
logic         	get_data_point		;
logic [ 7:0]    dout_tmp					;
logic           stop_ok						;
logic          	parity_bit        ;
logic           recv_parity_ok		;
logic           data_ok						;

assign 	all_byte_cnt_done	= (byte_cnt == (BYTE_NUM - 8'h1));
assign	one_byte_cnt_done	=	(baudrate_cnt == (BAUDRATE_NUM - 16'h1));	
assign  get_data_point    = (baudrate_cnt == (GET_DATA_NUM - 16'h1));
assign 	parity_bit				= ^{dout_tmp,ODD_EVEN} && (byte_cnt == 9)	;
assign  data_ok           = PARITY ? (recv_parity_ok && stop_ok) : stop_ok;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) begin
		rx_sync0	<= 1'b1;
		rx_sync1	<= 1'b1;
		rx_sync2	<= 1'b1;
	end
	else begin
		rx_sync0	<= rxd				;
		rx_sync1	<= rx_sync0		;
		rx_sync2	<= rx_sync1		;
	end

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		rx_detect <=	1'h0;
	else if(recv_domain)
		rx_detect <=	1'h0;
	else if(~rx_sync1 && rx_sync2) 
		rx_detect <=	1'h1;
	else 
		rx_detect <=	1'h0;
		
always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		recv_domain <=	1'h0;
	else if(rx_detect) 
		recv_domain <=	1'h1;
	else if(all_byte_cnt_done && one_byte_cnt_done)
		recv_domain <=	1'h0;
	
always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		byte_cnt <=	8'h0;
	else if(recv_domain) begin
		if(one_byte_cnt_done) begin
			if(all_byte_cnt_done)
				byte_cnt <=	8'h0;
			else
				byte_cnt <=	byte_cnt + 8'h1;
		end
	end
	else
		byte_cnt <=	8'h0;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		baudrate_cnt <=	16'h0;
	else if(recv_domain) begin
		if(one_byte_cnt_done)
			baudrate_cnt <=	16'h0;
		else
			baudrate_cnt <=	baudrate_cnt + 16'h1;
	end
	else
		baudrate_cnt <=	16'h0;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		dout_tmp <=	8'hff;
	else if(recv_domain) begin
		if((byte_cnt > 0) && (byte_cnt <= DATA_BYTE_NUM) && get_data_point)
			dout_tmp <=	{rx_sync2,dout_tmp[7:1]};
		else
			dout_tmp <=	dout_tmp;
	end
	else
		dout_tmp <=	8'hff;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		recv_parity_ok <=	1'h0;
	else if(recv_domain && PARITY) begin
		if((byte_cnt == 9) && get_data_point) begin
			if(parity_bit == rx_sync2)
				recv_parity_ok <=	1'b1;
			else
				recv_parity_ok <=	1'b0; 
		end
	end
	else
		recv_parity_ok <=	1'h0;	

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		stop_ok <=	1'h0;
	else if(recv_domain) begin
		if( (byte_cnt == BYTE_NUM - 1) && get_data_point && rx_sync2)
			stop_ok <=	1'h1;
		else
			stop_ok <=	stop_ok;
	end
	else
		stop_ok <=	1'h0;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		dout_vld <=	1'h0;
	else if(one_byte_cnt_done && all_byte_cnt_done && data_ok)
		dout_vld <=	1'h1;
	else
		dout_vld <=	1'h0;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) 
		dout <=	'h0;
	else if(one_byte_cnt_done && all_byte_cnt_done && data_ok)
		dout <=	dout_tmp;
	else
		dout <=	dout;

endmodule