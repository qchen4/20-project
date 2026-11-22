`timescale 1ns/1ps
`default_nettype none
// Accepted channel-result events only. Snapshot evaluation and window clear
// are caller-coordinated; no timeout, automatic publish, CSR or ACK here.
module bppe_window_store #(
    parameter integer FEATURE_F=16,FEATURE_W=4+FEATURE_F
) (
    input wire clk,rst,clear_history,clear_window,
    input wire in_valid,
    output wire in_ready,
    input wire [1:0] in_channel,
    input wire [6:0] beats_required,
    input wire in_beat_valid,
    input wire signed [FEATURE_W-1:0] in_features[0:4],
    input wire [63:0] in_rejected_total,
    output logic [6:0] out_counts[0:2],
    output logic signed [FEATURE_W-1:0] out_beats[0:2][0:63][0:4],
    output wire [63:0] out_rejected[0:2]
);
    logic [63:0] rejected_base[0:2],rejected_latest[0:2];
    logic [6:0] window_limit;
    logic have_limit;
    integer i,j,k;
    assign in_ready=!rst && !clear_history && !clear_window;
    for(genvar ch=0;ch<3;ch=ch+1) begin: rejection_delta
        assign out_rejected[ch]=rejected_latest[ch]-rejected_base[ch];
    end
    always @(posedge clk) begin
        if(rst || clear_history) begin
            have_limit<=0;window_limit<=0;
            for(i=0;i<3;i=i+1) begin out_counts[i]<=0;rejected_base[i]<=0;rejected_latest[i]<=0;end
        end else if(clear_window) begin
            for(i=0;i<3;i=i+1) begin out_counts[i]<=0;rejected_base[i]<=rejected_latest[i];end
        end else if(in_valid && in_ready) begin
            have_limit<=1;window_limit<=beats_required;rejected_latest[in_channel]<=in_rejected_total;
            if(in_beat_valid) begin
                if(out_counts[in_channel]<beats_required) begin
                    for(k=0;k<5;k=k+1) out_beats[in_channel][out_counts[in_channel]][k]<=in_features[k];
                    out_counts[in_channel]<=out_counts[in_channel]+1'b1;
                end else begin
                    for(j=0;j<63;j=j+1) if(j+1<beats_required)
                        for(k=0;k<5;k=k+1) out_beats[in_channel][j][k]<=out_beats[in_channel][j+1][k];
                    for(k=0;k<5;k=k+1) out_beats[in_channel][beats_required-1'b1][k]<=in_features[k];
                end
            end
        end
    end
`ifndef SYNTHESIS
    initial if(!((FEATURE_F==8 || FEATURE_F==16 || FEATURE_F==18) && FEATURE_W==4+FEATURE_F))
        $fatal(1,"Unsupported window format");
    always @(posedge clk) if(!rst) begin
        if(clear_history && clear_window) $fatal(1,"Serialize history and window clear");
        if(in_valid && in_ready) begin
            if(in_channel>2 || beats_required<1 || beats_required>64 || (have_limit && beats_required!=window_limit))
                $fatal(1,"Invalid/changing bounded window configuration");
            if(in_rejected_total<rejected_latest[in_channel]) $fatal(1,"Rejection counter reset requires matching history clear");
        end
    end
`endif
endmodule
`default_nettype wire
