`timescale 1ns/1ps
`default_nettype none
module tb_bppe_prototype;
`include "prototype_tb_ports.svh"
    string filename;
    integer fd,got,i,j,latency,frames=0,cases=0,candidates=0,acks=0,overflow_frames=0,max_latency=0;
    logic [63:0] kind,config_words[0:72],words[0:46];
    logic active_case=0;
    task automatic compare;
        begin
            if(!sample_done || sample_tag!==words[2][31:0] || sample_saturations!==words[9] || sample_divzero!==words[10] ||
                sample_precision!==words[11] || candidate_valid!==words[12][0] || pending!==words[28][0] ||
                result_counter!==words[45][15:0] || fault_flags!==words[46][15:0])
                $fatal(1,"Prototype control mismatch profile=%0d case=%0d frame=%0d tag=%0d done=%0b candidate=%0b expected_candidate=%0b pending=%0b expected_pending=%0b counter=%0d expected_counter=%0d counts=%0d flags=%0d expected_flags=%0d",PROFILE,words[1],words[2],sample_tag,sample_done,candidate_valid,words[12],pending,words[28],result_counter,words[45],dut.counts[0],fault_flags,words[46]);
            if(dut.request_timeout!==words[8][0] || dut.channel_warmup!==words[7][0]) $fatal(1,"Integer tick timing metadata mismatch");
            if(candidate_valid) begin
                if(candidate_seq!==words[13][15:0] || candidate_tag!==words[2][31:0] || candidate_timestamp!==words[14][31:0] ||
                    candidate_has_features!==words[15][0] || candidate_result_valid!==words[16][0] || candidate_reasons!==words[17][15:0] ||
                    candidate_sqi!==words[18][7:0] || $signed(candidate_pressure_raw[0])!=$signed(words[24]) ||
                    $signed(candidate_pressure_raw[1])!=$signed(words[25]) || candidate_codes[0]!==words[26][15:0] || candidate_codes[1]!==words[27][15:0])
                    $fatal(1,"Prototype candidate mismatch case=%0d frame=%0d",words[1],words[2]);
                for(integer x=0;x<5;x=x+1) if($signed(candidate_features[x])!=$signed(words[19+x])) $fatal(1,"Prototype feature mismatch case=%0d frame=%0d index=%0d",words[1],words[2],x);
            end
            if(snapshot_seq!==words[29][15:0] || snapshot_tag!==words[30][31:0] || snapshot_timestamp!==words[31][31:0] ||
                snapshot_has_features!==words[32][0] || snapshot_result_valid!==words[33][0] || snapshot_reasons!==words[34][15:0] ||
                snapshot_sqi!==words[35][7:0] || $signed(snapshot_pressure_raw[0])!=$signed(words[41]) || $signed(snapshot_pressure_raw[1])!=$signed(words[42]) ||
                snapshot_codes[0]!==words[43][15:0] || snapshot_codes[1]!==words[44][15:0])
                $fatal(1,"Prototype pending snapshot changed/mismatched case=%0d frame=%0d",words[1],words[2]);
            for(integer x=0;x<5;x=x+1) if($signed(snapshot_features[x])!=$signed(words[36+x])) $fatal(1,"Prototype snapshot feature mismatch");
        end
    endtask
    initial begin
        if(!$value$plusargs("VECTORS=%s",filename)) $fatal(1,"Missing prototype vectors");
        fd=$fopen(filename,"r");if(fd==0) $fatal(1,"Cannot open prototype vectors");
        while(!$feof(fd)) begin
            got=$fscanf(fd,"%h",kind);
            if(got==1 && kind==0) begin
                config_words[0]=kind;
                for(i=1;i<73;i=i+1) begin got=$fscanf(fd,"%h",config_words[i]);if(got!=1) $fatal(1,"Truncated prototype config");end
                active_case=(config_words[2]==SF && config_words[3]==CF && config_words[4]==TF && config_words[5]==FF);
                if(active_case) begin
                    @(negedge clk);rst=1;in_valid=0;ack=0;
                    dc_coefficient=config_words[6][CF-1:0];lowpass_coefficient=config_words[7][CF-1:0];tick_period_ns=config_words[8][29:0];
                    min_period=config_words[9][FW-1:0];max_period=config_words[10][FW-1:0];max_period_ticks=config_words[11][47:0];
                    in_beats_required=config_words[12][6:0];in_min_amplitude=config_words[13][FW-1:0];in_max_amplitude=config_words[14][FW-1:0];
                    in_max_cv=config_words[15][FW-1:0];in_sqi_threshold=config_words[16][7:0];in_configured=config_words[17][0];
                    in_calibrated=config_words[18][0];in_demo_only=config_words[19][0];in_allow_demo=config_words[20][0];
                    for(i=0;i<5;i=i+1) begin
                        in_center[i]=config_words[21+i][FW-1:0];in_scale[i]=config_words[26+i][FW-1:0];in_min_enabled[i]=config_words[43+i][0];
                        in_feature_min[i]=config_words[48+i][FW-1:0];in_max_enabled[i]=config_words[53+i][0];in_feature_max[i]=config_words[58+i][FW-1:0];
                    end
                    for(i=0;i<6;i=i+1) for(j=0;j<2;j=j+1) in_beta[i][j]=config_words[31+2*i+j][BW-1:0];
                    for(i=0;i<2;i=i+1) begin in_bp_min[i]=config_words[63+i][AW-1:0];in_bp_max[i]=config_words[65+i][AW-1:0];end
                    initial_saturations=config_words[67];initial_divzero=config_words[68];initial_precision=config_words[69];
                    warmup_ticks=$signed(config_words[70]);timeout_ticks=$signed(config_words[71]);initial_deadline_ticks=$signed(config_words[72]);
                    repeat(2) @(negedge clk);rst=0;cases=cases+1;
                end
            end else if(got==1 && kind==1) begin
                words[0]=kind;for(i=1;i<47;i=i+1) begin got=$fscanf(fd,"%h",words[i]);if(got!=1) $fatal(1,"Truncated prototype sample");end
                if(active_case) begin
                    if(words[1]!=config_words[1]) $fatal(1,"Prototype config/case mismatch");
                    if(words[3]!=0) begin @(negedge clk);ack=1;@(negedge clk);ack=0;acks=acks+1;end
                    @(negedge clk);in_adc=words[4][23:0];in_ticks=$signed(words[5]);in_timestamp=words[6][31:0];
                    in_tag=words[2][31:0];in_valid=1;do @(posedge clk);while(!in_ready);
                    @(negedge clk);in_adc='1;in_ticks=-1;in_timestamp='1;in_tag='1;
                    latency=0;
                    while(!sample_done) begin
                        @(negedge clk);latency=latency+1;
                        if(latency>SINGLE_LATENCY_BOUND || (in_ready && !sample_done)) $fatal(1,"Prototype completion/ready timeout");
                    end
                    in_valid=0;compare();frames=frames+1;
                    if(candidate_valid)candidates=candidates+1;if(fault_flags[9])overflow_frames=overflow_frames+1;
                    if(latency>max_latency)max_latency=latency;
                end
            end else if(got==1 || !$feof(fd)) $fatal(1,"Malformed prototype record");
        end
        $fclose(fd);
        if(cases!=7 || frames!=17600 || candidates!=42 || acks==0 || overflow_frames==0) $fatal(1,"Incomplete accepted-frame prototype suite");
        $display("RTL_PROTOTYPE_PASSED profile=%0d cases=%0d frames=%0d candidates=%0d acks=%0d overflow_frames=%0d max_latency=%0d",PROFILE,cases,frames,candidates,acks,overflow_frames,max_latency);$finish;
    end
    initial begin #100000000;$fatal(1,"Prototype global watchdog");end
endmodule
`default_nettype wire
