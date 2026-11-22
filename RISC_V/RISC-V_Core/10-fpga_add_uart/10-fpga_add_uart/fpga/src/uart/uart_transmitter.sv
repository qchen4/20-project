`timescale 1ns / 1ps
/****************************************Copyright (c)**************************************************                               
**----------------------------------------File Info-----------------------------------------------------
** File name					:	uart_transmitter
** Last modified Date	:	2025-02-10
** Last Version				:	1.0
** Descriptions       :	uart send NBYTE data
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

module uart_transmitter #(  
	parameter NBYTE     				= 4          				,
	parameter CLK_FRE 					= 100000000					,
	parameter BAUDRATE					=	115200						,
	parameter PARITY    				= 1'b1							,
	parameter	ODD_EVEN					=	1'b1 							,
	parameter TX_HEAD   				= 8'h5a         		,
	parameter TX_TAIL   				= 8'ha5         		
	)(
	input  logic         			  clk			  					,
	input  logic         			  rst_n		  					,
	input	 logic	[3:0]					tx_ctrl							,
	input  logic         			  send_en							,
	input  logic	[NBYTE*8-1:0]	send_data						,
	output logic                txd				  				,
	output logic					      send_done						 
);
localparam 	IDLE							=	3'd0  					 ,
            HEAD  						= 3'd1  					 ,
            LEN   						= 3'd2  					 ,
			      SEND							=	3'd3  					 ,
			      WAIT							=	3'd4  					 ,
			      CRC   						= 3'd5						 ,
			      TAIL  						= 3'd6  					 ;

logic [2:0] 									cur_state					;
logic [2:0]										nxt_state					;	
logic         								tx_en							;	
logic [7:0]										tx_data						; 
logic        									txd_done   				;	
logic [7:0] 									send_cnt					;	
logic [NBYTE*8-1:0] 					send_data_tmp			;
                    					              		
logic [7:0]    								crc_data_in				;
logic [7:0]    								crc_out						;
logic  [7:0]    							crc_out_dly				;
		
always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
    cur_state <= IDLE;
  else
    cur_state <= nxt_state;	
	
always_comb begin
  nxt_state = 3'h0;
	case(cur_state)
		IDLE	: begin	
		  if(send_en) begin
		  	casex(tx_ctrl)
		  		4'b1xxx : nxt_state = HEAD;
		  		4'b01xx : nxt_state = LEN;
		  		4'b00xx : nxt_state = SEND;
		  		default : nxt_state = SEND;
		  	endcase
		  end
		  else              
			  nxt_state = IDLE;
		end
		HEAD  : begin
		  if(txd_done) begin
		    casex(tx_ctrl)
		  		4'b11xx : nxt_state = LEN;
		  		4'b10xx : nxt_state = SEND;
		  		default : nxt_state = SEND;
		  	endcase
		  end
		  else
		    nxt_state = HEAD;
		end	
		LEN  : begin
		  if(txd_done)
		    nxt_state = SEND;
		  else
		    nxt_state = LEN;
		end	
		SEND	: begin	
		  nxt_state = WAIT;
		end
		WAIT	:	begin
		  if(txd_done) begin
		  	if(send_cnt < NBYTE)
		  		nxt_state = SEND;
		  	else if(send_cnt == NBYTE) begin
		  		casex(tx_ctrl)
		  			4'bxx1x : nxt_state = CRC;
		  			4'bxx01 : nxt_state = TAIL;
		  			4'bxx00 : nxt_state = IDLE;
		  			default : nxt_state = IDLE;
		  		endcase
		  	end
			end
			else
				nxt_state = WAIT;	
		end
		CRC  : begin
		  if(txd_done) begin
		  	casex(tx_ctrl)
		  		4'bxxx1 : nxt_state = TAIL;
		  		4'bxxx0 : nxt_state = IDLE;
		  		default : nxt_state = IDLE;
		  	endcase
		  end
		  else
		    nxt_state = CRC;
		end	
		TAIL  : begin
		  if(txd_done)
		    nxt_state = IDLE;
		  else
		    nxt_state = TAIL;
		end	
		default: begin
		  nxt_state = IDLE;
		end	
	endcase
end	

//tx start
always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		tx_en <= 1'b0;
	else if((cur_state == IDLE) && ((nxt_state == HEAD) || (nxt_state == LEN) || (nxt_state == SEND)))
	  tx_en <= 1'b1;
	else if((cur_state == HEAD) && ((nxt_state == LEN) || (nxt_state == SEND)))
	  tx_en <= 1'b1;
	else if((cur_state == LEN)  && (nxt_state == SEND))
	  tx_en <= 1'b1;
  else if((cur_state == SEND) && (nxt_state == WAIT) && (send_cnt < NBYTE))
		tx_en <= 1'b1;
	else if((cur_state == WAIT) && ((nxt_state == CRC) || (nxt_state == TAIL)))
		tx_en <= 1'b1; 
	else if((cur_state == CRC) && (nxt_state == TAIL))
		tx_en <= 1'b1;   
	else 
		tx_en <= 1'b0; 

always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		send_cnt <= 8'd0;
	else if(cur_state == IDLE)
	  send_cnt <= 8'd0;
  else if((cur_state == SEND) & (nxt_state == WAIT))
		send_cnt <= send_cnt + 1;

always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		send_data_tmp <= 'h0;
	else if(send_en)
		send_data_tmp <= send_data;
  else if((cur_state == SEND) && (nxt_state == WAIT))
		send_data_tmp <= {send_data_tmp[NBYTE*8-9:0],8'd0};
		
always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		tx_data <= 8'd0;
	else if((cur_state == IDLE) && (nxt_state == HEAD))
	  tx_data <= TX_HEAD;
	else if((cur_state == IDLE) && (nxt_state == LEN))
	  tx_data <= NBYTE;
	else if((cur_state == HEAD) && (nxt_state == LEN))
		tx_data <= NBYTE;
  else if((cur_state == SEND) && (nxt_state == WAIT))
		tx_data <= send_data_tmp[NBYTE*8-1:NBYTE*8-8];
	else if((cur_state == WAIT) && (nxt_state == CRC))
	  tx_data <= crc_out;
  else if((cur_state == WAIT) && (nxt_state == TAIL))
	  tx_data <= TX_TAIL;
	else if((cur_state == CRC) && (nxt_state == TAIL))
	  tx_data <= TX_TAIL;

always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		send_done <= 1'b0;
  else if(((cur_state == WAIT) || (cur_state == CRC) || (cur_state == TAIL)) && (nxt_state == IDLE))
		send_done <= 1'b1;
  else 
		send_done <= 1'b0;	

uart_byte_tx #(
	.CLK_FRE  				(CLK_FRE  					),	
	.BAUDRATE 				(BAUDRATE						),	
	.PARITY   				(PARITY  						),
	.ODD_EVEN					(ODD_EVEN						)
	)	uart_byte_tx_inst( 
  .clk							(clk								),				
  .rst_n						(rst_n							),		
  .din_vld					(tx_en							),	
  .din        			(tx_data      			),    
	.txd							(txd								),	
	.txd_done					(txd_done						)   
);

always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		crc_data_in <= 8'd0;
	else if(cur_state == IDLE)
	  crc_data_in <= 8'd0;
	else if((cur_state == SEND) && (nxt_state == WAIT))
		crc_data_in <= send_data_tmp[NBYTE*8-1:NBYTE*8-8];
		
always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		crc_out_dly <= 8'd0;
	else if(cur_state == IDLE)
	  crc_out_dly <= 8'd0;
	else if((cur_state == SEND) && (nxt_state == WAIT))
		crc_out_dly <= crc_out;

crc8_coder u_crc8_coder_inst(
  .din							(crc_data_in				),
  .crc_in						(crc_out_dly				),
	.crc_out  				(crc_out						)
);


endmodule					