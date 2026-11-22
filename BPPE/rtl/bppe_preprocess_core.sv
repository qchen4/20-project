`timescale 1ns/1ps
`default_nettype none
module bppe_preprocess_core #(
    parameter integer SIGNAL_F=8,COEFFICIENT_F=18,TIME_F=8,SIGNAL_W=26+SIGNAL_F
) (
    input wire clk,rst,clear_history,in_valid,
    output wire in_ready,
    input wire [23:0] in_adc,
    input wire signed [63:0] in_ticks,
    input wire [COEFFICIENT_F-1:0] dc_coefficient,lowpass_coefficient,
    output logic out_valid,
    input wire out_ready,
    output wire initialized,
    output wire signed [SIGNAL_W-1:0] out_dc,out_filtered,
    output logic signed [47:0] out_time,
    output logic [63:0] saturation_count,precision_count,
    output wire numeric_fault
);
    localparam integer PRODUCT_W=SIGNAL_W+COEFFICIENT_F;
    localparam logic [63:0] SAFE_TICKS=64'd9007199254740991>>TIME_F;
    localparam logic signed [63:0] TIME_LO=-(64'sd1<<47),TIME_HI=(64'sd1<<47)-1;
    localparam logic signed [PRODUCT_W-1:0] HALF=({{(PRODUCT_W-1){1'b0}},1'b1}<<(COEFFICIENT_F-1));
    typedef enum logic [3:0] {IDLE,DC_DELTA,MULTIPLY,ROUND_ADD,UPDATE,AC,LP_DELTA,COMMIT} phase_t;
    phase_t phase;
    logic have_sample,is_dc;
    logic signed [SIGNAL_W-1:0] dc_state,filtered_state,raw_adc,base_dc,delta,ac,next_dc,next_filtered;
    logic [COEFFICIENT_F-1:0] dc_coef,lp_coef,coefficient;
    logic signed [PRODUCT_W-1:0] product,biased_product;
    logic signed [47:0] sample_time;
    logic [3:0] pending_saturations;
    logic pending_precision;
    wire signed [SIGNAL_W-1:0] increment=$signed(biased_product)>>>COEFFICIENT_F;
    wire signed [SIGNAL_W-1:0] update_base=is_dc?base_dc:filtered_state;
    wire signed [SIGNAL_W:0] dc_difference=$signed({raw_adc[SIGNAL_W-1],raw_adc})-$signed({base_dc[SIGNAL_W-1],base_dc});
    wire signed [SIGNAL_W:0] ac_difference=$signed({raw_adc[SIGNAL_W-1],raw_adc})-$signed({next_dc[SIGNAL_W-1],next_dc});
    wire signed [SIGNAL_W:0] lp_difference=$signed({ac[SIGNAL_W-1],ac})-$signed({filtered_state[SIGNAL_W-1],filtered_state});
    wire signed [SIGNAL_W:0] updated=$signed({update_base[SIGNAL_W-1],update_base})+$signed({increment[SIGNAL_W-1],increment});
    wire signed [PRODUCT_W-1:0] multiplied=$signed(delta)*$signed({1'b0,coefficient});
    wire signed [SIGNAL_W-1:0] accepted_adc=$signed({2'b00,in_adc,{SIGNAL_F{1'b0}}});
    wire time_precision=magnitude(in_ticks)>SAFE_TICKS;
    wire signed [63:0] raw_time=time_precision?64'sd0:(in_ticks<<<TIME_F);

    function automatic [63:0] magnitude(input logic signed [63:0] value);
        magnitude=value[63]?(~$unsigned(value)+64'd1):$unsigned(value);
    endfunction
    function automatic signed [SIGNAL_W-1:0] clip_signal(input logic signed [SIGNAL_W:0] value);
        if(value[SIGNAL_W]!=value[SIGNAL_W-1])
            clip_signal=value[SIGNAL_W]?{1'b1,{(SIGNAL_W-1){1'b0}}}:{1'b0,{(SIGNAL_W-1){1'b1}}};
        else clip_signal=value[SIGNAL_W-1:0];
    endfunction
    function automatic overflowed(input logic signed [SIGNAL_W:0] value);
        overflowed=value[SIGNAL_W]!=value[SIGNAL_W-1];
    endfunction
    function automatic signed [47:0] clip_time(input logic signed [63:0] value);
        if(value<TIME_LO)clip_time=TIME_LO[47:0];else if(value>TIME_HI)clip_time=TIME_HI[47:0];else clip_time=value[47:0];
    endfunction

    assign initialized=have_sample;
    assign out_dc=dc_state;
    assign out_filtered=filtered_state;
    assign numeric_fault=(saturation_count!=0 || precision_count!=0);
    assign in_ready=!rst && !clear_history && phase==IDLE && (!out_valid || out_ready);

    always @(posedge clk) begin
        if(rst)begin
            phase<=IDLE;have_sample<=0;dc_state<=0;filtered_state<=0;out_time<=0;out_valid<=0;
            saturation_count<=0;precision_count<=0;
        end else if(clear_history)begin
            phase<=IDLE;have_sample<=0;dc_state<=0;filtered_state<=0;out_time<=0;out_valid<=0;
        end else begin
            if(out_valid && out_ready)out_valid<=0;
            case(phase)
                IDLE:if(in_valid && in_ready)begin
                    raw_adc<=accepted_adc;base_dc<=have_sample?dc_state:accepted_adc;
                    dc_coef<=dc_coefficient;lp_coef<=lowpass_coefficient;
                    sample_time<=clip_time(raw_time);pending_precision<=time_precision;
                    pending_saturations<=(raw_time<TIME_LO || raw_time>TIME_HI)?4'd1:4'd0;
                    is_dc<=1;phase<=DC_DELTA;
                end
                DC_DELTA:begin
                    delta<=clip_signal(dc_difference);coefficient<=dc_coef;
                    pending_saturations<=pending_saturations+overflowed(dc_difference);phase<=MULTIPLY;
                end
                MULTIPLY:begin product<=multiplied;phase<=ROUND_ADD;end
                ROUND_ADD:begin
                    // floor((p+half)/2^F) for p>=0; p+half-1 for p<0.
                    // Exactly nearest with ties away, without two magnitude/negation chains.
                    biased_product<=product+(product[PRODUCT_W-1]?(HALF-1'b1):HALF);phase<=UPDATE;
                end
                UPDATE:begin
                    pending_saturations<=pending_saturations+overflowed(updated);
                    if(is_dc)begin next_dc<=clip_signal(updated);phase<=AC;end
                    else begin next_filtered<=clip_signal(updated);phase<=COMMIT;end
                end
                AC:begin
                    ac<=clip_signal(ac_difference);pending_saturations<=pending_saturations+overflowed(ac_difference);phase<=LP_DELTA;
                end
                LP_DELTA:begin
                    delta<=clip_signal(lp_difference);coefficient<=lp_coef;is_dc<=0;
                    pending_saturations<=pending_saturations+overflowed(lp_difference);phase<=MULTIPLY;
                end
                COMMIT:begin
                    dc_state<=next_dc;filtered_state<=next_filtered;have_sample<=1;out_time<=sample_time;out_valid<=1;
                    saturation_count<=saturation_count+pending_saturations;precision_count<=precision_count+pending_precision;phase<=IDLE;
                end
                default:phase<=IDLE;
            endcase
        end
    end
`ifndef SYNTHESIS
    initial if(!((SIGNAL_F==0 && COEFFICIENT_F==8 && TIME_F==0) ||
        (SIGNAL_F==8 && COEFFICIENT_F==18 && TIME_F==8) || (SIGNAL_F==10 && COEFFICIENT_F==18 && TIME_F==10)) || SIGNAL_W!=26+SIGNAL_F)
        $fatal(1,"Unsupported experimental numeric profile");
    always @(posedge clk)if(!rst && clear_history && (phase!=IDLE || out_valid))
        $fatal(1,"History clear requires an idle, empty preprocessor");
`endif
endmodule
`default_nettype wire
