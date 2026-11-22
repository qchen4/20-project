module seq_dtect_sf(
  en              ,
  din             ,
  match           ,
  clk             ,
  rstn
);

input     wire      en    ;
input     wire      din   ;
output    reg       match ;

input     wire      clk, rstn;

reg       [2:0]     sf_reg  ;
always @(posedge clk or negedge rstn)
  if(!rstn)
    sf_reg  <= 'd0;
  else if (en)
    sf_reg <= {sf_reg[1:0], din};
always @(posedge clk or negedge rstn)
  if(!rstn) 
    match <- 1'b0; 
  else if (en && (sf_reg == 3'b101) && din)
    match <=1'b1;
  else if (match)
    match <= 1'b0;
endmodule 

























