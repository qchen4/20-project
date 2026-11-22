// Simulation-only scheduling variation; numerical inputs/expectations are unchanged.
bit temporal_stress=0,carry_response=0,early_ready=0;
bit source_was_stalled=0,response_was_stalled=0;
integer unsigned stress_seed=1,stress_rng=1;
integer accepted_inputs=0,consumed_outputs=0,source_wait_cycles=0,sink_stall_cycles=0;
integer held_candidate_cycles=0,held_rejection_cycles=0,early_responses=0,long_holds=0;
integer carried_responses=0,input_gap_cycles=0,hold_cycles=0;
wire [239:0] offered_frame={in_adc,in_timestamp,in_tag,in_config_error,in_gain_transition,
    in_channel_valid,in_channel_saturated,in_gain,in_optical,in_sequence};
logic [239:0] stalled_frame;
// All three supported profiles fit in 2048 bits; unused upper bits are zero.
logic [2047:0] stalled_response,carried_payload;
function automatic logic [2047:0] completion_payload();
    completion_payload={sample_accepted,sample_reasons,sample_tag,sample_saturations,sample_divzero,sample_precision,
        candidate_valid,candidate_result_valid,candidate_has_features,candidate_seq,candidate_reasons,candidate_tag,candidate_timestamp,candidate_sqi,
        candidate_features[0],candidate_features[1],candidate_features[2],candidate_features[3],candidate_features[4],
        candidate_pressure_raw[0],candidate_pressure_raw[1],candidate_codes[0],candidate_codes[1],
        pending,snapshot_result_valid,snapshot_has_features,snapshot_seq,snapshot_reasons,snapshot_tag,snapshot_timestamp,snapshot_sqi,
        snapshot_features[0],snapshot_features[1],snapshot_features[2],snapshot_features[3],snapshot_features[4],
        snapshot_pressure_raw[0],snapshot_pressure_raw[1],snapshot_codes[0],snapshot_codes[1],result_counter,fault_flags};
endfunction
function automatic integer unsigned stress_random(input integer unsigned limit);
    stress_rng=stress_rng^(stress_rng<<13);
    stress_rng=stress_rng^(stress_rng>>17);
    stress_rng=stress_rng^(stress_rng<<5);
    stress_random=stress_rng%limit;
endfunction
task automatic release_stressed_response;
    begin
        if(!sample_done)$fatal(1,"Stress driver lost pending completion");
        sample_ready=1;
        @(posedge clk);#1;
        if(sample_done || candidate_valid)$fatal(1,"Completion did not retire exactly once");
        @(negedge clk);sample_ready=0;carry_response=0;
    end
endtask
task automatic wait_with_offered_frame;
    integer wait_cycles;
    begin
        wait_cycles=1+stress_random(16);
        repeat(wait_cycles)begin
            if(!sample_done || in_ready || completion_payload()!==carried_payload)
                $fatal(1,"Offered future frame changed a stalled completion");
            @(negedge clk);
        end
        release_stressed_response();
    end
endtask
always @(posedge clk)if(temporal_stress)begin
    if(rst)begin
        if(accepted_inputs!=consumed_outputs)$fatal(1,"Stress reset discarded unconsumed work");
        source_was_stalled=0;response_was_stalled=0;
    end else begin
        if(source_was_stalled && (!in_valid || offered_frame!==stalled_frame))
            $fatal(1,"Stress source violated ready/valid stability");
        if(response_was_stalled && (!sample_done || completion_payload()!==stalled_response))
            $fatal(1,"Completion changed while backpressured");
        if(in_valid && in_ready)accepted_inputs=accepted_inputs+1;
        if(sample_done && sample_ready)consumed_outputs=consumed_outputs+1;
        if(accepted_inputs<consumed_outputs || accepted_inputs-consumed_outputs>1)
            $fatal(1,"System accepted/lost/duplicated an unexpected transaction");
        source_was_stalled=in_valid && !in_ready;
        response_was_stalled=sample_done && !sample_ready;
        stalled_frame=offered_frame;stalled_response=completion_payload();
        if(source_was_stalled)source_wait_cycles=source_wait_cycles+1;
        if(response_was_stalled)begin
            sink_stall_cycles=sink_stall_cycles+1;
            if(candidate_valid)held_candidate_cycles=held_candidate_cycles+1;
            if(!sample_accepted)held_rejection_cycles=held_rejection_cycles+1;
        end
    end
end
