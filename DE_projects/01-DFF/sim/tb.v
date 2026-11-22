module tb ();

  reg clk, rstn;
  reg d;
  wire q0, q1, q2;

  always #5 begin
    clk = ~clk;
  end

  initial begin
    clk = 0;
    rstn = 1;
    d = 1;
    #20;
    #1;
    rstn = 0;
    #30;
    rstn = 1;
    #20;
    d = 0;
    #20;
    d = 1;

    //--- reset again 
    #20;
    rstn = 0;
    #20;
    rstn = 1;
    #20;
    $display("Info: sim end.");
    $finish();
  end

  c_seq u_c_seq (
      .d   (d),
      .rstn(rstn),
      .clk (clk),
      .q0  (q0),
      .q1  (q1),
      .q2  (q2)
  );
endmodule


