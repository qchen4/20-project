`timescale 1ns / 1ps                                                                                     
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	tb_riscv_top                                                                 
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	tb_riscv_top                                                                 
**------------------------------------------------------------------------------------------------------ 
** Created by					: FPGACoreCG                                                                       
** Created date				: 2025-11-01                                                                        
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

`include "./../src/define.sv"

module tb_riscv_top;

//localparam	FILE      	=  "../test_data/rv32ui-p-addi.dat"				;
//localparam	FILE      	=  "../test_data/rv32ui-p-beq.dat"  			;   
//localparam	FILE      	=  "../test_data/rv32ui-p-bge.dat"  			;   
//localparam	FILE      	=  "../test_data/rv32ui-p-bgeu.dat"  			;      
//localparam	FILE      	=  "../test_data/rv32ui-p-blt.dat"  			;    
//localparam	FILE      	=  "../test_data/rv32ui-p-bltu.dat"  			;  
//localparam	FILE      	=  "../test_data/rv32ui-p-bne.dat"  			;  
//localparam	FILE      	=  "../test_data/rv32ui-p-jal.dat"  			; 
//localparam	FILE      	=  "../test_data/rv32ui-p-jalr.dat"  			; 
//localparam	FILE      	=  "../test_data/rv32ui-p-lui.dat"  			; 
localparam	FILE      	=  "../test_data/rv32ui-p-auipc.dat"  		;    

logic       				clk												;
logic       				rst_n											;
logic	[31:0]				tmp												;
logic [31:0]			 	test_case  								;
logic [31:0]				reg_s10  									;
logic [31:0]				reg_s11  									;

//string 				 			case_num[int]							;//关联数组
 
riscv #(
	.FILE							(FILE											),
	.AW								(`AW											),	
	.DW								(`DW											)
	) u_riscv_inst(                                			
	.clk							(clk											),
  .rst_n						(rst_n										),
  .test_case				(test_case								),
	.reg_s10					(reg_s10									),
	.reg_s11	 				(reg_s11									)
);     
	
	
always #5 clk = ~clk;	
initial begin
	clk     					= 1'b0;
	rst_n   					= 1'b0;
	tmp								=	32'h0; 
	#1000;          	
	rst_n   					= 1'b1;
end

//initial begin
//		case_num[0] 		= "rv32ui-p-addi.dat"	 			;	
//		case_num[1] 		= "rv32ui-p-beq.dat"   			;
//		case_num[2] 		= "rv32ui-p-bge.dat"  			;
//		case_num[3] 		= "rv32ui-p-bgeu.dat"  			;
//		case_num[4]			= "rv32ui-p-blt.dat"   			;
//		case_num[5]			= "rv32ui-p-bltu.dat"  			;
//		case_num[6]			= "rv32ui-p-bne.dat"    		;
//		case_num[7] 		= "rv32ui-p-jal.dat"   			;
//		case_num[8] 		= "rv32ui-p-jalr.dat"  			;
//		case_num[9] 		= "rv32ui-p-lui.dat" 				;
//		case_num[10] 		= "rv32ui-p-auipc.dat" 			;
//end 

initial  begin
	forever begin
		tmp = test_case;
		@(posedge clk);
		if(tmp != test_case)
			$display("test[%d]",test_case);
		if(reg_s10 == 32'h1) begin
			repeat(10) @(posedge clk);
			if(reg_s11 == 32'h1) begin
				repeat(3) $display("**************************************************");
				$display("\n");
				$display("%s",FILE," test passed !!!!! ");
				$display("\n");
				repeat(3) $display("**************************************************");
//				for(int i=0;i<32;i++) begin
//					$display("%d register value is %d",i,tb_riscv_top.u_riscv_inst.u_register_inst.regs[i]);
//				end
				$finish;
			end
			else begin
				repeat(3) $display("**************************************************");
				$display("\n");
				$display("%s",FILE,"  test failed !!!!! ");
				$display("\n");
				repeat(3) $display("**************************************************");
				$display("Tht failed test case is test[%d]",test_case);
				for(int i=0;i<32;i++) begin
					$display("%d register value is %d",i,tb_riscv_top.u_riscv_inst.u_register_inst.regs[i]);
				end
				$finish;
			end
		end
	end
end
     
endmodule

