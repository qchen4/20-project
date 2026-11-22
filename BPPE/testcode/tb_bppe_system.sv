`timescale 1ns/1ps
`default_nettype none
module tb_bppe_system;
`include "system_tb_ports.svh"
    string filename;
    integer fd,got,i,j,latency,frames=0,cases=0,candidates=0,acks=0,overflow_frames=0,max_latency=0;
    logic [63:0] kind,config_words[0:77],words[0:59];
    logic active_case=0;
    task automatic reset_and_finish(input string marker);
        begin
            @(negedge clk);rst=1;in_valid=0;ack=0;sample_ready=0;
            repeat(2)@(negedge clk);rst=0;repeat(20)@(negedge clk);
            if(sample_done || candidate_valid || pending || result_counter!=0 || fault_flags!=0 ||
                snapshot_seq!=0 || snapshot_tag!=0 || snapshot_timestamp!=0 || snapshot_result_valid || snapshot_has_features ||
                `BPPE_SYSTEM_DUT_CORE.counts[0]!=0 || `BPPE_SYSTEM_DUT_CORE.counts[1]!=0 || `BPPE_SYSTEM_DUT_CORE.counts[2]!=0 || !in_ready || !`BPPE_SYSTEM_DUT_CORE.channel_idle ||
                `BPPE_SYSTEM_DUT_CORE.window_deadline_ticks!=initial_deadline_ticks || sample_saturations!=initial_saturations ||
                sample_divzero!=initial_divzero || sample_precision!=initial_precision)
                $fatal(1,"System coordinated reset failed");
            for(integer x=0;x<5;x=x+1)if(snapshot_features[x]!=0)$fatal(1,"Reset retained snapshot features");
            for(integer x=0;x<2;x=x+1)if(snapshot_codes[x]!=0 || snapshot_pressure_raw[x]!=0)$fatal(1,"Reset retained pressure");
            $display("RTL_SYSTEM_FLOW_PASSED %s",marker);$finish;
        end
    endtask
    task automatic check_initial_faults;
        begin
            if(!sample_accepted || sample_saturations!=3 || sample_divzero!=4 || sample_precision!=5 ||
                sample_reasons!=192 || fault_flags!=192 || pending)$fatal(1,"Initial host faults were not preserved");
            in_valid=0;sample_ready=1;@(posedge clk);#1;@(negedge clk);sample_ready=0;
            in_valid=1;in_config_error=0;in_channel_valid=0;in_channel_saturated=0;in_gain_transition=0;in_tag=77;
            do @(posedge clk);while(!in_ready);
            @(negedge clk);in_valid=0;
            while(!sample_done)@(negedge clk);
            repeat(3)begin
                if(sample_accepted || sample_reasons!=2 || fault_flags!=194 || sample_tag!=77 ||
                    sample_saturations!=3 || sample_divzero!=4 || sample_precision!=5 || candidate_valid || pending ||
                    `BPPE_SYSTEM_DUT_CORE.counts[0]!=0 || `BPPE_SYSTEM_DUT_CORE.window_deadline_ticks!=initial_deadline_ticks)
                    $fatal(1,"Frame rejection lost initial numerical faults");
                @(negedge clk);
            end
            reset_and_finish("INITIAL_FAULTS");
        end
    endtask
    task automatic compare;
        begin
            if(!sample_done || sample_tag!==words[2][31:0] || sample_saturations!==words[9] || sample_divzero!==words[10] ||
                sample_precision!==words[11] || candidate_valid!==words[12][0] || pending!==words[28][0] ||
                result_counter!==words[45][15:0] || fault_flags!==words[46][15:0] || sample_accepted!==words[4][0] || sample_reasons!==words[5][15:0])
                $fatal(1,"Prototype control mismatch profile=%0d case=%0d frame=%0d tag=%0d done=%0b candidate=%0b expected_candidate=%0b pending=%0b expected_pending=%0b counter=%0d expected_counter=%0d counts=%0d flags=%0d expected_flags=%0d",PROFILE,words[1],words[2],sample_tag,sample_done,candidate_valid,words[12],pending,words[28],result_counter,words[45],`BPPE_SYSTEM_DUT_CORE.counts[0],fault_flags,words[46]);
            if($signed(`BPPE_SYSTEM_DUT_CORE.window_deadline_ticks)!==$signed(words[7]) ||
                $signed(`BPPE_SYSTEM_DUT_CORE.acquisition.adapter.elapsed_ticks)!==$signed(words[6]) ||
                `BPPE_SYSTEM_DUT_CORE.acquisition.adapter.have_frame!==words[8][0])$fatal(1,"Frame reset/deadline mismatch");
            if(candidate_valid) begin
                if(candidate_seq!==words[13][15:0] || candidate_tag!==words[2][31:0] || candidate_timestamp!==words[14][31:0] ||
                    candidate_has_features!==words[15][0] || candidate_result_valid!==words[16][0] || candidate_reasons!==words[17][15:0] ||
                    candidate_sqi!==words[18][7:0] || $signed(candidate_pressure_raw[0])!==$signed(words[24]) ||
                    $signed(candidate_pressure_raw[1])!==$signed(words[25]) || candidate_codes[0]!==words[26][15:0] || candidate_codes[1]!==words[27][15:0])
                    $fatal(1,"Prototype candidate mismatch case=%0d frame=%0d",words[1],words[2]);
                for(integer x=0;x<5;x=x+1) if($signed(candidate_features[x])!==$signed(words[19+x])) $fatal(1,"Prototype feature mismatch case=%0d frame=%0d index=%0d",words[1],words[2],x);
            end
            if(snapshot_seq!==words[29][15:0] || snapshot_tag!==words[30][31:0] || snapshot_timestamp!==words[31][31:0] ||
                snapshot_has_features!==words[32][0] || snapshot_result_valid!==words[33][0] || snapshot_reasons!==words[34][15:0] ||
                snapshot_sqi!==words[35][7:0] || $signed(snapshot_pressure_raw[0])!==$signed(words[41]) || $signed(snapshot_pressure_raw[1])!==$signed(words[42]) ||
                snapshot_codes[0]!==words[43][15:0] || snapshot_codes[1]!==words[44][15:0])
                $fatal(1,"Prototype pending snapshot changed/mismatched case=%0d frame=%0d",words[1],words[2]);
            for(integer x=0;x<5;x=x+1) if($signed(snapshot_features[x])!==$signed(words[36+x])) $fatal(1,"Prototype snapshot feature mismatch");
        end
    endtask
