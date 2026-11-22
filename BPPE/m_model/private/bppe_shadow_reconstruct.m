function [windows,beats]=bppe_shadow_reconstruct(run,frames,cfg,p,s,case_id)
% Frozen EXP-028 trace reconstruction; public-run equality is checked per window.
init=bppe_init_fixed(cfg,p);fx=init.fx;q=fx.math;history=bppe_processing_init(cfg);c=history.channel;
windows=struct([]);beats=struct([]);candidate_index=1;beat_index=0;
tick_step=1e9/cfg.fs_hz/cfg.tick_period_ns;
assert(tick_step==fix(tick_step) && cfg.channels==1,'BPPE:AnalysisDomain','Uniform single-channel integer ticks required.');
for n=1:numel(frames)
    ticks=(n-1)*tick_step;t=ticks*2^p.time_f;
    assert(mod(double(frames(n).timestamp)-double(frames(1).timestamp),2^32)==ticks, ...
        'BPPE:AnalysisDomain','Unexpected acquisition spacing.');
    c.dc=round(run.trace.dc(n)*2^p.signal_f);c.y=round(run.trace.filtered(n)*2^p.signal_f);
    old=c;
    [c,emitted]=bppe_beat_fixed(c,t,ticks,cfg,fx);
    assert(~isempty(emitted)==run.trace.new_beat(n),'BPPE:Replay','Reconstructed beat event mismatch.');
    if ~isempty(emitted)
        beat_index=beat_index+1;
        b=struct('case_id',case_id,'beat_index',beat_index,'frame',n, ...
            'start_s',old.cycle_t(1)/2^p.time_f*cfg.tick_period_ns*1e-9, ...
            'end_s',c.beat_times(end)/2^p.time_f*cfg.tick_period_ns*1e-9, ...
            'period_s',emitted(1)/2^p.feature_f,'rise',emitted(2)/2^p.feature_f, ...
            'width',emitted(3)/2^p.feature_f,'area',emitted(4)/2^p.feature_f,'ac_dc',emitted(5)/2^p.feature_f);
        if isempty(beats),beats=b;else,beats(end+1)=b;end %#ok<AGROW>
    end
    if candidate_index<=numel(run.candidate_frame_index) && n==run.candidate_frame_index(candidate_index)
        history.channel=c;history.elapsed_s=ticks*cfg.tick_period_ns*1e-9;history.elapsed_ticks=ticks;
        replay=bppe_measurement_fixed(history,cfg,candidate_index,double(frames(n).timestamp),fx);
        original=run.candidates(candidate_index);
        assert(replay.result_valid==original.result_valid && replay.reason_flags==original.reason_flags && ...
            replay.sqi==original.sqi && isequaln(replay.features,original.features) && ...
            isequaln([replay.sbp replay.dbp],[original.sbp original.dbp]) && ...
            replay.sbp_uq9_7==original.sbp_uq9_7 && replay.dbp_uq9_7==original.dbp_uq9_7, ...
            'BPPE:Replay','Reconstructed pre-clear window changed candidate.');
        raw=c.beats;count=size(raw,1);features=raw/2^p.feature_f;
        avg=NaN;cv=NaN;regularity=NaN;clean=NaN;morph_cv=NaN;amp_ok=false;
        if count>=cfg.beats_per_result
            avg=q.divide(sum(raw(:,1)),count);variance=0;
            for k=1:count,variance=q.add(variance,q.mul(raw(k,1)-avg,raw(k,1)-avg));end
            deviation=q.sqrt_nearest(q.divide(variance,count));
            cv_raw=q.clip(q.divide(q.mul(deviation,2^p.feature_f),avg),p.feature_w,true,'analysis_cv');
            regularity=q.divide(q.mul(cv_raw,2^p.feature_f),fx.max_cv);
            regularity=max(0,2^p.feature_f-regularity)/2^p.feature_f;
            clean=q.divide(cfg.beats_per_result*2^p.feature_f,cfg.beats_per_result+c.rejected_beats)/2^p.feature_f;
            cv=cv_raw/2^p.feature_f;
            amp_ok=all(raw(:,5)>=fx.min_amplitude & raw(:,5)<=fx.max_amplitude);
            morph_cv=max(std(features(:,2:4),1,1)./max(abs(mean(features(:,2:4),1)),eps));
        end
        hr=NaN;if all(isfinite(original.features)),hr=60/original.features(1);end
        first_beat=max(1,beat_index-count+1);window_start=NaN;
        if count>0,window_start=beats(first_beat).start_s;end
        w=struct('case_id',case_id,'kind',s.kind,'snr_db',s.snr_db,'seed',s.seed,'true_bpm',s.bpm,'split',s.split, ...
            'candidate',candidate_index,'frame',n,'time_s',(n-1)/cfg.fs_hz,'window_start_s',window_start, ...
            'first_beat',first_beat,'last_beat',beat_index,'count',count,'rejected_beats',c.rejected_beats, ...
            'baseline_valid',original.result_valid,'reason',double(original.reason_flags),'sqi',double(original.sqi), ...
            'period_mean_s',avg/2^p.feature_f,'hr_bpm',hr,'hr_error_bpm',abs(hr-s.bpm),'bad_hr_proxy',abs(hr-s.bpm)>5, ...
            'period_cv',cv,'regularity',regularity,'clean_fraction',clean,'amplitude_ok',amp_ok,'morphology_cv_max',morph_cv);
        if isempty(windows),windows=w;else,windows(end+1)=w;end %#ok<AGROW>
        c.beats=zeros(0,5);c.beat_times=[];c.rejected_beats=0;
        history.window_start_s=history.elapsed_s;candidate_index=candidate_index+1;
    end
end
assert(candidate_index==numel(run.candidates)+1 && ~q.failed(),'BPPE:Replay','Incomplete replay or analysis numeric fault.');
end
