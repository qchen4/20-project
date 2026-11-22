`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 11:03:10
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top();

logic 	       		sys_clk_p     					;  
logic 	       		sys_clk_n     					;  
logic 	       		sys_rst_n     					;
logic							key_in									;
logic [3:0]	      led                     ;

assign sys_clk_n	= ~sys_clk_p						;

top u_top_inst(
  .sys_clk_p     	(sys_clk_p  						),  
  .sys_clk_n     	(sys_clk_n  						),  
  .sys_rst_n     	(sys_rst_n  						),
 	.key_in					(key_in									),
  .led            (led        						)
);    

always #2.5 sys_clk_p = ~sys_clk_p;	
initial begin
	sys_clk_p    					= 1'b0;
	sys_clk_n    					= 1'b1; 
	sys_rst_n      				= 1'b0;
	key_in								= 1'b1;
	#1000;          	
	sys_rst_n   					= 1'b1;
end

endmodule
