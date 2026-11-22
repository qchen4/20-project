`timescale 1ns/1ps
`default_nettype none
// Experimental whole-cycle engine with synchronous RAM and shared guarded arithmetic.
// Whole-wave storage and completed-transaction arithmetic remain bit-exact;
// busy-state fault updates occur as the scheduled operations complete.
module bppe_beat_core #(
    parameter integer SIGNAL_F=8,
    parameter integer TIME_F=8,
    parameter integer FEATURE_F=16,
    parameter integer CYCLE_CAPACITY=304,
    parameter integer SIGNAL_W=26+SIGNAL_F,
    parameter integer FEATURE_W=4+FEATURE_F
) (
    input wire clk,rst,clear_history,
    input wire in_valid,
    output wire in_ready,
    input wire signed [SIGNAL_W-1:0] in_filtered,in_dc,
    input wire signed [47:0] in_time,
    input wire in_warmup,
    input wire [29:0] tick_period_ns,
    input wire signed [FEATURE_W-1:0] min_period,max_period,
    input wire signed [47:0] max_period_ticks,
    output logic out_valid,
    input wire out_ready,
    output logic beat_valid,
    output logic signed [47:0] beat_time,
    output logic signed [FEATURE_W-1:0] features[0:4],
    output logic tracking,
    output logic [63:0] rejected_beats,saturation_count,divzero_count,precision_count,
    output wire numeric_fault
);
    localparam [63:0] LIMIT=64'd9007199254740991;
    localparam signed [63:0] SCALE=64'sd1<<FEATURE_F;
    typedef enum logic [4:0] {IDLE,SCAN,PREPARE,INTEGRATE,FEATURES,RESTART,
        CROSS_DONE,PERIOD_DONE,RISE_DONE,NORM_DONE,WIDTH_DONE,AREA_DONE,AMP_DONE,
        DIV_REQUEST,DIV_WAIT,MUL_REQUEST,MUL_WAIT,CROSS_PRODUCT,PERIOD_PRODUCT,
        PERIOD_SCALE,RISE_PRODUCT,NORM_PREP,NORM_PRODUCT,WIDTH_START,WIDTH_PRODUCT,
        AREA_PRODUCT,NEXT_SAMPLE,WIDTH_SCALE,AMP_PRODUCT,CLOSE_WRITE,SCAN_EVAL,RESTART_SAMPLE} phase_t;
    phase_t phase,division_resume,multiply_resume;
    logic signed [63:0] dividend,divisor,division_result,cross_base;
    logic signed [63:0] width_feature,area_feature;
    wire divider_ready,divider_valid,divider_zero,divider_precision;
    wire signed [63:0] divider_result;
    bppe_rounded_divider divider (
        .clk(clk),.rst(rst || clear_history),.in_valid(phase==DIV_REQUEST),.in_ready(divider_ready),
        .in_numerator(dividend),.in_denominator(divisor),.out_valid(divider_valid),
        .out_ready(phase==DIV_WAIT),.out_quotient(divider_result),
        .out_divzero(divider_zero),.out_precision(divider_precision)
    );
    logic signed [63:0] multiply_x,multiply_y,multiply_result,cross_divisor;
    wire multiply_ready,multiply_valid,multiply_precision;
    wire signed [63:0] multiply_value;
    bppe_guarded_multiplier multiplier (
        .clk(clk),.rst(rst || clear_history),.in_valid(phase==MUL_REQUEST),.in_ready(multiply_ready),
        .in_x(multiply_x),.in_y(multiply_y),.out_valid(multiply_valid),.out_ready(phase==MUL_WAIT),
        .out_product(multiply_value),.out_precision(multiply_precision)
    );
    integer cycle_count,complete_count,index;
    logic signed [63:0] previous_y,previous_t;
    logic signed [63:0] sample_y,sample_t,sample_dc,crossing_time,period;
    logic signed [63:0] peak,minimum,peak_time,amplitude,period_s,rise,width_sum,area_sum;
    logic signed [63:0] previous_norm,previous_mask;
    // Transaction configuration is latched so host changes cannot affect an
    // in-flight scan. No external configuration/bus contract is implied.
    logic [29:0] tick_ns;
    logic signed [63:0] period_min,period_max,period_limit;
    logic [63:0] sat_work,div_work,precision_work;
    logic signed [63:0] mask,tc,amp,seconds;
    integer j;
    // One synchronous read and one write port per array. No memory reset or
    // same-cycle double write; valid history/length fences stale contents.
    (* ram_style="block" *) logic signed [63:0] cycle_t[0:CYCLE_CAPACITY];
    (* ram_style="block" *) logic signed [63:0] cycle_y[0:CYCLE_CAPACITY];
    localparam integer ADDRESS_W=$clog2(CYCLE_CAPACITY+1);
    logic memory_write;
    logic [ADDRESS_W-1:0] write_address;
    logic signed [63:0] write_t,write_y,read_t,read_y,start_time,integration_t;
    wire memory_read=!rst && !clear_history && (phase==SCAN || phase==INTEGRATE);
    wire [ADDRESS_W-1:0] read_address=index[ADDRESS_W-1:0];
    logic signed [63:0] segment_dt,segment_masks,segment_norms;
    always @* begin
        memory_write=0;write_address=0;write_t=0;write_y=0;
        if(!rst && !clear_history) begin
            if(phase==IDLE && in_valid && in_ready && !in_warmup && tracking &&
                !(previous_y<=0 && $signed(in_filtered)>0) &&
                $signed(in_time)-start_time<=$signed(max_period_ticks) && cycle_count+1<=CYCLE_CAPACITY) begin
                memory_write=1;write_address=cycle_count[ADDRESS_W-1:0];
                write_t=$signed(in_time);write_y=$signed(in_filtered);
            end else if(phase==CLOSE_WRITE) begin
                memory_write=1;write_address=cycle_count[ADDRESS_W-1:0];write_t=crossing_time;
            end else if(phase==RESTART && sample_t-crossing_time<=period_limit) begin
                memory_write=1;write_address=0;write_t=crossing_time;
            end else if(phase==RESTART_SAMPLE) begin
                memory_write=1;write_address=1;write_t=sample_t;write_y=sample_y;
            end
        end
    end
    always @(posedge clk) begin
        if(memory_write) begin cycle_t[write_address]<=write_t;cycle_y[write_address]<=write_y;end
        if(memory_read) begin read_t<=cycle_t[read_address];read_y<=cycle_y[read_address];end
    end

    function automatic [63:0] mag(input logic signed [63:0] x);
        mag=x[63]?(~$unsigned(x)+64'd1):$unsigned(x);
    endfunction
    function automatic signed [63:0] addq(input logic signed [63:0] x,y,inout logic [63:0] faults);
        begin
            if ({1'b0,mag(x)}+{1'b0,mag(y)}>{1'b0,LIMIT}) begin faults=faults+1'b1; addq=0; end
            else addq=x+y;
        end
    endfunction
    function automatic signed [63:0] clipq(input logic signed [63:0] x,input integer width,
        inout logic [63:0] faults);
        logic signed [63:0] lo,hi;
        begin
            lo=-(64'sd1<<(width-1)); hi=(64'sd1<<(width-1))-1;
            if (x<lo) begin faults=faults+1'b1; clipq=lo; end
            else if (x>hi) begin faults=faults+1'b1; clipq=hi; end
            else clipq=x;
        end
    endfunction

    assign in_ready=!rst && !clear_history && phase==IDLE && (!out_valid || out_ready);
    assign numeric_fault=(saturation_count!=0 || divzero_count!=0 || precision_count!=0);
    always @(posedge clk) begin
        if (rst || clear_history) begin
            phase<=IDLE; division_resume<=IDLE; dividend<=0; divisor<=0; division_result<=0;
            cross_base<=0; width_feature<=0; area_feature<=0;
            multiply_resume<=IDLE;multiply_x<=0;multiply_y<=0;multiply_result<=0;cross_divisor<=0;
            start_time<=0;integration_t<=0;segment_dt<=0;segment_masks<=0;segment_norms<=0;
            out_valid<=0; beat_valid<=0; beat_time<=0;
            tracking<=0; previous_y<=0; previous_t<=0; cycle_count<=0; rejected_beats<=0;
            for (j=0;j<5;j=j+1) features[j]<=0;
            if (rst) begin saturation_count<=0; divzero_count<=0; precision_count<=0; end
        end else begin
            sat_work=saturation_count; div_work=divzero_count; precision_work=precision_count;
            if (out_valid && out_ready) out_valid<=0;
            case (phase)
                IDLE: if (in_valid && in_ready) begin
                    beat_valid<=0; beat_time<=0;
                    for (j=0;j<5;j=j+1) features[j]<=0;
                    sample_y<=$signed(in_filtered); sample_t<=$signed(in_time); sample_dc<=$signed(in_dc);
                    tick_ns<=tick_period_ns; period_min<=$signed(min_period); period_max<=$signed(max_period);
                    period_limit<=$signed(max_period_ticks);
                    previous_y<=$signed(in_filtered); previous_t<=$signed(in_time);
                    if (in_warmup) out_valid<=1;
                    else if (previous_y<=0 && $signed(in_filtered)>0) begin
                        multiply_x<=-previous_y;multiply_y<=$signed(in_time)-previous_t;
                        cross_base<=previous_t;cross_divisor<=$signed(in_filtered)-previous_y;
                        multiply_resume<=CROSS_PRODUCT;phase<=MUL_REQUEST;
                    end else if (tracking) begin
                        if ($signed(in_time)-start_time>$signed(max_period_ticks) || cycle_count+1>CYCLE_CAPACITY) begin
                            tracking<=0; cycle_count<=0; rejected_beats<=rejected_beats+1'b1;
                        end else begin
                            cycle_count<=cycle_count+1;
                        end
                        out_valid<=1;
                    end else out_valid<=1;
                end
                MUL_REQUEST:if(multiply_ready)phase<=MUL_WAIT;
                MUL_WAIT:if(multiply_valid)begin
                    multiply_result<=multiply_value;
                    precision_work=precision_work+{63'd0,multiply_precision};phase<=multiply_resume;
                end
                CROSS_PRODUCT:begin
                    dividend<=multiply_result;divisor<=cross_divisor;division_resume<=CROSS_DONE;phase<=DIV_REQUEST;
                end
                DIV_REQUEST: if (divider_ready) phase<=DIV_WAIT;
                DIV_WAIT: if (divider_valid) begin
                    division_result<=divider_result;
                    div_work=div_work+{63'd0,divider_zero};
                    precision_work=precision_work+{63'd0,divider_precision};
                    phase<=division_resume;
                end
                CROSS_DONE: begin
                    tc=clipq(cross_base+division_result,48,sat_work); crossing_time<=tc;
                    if(tracking)phase<=CLOSE_WRITE;else phase<=RESTART;
                end
                CLOSE_WRITE:begin
                    complete_count<=cycle_count+1;period<=crossing_time-start_time;
                    index<=0;peak<=0;minimum<=0;peak_time<=start_time;phase<=SCAN;
                end
                SCAN:phase<=SCAN_EVAL;
                SCAN_EVAL:begin
                    if(read_y>peak)begin peak<=read_y;peak_time<=read_t;end
                    if(read_y<minimum)minimum<=read_y;
                    if(index+1==complete_count)phase<=PREPARE;
                    else begin index<=index+1;phase<=SCAN;end
                end
                PREPARE: begin
                    amp=clipq(peak-minimum,SIGNAL_W,sat_work); amplitude<=amp;
                    multiply_x<=period;multiply_y<=$signed({1'b0,tick_ns});
                    multiply_resume<=PERIOD_PRODUCT;phase<=MUL_REQUEST;
                end
                PERIOD_PRODUCT:begin
                    multiply_x<=multiply_result;multiply_y<=64'sd1<<(FEATURE_F-TIME_F);
                    multiply_resume<=PERIOD_SCALE;phase<=MUL_REQUEST;
                end
                PERIOD_SCALE:begin
                    dividend<=multiply_result;divisor<=64'sd1000000000;
                    division_resume<=PERIOD_DONE;phase<=DIV_REQUEST;
                end
                PERIOD_DONE: begin
                    seconds=clipq(division_result,FEATURE_W,sat_work); period_s<=seconds;
                    if (period>0 && seconds>=period_min && seconds<=period_max && peak>0 && sample_dc>0) begin
                        multiply_x<=peak_time-start_time;multiply_y<=SCALE;
                        multiply_resume<=RISE_PRODUCT;phase<=MUL_REQUEST;
                    end else begin rejected_beats<=rejected_beats+1'b1; phase<=RESTART; end
                end
                RISE_PRODUCT:begin
                    dividend<=multiply_result;divisor<=period;division_resume<=RISE_DONE;phase<=DIV_REQUEST;
                end
                RISE_DONE: begin
                    rise<=division_result;
                    width_sum<=0; area_sum<=0; index<=0; previous_norm<=0; previous_mask<=0; phase<=INTEGRATE;
                end
                INTEGRATE:phase<=NORM_PREP;
                NORM_PREP:begin
                    multiply_x<=read_y>0?read_y:64'sd0;multiply_y<=SCALE;
                    multiply_resume<=NORM_PRODUCT;phase<=MUL_REQUEST;
                end
                NORM_PRODUCT:begin
                    dividend<=multiply_result;divisor<=peak;division_resume<=NORM_DONE;phase<=DIV_REQUEST;
                end
                NORM_DONE:begin
                    mask=(2*read_y>=peak)?64'sd1:64'sd0;
                    segment_dt<=read_t-integration_t;segment_masks<=previous_mask+mask;
                    segment_norms<=previous_norm+division_result;
                    previous_norm<=division_result;previous_mask<=mask;integration_t<=read_t;
                    if(index>0)phase<=WIDTH_START;else phase<=NEXT_SAMPLE;
                end
                WIDTH_START:begin
                    multiply_x<=segment_dt;multiply_y<=segment_masks;multiply_resume<=WIDTH_PRODUCT;phase<=MUL_REQUEST;
                end
                WIDTH_PRODUCT:begin
                    width_sum<=addq(width_sum,multiply_result,precision_work);
                    multiply_x<=segment_dt;multiply_y<=segment_norms;multiply_resume<=AREA_PRODUCT;phase<=MUL_REQUEST;
                end
                AREA_PRODUCT:begin
                    area_sum<=addq(area_sum,multiply_result,precision_work);phase<=NEXT_SAMPLE;
                end
                NEXT_SAMPLE:begin
                    if(index+1==complete_count)phase<=FEATURES;
                    else begin index<=index+1;phase<=INTEGRATE;end
                end
                FEATURES:begin
                    multiply_x<=width_sum;multiply_y<=SCALE;multiply_resume<=WIDTH_SCALE;phase<=MUL_REQUEST;
                end
                WIDTH_SCALE:begin
                    dividend<=multiply_result;divisor<=2*period;division_resume<=WIDTH_DONE;phase<=DIV_REQUEST;
                end
                WIDTH_DONE: begin
                    width_feature<=division_result; dividend<=area_sum; divisor<=2*period;
                    division_resume<=AREA_DONE; phase<=DIV_REQUEST;
                end
                AREA_DONE: begin
                    area_feature<=division_result;
                    multiply_x<=amplitude;multiply_y<=SCALE;multiply_resume<=AMP_PRODUCT;phase<=MUL_REQUEST;
                end
                AMP_PRODUCT:begin
                    dividend<=multiply_result;divisor<=sample_dc;division_resume<=AMP_DONE;phase<=DIV_REQUEST;
                end
                AMP_DONE: begin
                    features[0]<=clipq(period_s,FEATURE_W,sat_work);
                    features[1]<=clipq(rise,FEATURE_W,sat_work);
                    features[2]<=clipq(width_feature,FEATURE_W,sat_work);
                    features[3]<=clipq(area_feature,FEATURE_W,sat_work);
                    features[4]<=clipq(division_result,FEATURE_W,sat_work);
                    beat_valid<=1; beat_time<=crossing_time[47:0]; phase<=RESTART;
                end
                RESTART: begin
                    if (sample_t-crossing_time>period_limit) begin
                        tracking<=0;cycle_count<=0;rejected_beats<=rejected_beats+1'b1;
                        out_valid<=1;phase<=IDLE;
                    end else begin start_time<=crossing_time;phase<=RESTART_SAMPLE;end
                end
                RESTART_SAMPLE:begin
                    tracking<=1;cycle_count<=2;out_valid<=1;phase<=IDLE;
                end
                default: phase<=IDLE;
            endcase
            saturation_count<=sat_work; divzero_count<=div_work; precision_count<=precision_work;
        end
    end
`ifndef SYNTHESIS
    always @(posedge clk)if(!rst && !clear_history)begin
        if(memory_read && (index<0 || index>=complete_count || index>CYCLE_CAPACITY))$fatal(1,"Beat RAM read outside valid history");
        if(memory_write && write_address>CYCLE_CAPACITY)$fatal(1,"Beat RAM write overflow");
        if(memory_read && memory_write)$fatal(1,"Beat RAM read/write phases overlap");
    end
    initial begin
        if (!((SIGNAL_F==0 && TIME_F==0 && FEATURE_F==8) || (SIGNAL_F==8 && TIME_F==8 && FEATURE_F==16) ||
              (SIGNAL_F==10 && TIME_F==10 && FEATURE_F==18)) || CYCLE_CAPACITY<2 || SIGNAL_W!=26+SIGNAL_F || FEATURE_W!=4+FEATURE_F)
            $fatal(1,"Unsupported experimental beat profile/capacity");
    end
    always @(posedge clk) if (!rst && clear_history && (phase!=IDLE || out_valid))
        $fatal(1,"History clear requires an idle, empty beat engine");
`endif
endmodule
`default_nettype wire
