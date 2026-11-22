// detect a sequence of bits "1011"

/*state|din|next_state
idle: 	0->idle
		1->S_1
S1: 	0-> S_10
		1-> S_1
S10: 	0->idle
		1->S_101
S_101:  0-> S_10
		1->S_1 && match
*/


module seq_detect_fsm(
	en, 
	din, 
	
	match,
	clk, 
	rstn
);

input wire en;
input wire din;

output reg match; 
input wire clk; 
input wire rstn;

reg [1:0] sta, nsta; 

parameter [1:0] S_idle = 'd0， S_1 = 'd1，
				S_10 = 'd2， S_101 = 'd3;
				
always @(posedge clk or negedge rstn)
if (!rstn) 
	sta <= S_idle; 
else 
	sta <= nsta; 

always @(*) begin 
nsta = sta; 

if (en) begin 
	case (sta) 
	S_idle	: nsta = din? S_1: S_idle; 
	S_1		: nsta = din? S_1: S_10	;
	S_10	: nsta = din? S_101: S_idle; 
	S_101	: nsta = din? S_1: S_10; 
	default	: nsta = S_idle; 
	endcase
end
end


always @(posedge clk or negedge rstn) 
if (!rstn) 
	match <= 1'b0; 
else 
	match <= en && (sta == S_101) && din; 
	
endmodule 