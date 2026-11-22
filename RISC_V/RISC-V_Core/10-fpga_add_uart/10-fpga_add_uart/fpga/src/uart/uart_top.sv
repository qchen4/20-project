`timescale 1ns / 1ps                                                                                       
/****************************************Copyright (c)**************************************************   
**----------------------------------------File Info-----------------------------------------------------   
** File name					:	uart_top                                                                   
** Last modified Date	:	2025-09-02                                                                         
** Last Version				:	1.0                                                                                
** Descriptions       :	uart_top                                                               
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
********************************************************************************************************/  

module uart_top# (
	parameter CLK_FRE 							= 100000000			,
	parameter BAUDRATE 							= 115200				,
	parameter	PARITY      					= 1							,
	parameter	ODD_EVEN    					= 1							,
	parameter SEND_NBYTE 						= 10						,
	parameter RECV_NBYTE 						= 10					  ,
	parameter TX_HEAD     					= 8'h5a         ,
	parameter TX_TAIL     					= 8'ha5         ,
	parameter RX_HEAD     					= 8'h5a         ,
	parameter RX_TAIL     					= 8'ha5         
	)( 
	input  logic      								clk						,
	input  logic      								rst_n					,
	input	 logic 	[3:0] 							tx_ctrl				,
	input	 logic 	[3:0] 							rx_ctrl				, 
	input  logic      								rxd						,
	input  logic      								send_en				,
	input  logic	[SEND_NBYTE*8-1:0] 	send_data			,
	output logic       								send_done			,
	output logic      								txd						,
	output logic      								recv_vld   		,
	output logic	[RECV_NBYTE*8-1:0] 	recv_data	 	
);  
    
uart_transmitter #(
  .NBYTE    					(SEND_NBYTE     						),
	.CLK_FRE  					(CLK_FRE 	      						),
	.BAUDRATE 					(BAUDRATE	      						),
	.PARITY   					(PARITY  	      						),
	.ODD_EVEN						(ODD_EVEN	      						),
	.TX_HEAD  					(TX_HEAD        						),
	.TX_TAIL  					(TX_TAIL        						)
)	u_uart_transmitter_inst(
	.clk			    			(clk	   	    							),
	.rst_n		    			(rst_n			  							),
	.tx_ctrl      			(tx_ctrl      							),
	.send_en		  			(send_en     								),
	.send_data	  			(send_data	  							),
	.txd								(txd		 		 								),
	.send_done	  			(send_done									)
);

uart_receiver #(
  .NBYTE    					(RECV_NBYTE 								),
	.CLK_FRE  					(CLK_FRE 	  								),
	.BAUDRATE 					(BAUDRATE	  								),
	.PARITY   					(PARITY  	  								),
	.ODD_EVEN						(ODD_EVEN 									),
	.RX_HEAD  					(RX_HEAD    								),
	.RX_TAIL  					(RX_TAIL    								)
)	u_uart_receiver_inst	( 
	.clk			    			(clk	       								),
	.rst_n			  			(rst_n		   								),
	.rx_ctrl						(rx_ctrl     								),
	.rxd								(rxd	  		 								),
	.recv_vld     			(recv_vld    								),
	.recv_data    			(recv_data	 								)
);
endmodule
