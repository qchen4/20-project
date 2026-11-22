module c_seq (
    d,
    rstn,
    clk,
    q0,
    q1,
    q2
);

  input wire d, rstn, clk;
  output reg q0, q1, q2;


  always @(posedge clk) q0 <= #1 d;  //non blocking assignment
  always @(posedge clk) begin
    if (!rstn) q1 <= #1 1'b0;
    else q1 <= #1 d;
  end

  always @(posedge clk or negedge rstn) begin
    if (!rstn) q2 <= #1 1'b0;
    else q2 <= #1 d;
  end

endmodule

