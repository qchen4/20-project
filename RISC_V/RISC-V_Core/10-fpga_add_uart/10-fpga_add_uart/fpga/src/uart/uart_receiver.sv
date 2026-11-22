`timescale 1ns / 1ps                                                                                                                   
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	uart_receiver                                                                    
** Last modified Date	:	2025-09-02                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	uart protocal receive                                                            
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

module uart_receiver	#(  
	parameter NBYTE     				= 4          				,
	parameter CLK_FRE 					= 100000000					, 
	parameter BAUDRATE					=	115200						,
	parameter PARITY    				= 1									, 
	parameter	ODD_EVEN					=	1 		      			,
	parameter RX_HEAD   				= 8'h5a         		, 
	parameter RX_TAIL   				= 8'ha5         		  
	)(	
	input  logic           			clk									,
	input  logic         				rst_n		  					,
	input	 logic	[3:0]					rx_ctrl       			,
	input  logic                rxd     						,
	output logic								recv_vld    				,
	output logic	[NBYTE*8-1:0] recv_data						 
);

//---------------------------------------------------------
// state machine 
//---------------------------------------------------------	
localparam 	IDLE      				= 4'd0  						, 
			      CHK_HEAD 					=	4'd1  						, 
			      CHK_LEN   				= 4'd2  						, 
			      RECV_DATE					=	4'd3  						, 
			      RECV_WAIT 				= 4'd4  						,
			      CHK_CRC   				= 4'd5							, 
			      CHK_TAIL 					=	4'd6  						, 
			      END       				= 4'd7  						; 


logic [4:0] 									cur_state						;
logic [4:0] 									nxt_state						;
logic  												chk_head_flag				;
logic  												chk_len_flag				;
logic  												chk_crc_flag				;
logic 												chk_tail_flag				;
                    					                  	
logic         								rx_done       			;
logic [7:0]  									rx_data       			;
logic [7:0]  									recv_cnt      			;
logic [3:0]  									rxd_sync    				;
logic        		 							rxd_fedge  					;
logic [NBYTE*8-1:0] 					recv_data_tmp				;
                    					                  	
logic [7:0]    								crc_data_in					;
logic [7:0]    								crc_out							;
logic [7:0]    								crc_out_dly					;

assign	chk_head_flag = ((cur_state == CHK_HEAD) && (rx_data == RX_HEAD) && rx_done);
assign	chk_len_flag  = ((cur_state == CHK_LEN)  && (rx_data == NBYTE)   && rx_done);
assign	chk_crc_flag  = ((cur_state == CHK_CRC)  && (rx_data == crc_out) && rx_done);
assign	chk_tail_flag = ((cur_state == CHK_TAIL) && (rx_data == RX_TAIL) && rx_done);

always_ff @(posedge clk or negedge rst_n)   
  if(!rst_n)
		rxd_sync <= 'h0;
  else
    rxd_sync  <=  {rxd_sync[2:0],rxd};

always_ff @(posedge clk or negedge rst_n)   
  if(!rst_n)
		rxd_fedge <= 1'h0;
	else if(~rxd_sync[2] && rxd_sync[3])
	  rxd_fedge <= 1'h1;
	else
	  rxd_fedge <= 1'h0;

always_ff @(posedge clk or negedge rst_n)   
  if(!rst_n)
		cur_state <= IDLE;
  else
		cur_state <= nxt_state;

always_comb begin
  nxt_state = 'hx;
  case(cur_state)
		IDLE 		: begin 
			if(rxd_fedge) begin
				casex(rx_ctrl)
		  		4'b1xxx : nxt_state = CHK_HEAD;
		  		4'b01xx : nxt_state = CHK_LEN;
		  		4'b00xx : nxt_state = RECV_DATE;
		  		default : nxt_state = RECV_DATE;
		  	endcase
			end
			else
				nxt_state = IDLE;
			end
		CHK_HEAD	: begin
	  	if(rx_done) begin
		  	if(chk_head_flag) begin
			  	casex(rx_ctrl)
		  			4'b11xx : nxt_state = CHK_LEN;
		  			4'b10xx : nxt_state = RECV_DATE;
		  			default : nxt_state = RECV_DATE;
		  		endcase
			  end
		  	else
			  	nxt_state = IDLE;
	  	end
			else
				nxt_state = CHK_HEAD;
		end
		CHK_LEN	: begin
	  	if(rx_done) begin
		  	if(chk_len_flag)
			  	nxt_state = RECV_DATE;
		  	else
			  	nxt_state = IDLE;
	  	end
			else
				nxt_state = CHK_LEN;
		end
		RECV_DATE 	:
			nxt_state = RECV_WAIT;
		RECV_WAIT 	: begin
			if(rx_done) begin
		  	if(recv_cnt < NBYTE)
			  	nxt_state = RECV_DATE;
		  	else if(recv_cnt == NBYTE) begin
		  		casex(rx_ctrl)
		  			4'bxx1x : nxt_state = CHK_CRC;
		  			4'bxx01 : nxt_state = CHK_TAIL;
		  			4'bxx00 : nxt_state = END;
		  			default : nxt_state = END;
		  		endcase
			  end
			end
			else
				nxt_state = RECV_WAIT;
		end
		CHK_CRC	: begin
			if(rx_done) begin
				if(chk_crc_flag) begin
					casex(rx_ctrl)
		  			4'bxxx1 : nxt_state = CHK_TAIL;
		  			4'bxxx0 : nxt_state = END;
		  			default : nxt_state = END;
		  		endcase
				end
				else
					nxt_state = IDLE;
			end
			else
				nxt_state = CHK_CRC;
		end
		CHK_TAIL	: begin
			if(rx_done) begin
				if(chk_tail_flag)
					nxt_state = END;
				else
					nxt_state = IDLE;
			end
			else
				nxt_state = CHK_TAIL;
		end
		END    	:
			nxt_state = IDLE;
		default	: nxt_state = IDLE;
	endcase
end

//count recv bytes
always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		recv_cnt <= 8'd0;
  else if(cur_state == IDLE)
    recv_cnt <= 8'd0;
  else if((cur_state == RECV_DATE) && (nxt_state == RECV_WAIT))
		recv_cnt <= recv_cnt + 1;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n)
		recv_data_tmp <= 'h0;
	else if((cur_state == RECV_WAIT) && rx_done)
		recv_data_tmp <= {recv_data_tmp[(NBYTE-1)*8-1:0],rx_data};
		
always_ff @(posedge clk or negedge rst_n)
	if(!rst_n)
		recv_vld <= 1'b0;
	else if((cur_state == END) && (nxt_state == IDLE))
		recv_vld <= 1'b1;
	else
		recv_vld <= 1'b0;
			
always_ff @(posedge clk or negedge rst_n)
	if(!rst_n)
		recv_data <= 'h0;
	else if((cur_state == END) && (nxt_state == IDLE))
		recv_data <= recv_data_tmp;

uart_byte_rx	#(
	.CLK_FRE  				(CLK_FRE  					),	
	.BAUDRATE 				(BAUDRATE						),	
	.PARITY   				(PARITY  						),
	.ODD_EVEN					(ODD_EVEN						)
	) uart_byte_rx_inst( 
	.clk							(clk				  			),		
  .rst_n						(rst_n			  			),
  .rxd							(rxd  			  			),
	.dout_vld					(rx_done		  			),
	.dout		    			(rx_data		  			) 	 
);


always_ff @(posedge clk or negedge rst_n)
  if(!rst_n)
		crc_data_in <= 8'd0;
	else if(cur_state == IDLE)
	  crc_data_in <= 8'd0;
	else if((cur_state == RECV_WAIT) & rx_done)
		crc_data_in <= rx_data;		
		
always @(posedge clk or negedge rst_n)
  if(!rst_n)
		crc_out_dly <= 8'd0;
	else if(cur_state == IDLE)
	  crc_out_dly <= 8'd0;
	else if(cur_state == RECV_WAIT & rx_done)
		crc_out_dly <= crc_out;

crc8_coder u_crc8_coder_inst(
  .din							(crc_data_in				),
	.crc_in						(crc_out_dly				),
	.crc_out  				(crc_out						)
);

endmodule