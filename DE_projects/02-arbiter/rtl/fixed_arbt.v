module fixed_arbt (
    input wire clk,
    input wire rstn,

    input wire req0,
    input wire req1,
    input wire req2,
    input wire req3,

    output reg gnt0,
    output reg gnt1,
    output reg gnt2,
    output reg gnt3
);
  //----- parameters ------//boot/


  //----- input/output ports----//
  wire arbt_time;
  reg arbt_time_d;  /*do arbitor at every 2
                  cycles, as we use registered gnt*/
  reg [1:0] gnt_id_w;  //0-3： win id

  assign arbt_time = (!arbt_time_d) & (req0 | req1 | req2 | req3);

  always_comb begin
    gnt_id_w = 2'd0;

    if (req0) gnt_id_w = 2'd0;
    else if (req1) gnt_id_w = 2'd1;
    else if (req2) gnt_id_w = 2'd2;
    else if (req3) gnt_id_w = 2'd3;
  end

  always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      gnt0 <= 1'd0;
      gnt1 <= 1'd0;
      gnt2 <= 1'd0;
      gnt3 <= 1'd0;
    end else if (arbt_time) begin
      gnt0 <= 1'd0;
      gnt1 <= 1'd0;
      gnt2 <= 1'd0;
      gnt3 <= 1'd0;

      case (gnt_id_w)
        2'd0: gnt0 <= 1'b1;
        2'd1: gnt1 <= 1'b1;
        2'd2: gnt2 <= 1'b1;
        2'd3: gnt3 <= 1'b1;
        default: ;
      endcase
    end else if (arbt_time_d) begin
      gnt0 <= 1'd0;
      gnt1 <= 1'd0;
      gnt2 <= 1'd0;
      gnt3 <= 1'd0;
    end
  end

  always @(posedge clk or negedge rstn) begin
    if (!rstn) arbt_time_d <= 1'd0;
    else arbt_time_d <= arbt_time;
  end



endmodule