`include "system_temporal_stress.svh"
`include "system_recovery_checks.svh"
    initial begin
        temporal_stress=$test$plusargs("TEMPORAL_STRESS");
        recovery_requested=$value$plusargs("RECOVERY_TARGET=%s",recovery_target);
        ack_boundaries=$test$plusargs("ACK_BOUNDARIES");
        if((recovery_requested && (temporal_stress || ack_boundaries)) || (ack_boundaries && temporal_stress))
            $fatal(1,"Run temporal, recovery and ACK-boundary modes separately");
        if($value$plusargs("STRESS_SEED=%d",stress_seed))begin end
        if(temporal_stress && stress_seed==0)$fatal(1,"Stress seed must be nonzero");
        stress_rng=stress_seed;
        if(!$value$plusargs("VECTORS=%s",filename)) $fatal(1,"Missing prototype vectors");
        fd=$fopen(filename,"r");if(fd==0) $fatal(1,"Cannot open prototype vectors");
        while(!$feof(fd)) begin
            got=$fscanf(fd,"%h",kind);
            if(got==1 && kind==0) begin
                if(recovery_done && config_words[1]==recovery_case)recovery_case_closed=1;
                if(temporal_stress && carry_response)release_stressed_response();
                config_words[0]=kind;
                for(i=1;i<78;i=i+1) begin got=$fscanf(fd,"%h",config_words[i]);if(got!=1) $fatal(1,"Truncated prototype config");end
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
                    if($test$plusargs("INITIAL_FAULTS"))begin initial_saturations=3;initial_divzero=4;initial_precision=5;end
                    warmup_ticks=$signed(config_words[70]);timeout_ticks=$signed(config_words[71]);initial_deadline_ticks=$signed(config_words[72]);
                    cfg_channels=config_words[73][1:0];cfg_primary=config_words[74][1:0];
                    cfg_min_delta=config_words[75][31:0];cfg_max_delta=config_words[76][31:0];cfg_max_abs_skew=config_words[77][31:0];
                    sample_ready=0;repeat(2) @(negedge clk);rst=0;cases=cases+1;
                    case_data_offset=$ftell(fd);case_frames=frames;case_candidates=candidates;case_acks=acks;case_overflows=overflow_frames;case_latency=max_latency;
                    if(ack_boundaries)check_serialized_ack();
                end
            end else if(got==1 && kind==1) begin
                words[0]=kind;for(i=1;i<60;i=i+1) begin got=$fscanf(fd,"%h",words[i]);if(got!=1) $fatal(1,"Truncated prototype sample");end
                if(active_case) begin:process_frame
                    if(words[1]!=config_words[1]) $fatal(1,"Prototype config/case mismatch");
                    if(words[3]!=0) begin
                        if(temporal_stress && carry_response)release_stressed_response();
                        if(ack_boundaries)check_serialized_ack();
                        else begin @(negedge clk);ack=1;@(negedge clk);ack=0;end
                        acks=acks+1;
                    end
                    if(temporal_stress)begin
                        hold_cycles=stress_random(8);input_gap_cycles=input_gap_cycles+hold_cycles;
                        repeat(hold_cycles)@(negedge clk);
                        early_ready=(stress_random(4)==0);
                    end
                    @(negedge clk);in_config_error=words[47][0];in_sequence=words[48][15:0];in_gain=words[49][7:0];
                    in_optical=words[50][7:0];in_gain_transition=words[51][0];in_channel_valid=words[52][2:0];in_channel_saturated=words[53][2:0];
                    for(i=0;i<3;i=i+1)begin in_adc[i*24+:24]=words[54+i][23:0];in_timestamp[i*32+:32]=words[57+i][31:0];end
                    in_tag=words[2][31:0];in_valid=1;
                    if(temporal_stress)begin
                        if(carry_response)wait_with_offered_frame();
                        sample_ready=early_ready;
                    end
                    do @(posedge clk);while(!in_ready);
                    @(negedge clk);in_adc='1;in_timestamp='1;in_tag='1;in_config_error=~in_config_error;
                    if(temporal_stress || recovery_requested || ack_boundaries)in_valid=0;
                    latency=0;
                    while(!sample_done) begin
                        @(negedge clk);latency=latency+1;
                        if(!sample_done && at_recovery_point())begin reset_and_replay_case();disable process_frame;end
                        if($test$plusargs("RESET_NUMERIC") && `BPPE_SYSTEM_DUT_CORE.phase==1 && `BPPE_SYSTEM_DUT_CORE.acquisition.phase==1)
                            reset_and_finish("RESET_NUMERIC");
                        if($test$plusargs("RESET_MEASUREMENT") && `BPPE_SYSTEM_DUT_CORE.phase==4 && !`BPPE_SYSTEM_DUT_CORE.measure_valid)
                            reset_and_finish("RESET_MEASUREMENT");
                        if($test$plusargs("ACK_COLLISION") && `BPPE_SYSTEM_DUT_CORE.measure_transfer)ack=1;
                        if(latency>SYSTEM_LATENCY_BOUND || (in_ready && !sample_done)) $fatal(1,"Prototype completion/ready timeout");
                    end
                    in_valid=0;
                    if($test$plusargs("INITIAL_FAULTS"))check_initial_faults();
                    // Deliberately corrupt only the test oracle in the negative checker test.
                    if($test$plusargs("UNKNOWN_EXPECTED") && candidate_valid)begin
                        $display("INJECTING_UNKNOWN_EXPECTED_FEATURE");words[19]='x;
                        compare();$fatal(1,"Unknown expected feature escaped the scoreboard");
                    end
                    compare();if(candidate_valid)candidates=candidates+1;
                    if(at_recovery_point())begin reset_and_replay_case();disable process_frame;end
                    if(recovery_done && config_words[1]==recovery_case)begin
                        replayed_case_frames=replayed_case_frames+1;
                        if(candidate_valid)replayed_case_candidates=replayed_case_candidates+1;
                    end
                    if($test$plusargs("RESET_PENDING") && candidate_valid && pending)
                        reset_and_finish("RESET_PENDING");
                    if(temporal_stress)begin
                        hold_cycles=early_ready?0:stress_random(32);
                        if(!early_ready && frames%257==0)begin hold_cycles=2047;long_holds=long_holds+1;end
                        if(early_ready)early_responses=early_responses+1;
                        repeat(hold_cycles)begin @(negedge clk);compare();if(in_ready)$fatal(1,"Completion stall admitted a frame");end
                        if(!early_ready && stress_random(2)==0)begin
                            carry_response=1;carried_payload=completion_payload();carried_responses=carried_responses+1;
                        end else release_stressed_response();
                    end else begin
                        repeat(3)begin @(negedge clk);compare();if(in_ready)$fatal(1,"Completion stall admitted a frame");end
                        sample_ready=1;@(posedge clk);#1;@(negedge clk);sample_ready=0;
                    end
                    frames=frames+1;
                    if(fault_flags[9])overflow_frames=overflow_frames+1;
                    if(latency>max_latency)max_latency=latency;
                end
            end else if(got==1 || !$feof(fd)) $fatal(1,"Malformed prototype record");
        end
        $fclose(fd);
        if(recovery_done && config_words[1]==recovery_case)recovery_case_closed=1;
        if(recovery_requested)begin
            if(!recovery_done || !recovery_case_closed || replayed_case_frames==0 || replayed_case_candidates==0)
                $fatal(1,"Recovery coverage incomplete done=%0b closed=%0b frames=%0d candidates=%0d",recovery_done,recovery_case_closed,replayed_case_frames,replayed_case_candidates);
            $display("RTL_SYSTEM_RECOVERY_PASSED profile=%0d target=%s case=%0d discarded_prefix=%0d replayed_case_frames=%0d replayed_case_candidates=%0d",PROFILE,recovery_target,recovery_case,recovery_prefix,replayed_case_frames,replayed_case_candidates);
        end
        if(ack_boundaries)begin
            if(checked_acks!=cases+acks || empty_ack_checks==0 || pending_ack_checks==0)$fatal(1,"Incomplete ACK boundary coverage");
            $display("RTL_SYSTEM_ACK_BOUNDARIES_PASSED profile=%0d checks=%0d empty=%0d pending=%0d",PROFILE,checked_acks,empty_ack_checks,pending_ack_checks);
        end
        if(temporal_stress)begin
            if(carry_response)release_stressed_response();
            if(accepted_inputs!=frames || consumed_outputs!=frames || source_wait_cycles==0 ||
                sink_stall_cycles==0 || held_candidate_cycles==0 || held_rejection_cycles==0 || early_responses==0 || long_holds==0 || carried_responses==0)
                $fatal(1,"Incomplete temporal stress coverage");
            $display("RTL_SYSTEM_TEMPORAL_PASSED profile=%0d seed=%0d accepted=%0d consumed=%0d source_wait=%0d sink_stall=%0d held_candidate=%0d held_rejection=%0d early_ready=%0d long_holds=%0d carried=%0d input_gaps=%0d",PROFILE,stress_seed,accepted_inputs,consumed_outputs,source_wait_cycles,sink_stall_cycles,held_candidate_cycles,held_rejection_cycles,early_responses,long_holds,carried_responses,input_gap_cycles);
        end
        if(cases!=24 || frames!=50400 || candidates==0 || acks==0 || overflow_frames==0) $fatal(1,"Incomplete accepted-frame prototype suite");
        $display("RTL_SYSTEM_PASSED profile=%0d cases=%0d frames=%0d candidates=%0d acks=%0d overflow_frames=%0d max_latency=%0d",PROFILE,cases,frames,candidates,acks,overflow_frames,max_latency);$finish;
    end
    initial begin #2000000000;$fatal(1,"Prototype global watchdog");end
endmodule
`undef BPPE_SYSTEM_DUT_CORE
`default_nettype wire
