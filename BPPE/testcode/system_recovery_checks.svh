// Local coordinated-reset recovery and serialized prototype ACK checks only.
string recovery_target="";
bit recovery_requested=0,recovery_done=0,recovery_case_closed=0,ack_boundaries=0;
integer case_data_offset,case_frames,case_candidates,case_acks,case_overflows,case_latency;
integer recovery_case=0,recovery_prefix=0,replayed_case_frames=0,replayed_case_candidates=0;
integer checked_acks=0,empty_ack_checks=0,pending_ack_checks=0;
wire [2:0] pre_multiply,beat_dividing,beat_scanning,reset_clean_channels;
generate for(genvar rc=0;rc<3;rc=rc+1)begin:recovery_observe
    assign pre_multiply[rc]=(`BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.preprocess.phase==
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.preprocess.MULTIPLY);
    assign beat_dividing[rc]=(`BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.divider.phase==
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.divider.ITERATE &&
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.divider.remaining==40);
    assign beat_scanning[rc]=(`BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.phase==
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.SCAN_EVAL &&
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.index>=3);
    assign reset_clean_channels[rc]=(`BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.preprocess.phase==
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.preprocess.IDLE &&
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.phase==
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.IDLE &&
        `BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.cycle_count==0 &&
        !`BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.beat.tracking &&
        !`BPPE_SYSTEM_DUT_CORE.acquisition.channels[rc].core.out_valid);
end endgenerate
function automatic bit at_recovery_point();
    at_recovery_point=0;
    if(recovery_requested && !recovery_done && cfg_channels==3)begin
        case(recovery_target)
            "PREPROCESS_CH2":at_recovery_point=pre_multiply[2];
            "BEAT_DIV_CH1":at_recovery_point=beat_dividing[1];
            "BEAT_RAM_CH0":at_recovery_point=beat_scanning[0];
            "MEASURE_DIV":at_recovery_point=(`BPPE_SYSTEM_DUT_CORE.measurement.divider.phase==
                `BPPE_SYSTEM_DUT_CORE.measurement.divider.ITERATE && `BPPE_SYSTEM_DUT_CORE.measurement.divider.remaining==40);
            "MEASURE_MUL":at_recovery_point=(`BPPE_SYSTEM_DUT_CORE.measurement.multiplier.phase==
                `BPPE_SYSTEM_DUT_CORE.measurement.multiplier.MULTIPLY);
            "PENDING_HELD":at_recovery_point=sample_done && candidate_valid && pending;
            "FAULT_HELD":at_recovery_point=sample_done &&
                (sample_saturations>initial_saturations || sample_divzero>initial_divzero || sample_precision>initial_precision);
            default:at_recovery_point=0;
        endcase
    end
endfunction
task automatic reset_and_replay_case;
    integer seek_status;
    begin
        if(`BPPE_SYSTEM_DUT_CORE.measure_transfer || ack)$fatal(1,"Recovery must not choose an unresolved publication/ACK race");
        recovery_case=words[1];recovery_prefix=frames-case_frames+1;
        $display("INJECTING_SYSTEM_RECOVERY profile=%0d target=%s case=%0d frame=%0d discarded_prefix=%0d",PROFILE,recovery_target,recovery_case,words[2],recovery_prefix);
        // Inputs are cancelled by the test source during this coordinated reset.
        // No assertion about external acquisition FIFO or product reset pins.
        rst=1;in_valid=0;ack=0;sample_ready=0;
        repeat(2)begin @(posedge clk);#1;if(in_ready!==1'b0)$fatal(1,"Input accepted during reset");@(negedge clk);end
        rst=0;
        repeat(96)begin
            @(negedge clk);
            if({sample_done,candidate_valid,pending,sample_accepted,sample_reasons,sample_tag,
                candidate_seq,candidate_tag,candidate_timestamp,candidate_reasons,candidate_sqi,candidate_result_valid,candidate_has_features,
                snapshot_seq,snapshot_tag,snapshot_timestamp,snapshot_reasons,snapshot_sqi,snapshot_result_valid,snapshot_has_features,
                result_counter,fault_flags} !== '0 || in_ready!==1'b1 || reset_clean_channels!==3'b111 ||
                `BPPE_SYSTEM_DUT_CORE.channel_idle!==1'b1 || `BPPE_SYSTEM_DUT_CORE.counts[0]!==0 ||
                `BPPE_SYSTEM_DUT_CORE.counts[1]!==0 || `BPPE_SYSTEM_DUT_CORE.counts[2]!==0 ||
                `BPPE_SYSTEM_DUT_CORE.window_deadline_ticks!==initial_deadline_ticks ||
                sample_saturations!==initial_saturations || sample_divzero!==initial_divzero || sample_precision!==initial_precision)
                $fatal(1,"Reset recovery retained stale state or lost initial fault seeds");
            for(integer k=0;k<5;k=k+1)if(candidate_features[k]!==0 || snapshot_features[k]!==0)$fatal(1,"Reset recovery retained feature payload");
            for(integer k=0;k<2;k=k+1)if(candidate_codes[k]!==0 || candidate_pressure_raw[k]!==0 || snapshot_codes[k]!==0 || snapshot_pressure_raw[k]!==0)
                $fatal(1,"Reset recovery retained pressure payload");
        end
        // Rewind only data records: do NOT load config or issue a second reset.
        seek_status=$fseek(fd,case_data_offset,0);
        if(seek_status!=0)$fatal(1,"Cannot rewind recovery case");
        frames=case_frames;candidates=case_candidates;acks=case_acks;overflow_frames=case_overflows;max_latency=case_latency;
        recovery_done=1;
    end
endtask
function automatic logic [1023:0] ack_retained_payload();
    ack_retained_payload={snapshot_seq,snapshot_tag,snapshot_timestamp,snapshot_reasons,snapshot_sqi,snapshot_result_valid,snapshot_has_features,
        snapshot_features[0],snapshot_features[1],snapshot_features[2],snapshot_features[3],snapshot_features[4],
        snapshot_codes[0],snapshot_codes[1],snapshot_pressure_raw[0],snapshot_pressure_raw[1],
        result_counter,fault_flags,sample_saturations,sample_divzero,sample_precision};
endfunction
task automatic check_serialized_ack;
    logic [1023:0] retained;
    begin
        if(sample_done || candidate_valid || in_valid || `BPPE_SYSTEM_DUT_CORE.measure_transfer)
            $fatal(1,"ACK boundary test must be idle and separated from publication");
        retained=ack_retained_payload();
        if(pending)pending_ack_checks=pending_ack_checks+1;else empty_ack_checks=empty_ack_checks+1;
        @(negedge clk);ack=1;
        // First ACK clears pending; two repetitions must be idempotent.
        repeat(3)begin
            @(posedge clk);#1;
            if(pending!==1'b0 || ack_retained_payload()!==retained || sample_done!==1'b0 || candidate_valid!==1'b0)
                $fatal(1,"Serialized repeated ACK changed payload/counters/faults");
            @(negedge clk);
        end
        ack=0;checked_acks=checked_acks+1;
    end
endtask
