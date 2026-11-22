`timescale 1ns / 1ps
/****************************************Copyright (c)**************************************************
**----------------------------------------File Info-----------------------------------------------------
** File name					:	top                                                                   
** Last modified Date	:	2025-09-01                                                                      
** Last Version				:	1.0                                                                             
** Descriptions       :	top                                                           
**------------------------------------------------------------------------------------------------------
** Created by					: FPGACoreCG                                                                     
** Created date				: 2025-09-01                                                                     
** Version						: 1.0                                                                              
** Descriptions				:	The original version                                                            
**------------------------------------------------------------------------------------------------------
** Modified by:				                                                                                  
** Modified date:			                                                                                  
** Version:					                                                                                    
** Descriptions:		                                                                                    
**                                                                                                      
**------------------------------------------------------------------------------------------------------
*******************************************************************************************************/

`include "./../../src/define.sv"

module top(
  input   logic 	       		sys_clk_p     					,  
  input   logic 	       		sys_clk_n     					,  
  input   logic 	       		sys_rst_n     					,
 	input		logic							key_in									,
 	input		logic							uart_rx									,
 	output	logic							uart_tx									,
  output  logic [3:0]	      led                 	
);

localparam CLK_FRE 					= 100000000							;
localparam BAUDRATE					= 115200								;
localparam PARITY						= 0											;
localparam ODD_EVEN					=	1											;
localparam TX_DW 						= 25										;
localparam RX_DW 						= 2											;
localparam TX_HEAD     			= 8'h5a   							;
localparam TX_TAIL     			= 8'ha5   							;
localparam RX_HEAD     			= 8'h5a   							;
localparam RX_TAIL     			= 8'ha5   							;


logic												sys_clk									;
logic												rst_n										;
logic												riscv_rst_n							;
logic	[3:0]									led_pattern							;
(*mark_debug = "true"*)logic											key_out									;
(*mark_debug = "true"*)logic [31:0]			 					test_case  							;
(*mark_debug = "true"*)logic [31:0]								reg_s10  								;
(*mark_debug = "true"*)logic [31:0]								reg_s11  						  	; 
logic	[1:0]									ts_flag									;

logic	[TX_DW*8-1:0]					send_success						;
logic	[TX_DW*8-1:0] 				send_fail								;
logic												tx_vld									;
logic	[TX_DW*8-1:0]					tx_data 								;
logic												tx_done 								; 
logic												rx_vld									;
logic	[RX_DW*8-1:0]					rx_data 								;

assign	ts_flag			 =      {reg_s10[0],reg_s11[0]}	;
assign	led_pattern	 =			{2'h0,ts_flag}					;
assign	riscv_rst_n	 =			rst_n	& key_out					;

assign	send_success = 			"risv-v test success !!!!\n";
assign	send_fail 	 = 			"risv-v test fail    !!!!\n";

assign	tx_vld       =			rx_vld && (rx_data == 16'h55aa);
assign	tx_data			 =      (ts_flag == 2'b11) ? send_success : send_fail;

clk_pll u_clk_pll_inst(
	.clk_out1     						(sys_clk        		 		),
  .resetn       						(sys_rst_n      		 		),
  .locked       						(rst_n         			 		),
  .clk_in1_p    						(sys_clk_p      		 		),
  .clk_in1_n    						(sys_clk_n      		 		)
); 
 
led_top u_led_top_inst(
	.clk											(sys_clk						 		),
	.rst_n										(rst_n			  			 		),
	.led_pattern							(led_pattern				 		),
	.led	        						(led								 		)
);

key_top u_key_top_inst(
	.clk											(sys_clk						 		),
	.rst_n										(rst_n			  			 		),
	.key_in  									(key_in							 		),
	.key_out									(key_out						 		),
	.key_redge								(										 		),
	.key_fedge								(										 		)
);

riscv #(
	.FILE											(`FILE									),
	.AW												(`AW										),	
	.DW												(`DW										)
	) u_riscv_inst(                                			
	.clk											(sys_clk						 		),
  .rst_n										(riscv_rst_n						),
  .test_case								(test_case					 		),
	.reg_s10									(reg_s10						 		),
	.reg_s11	 								(reg_s11						 		)
);  


uart_top #(
	.CLK_FRE 									(CLK_FRE 		  			 		),
	.BAUDRATE									(BAUDRATE		  			 		),
	.PARITY   								(PARITY			  			 		),
	.ODD_EVEN									(ODD_EVEN		  			 		),
	.SEND_NBYTE								(TX_DW 				 					),
	.RECV_NBYTE								(RX_DW 				 					),
	.TX_HEAD    							(TX_HEAD      			 		),
	.TX_TAIL    							(TX_TAIL      			 		),
	.RX_HEAD    							(RX_HEAD      			 		),
	.RX_TAIL    							(RX_TAIL      			 		)
	)u_uart_top_inst(                              		
  .clk											(sys_clk						 		),
  .rst_n										(rst_n			  			 		),
  .tx_ctrl      						(4'h0 									), 
  .rx_ctrl      						(4'h0					 					),  
  .rxd											(uart_rx								 ),
  .send_en									(tx_vld	  				 			),
  .send_data								(tx_data					 			),
  .send_done								(tx_done					 			),
  .txd											(uart_tx								 ),
  .recv_vld     						(rx_vld	 					 			),
  .recv_data								(rx_data					 			)
);
    
endmodule
