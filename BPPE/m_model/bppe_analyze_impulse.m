function report=bppe_analyze_impulse(output_dir,mode)
% Offline synthetic diagnosis. No production gates or thresholds are changed.
% Reconstruct pre-clear windows from exact fixed trace codes and verify every
% reconstructed beat/candidate against the unmodified public streaming run.
root=fileparts(mfilename('fullpath'));
if nargin<1,output_dir=fullfile(root,'artifacts','impulse-analysis');end
if nargin<2,mode='matrix';end
assert(ismember(mode,{'focus','matrix'}),'BPPE:Analysis','Use focus or matrix.');
if ~exist(output_dir,'dir'),mkdir(output_dir);end
cfg=bppe_demo_config();p=bppe_fixed_profile();duration=32;
discovery=[11 23 37 51 79];heldout=[101 211 307 401 503];
spec=struct([]);
if strcmp(mode,'focus')
    add_spec('clean',Inf,0,75,'control');
    add_spec('impulsive',0,37,75,'discovery');
else
    for bpm=[60 75 120]
        add_spec('clean',Inf,0,bpm,'control');
        for seed=discovery,add_spec('impulsive',0,seed,bpm,'discovery');end
        for seed=heldout
            add_spec('impulsive',0,seed,bpm,'heldout');
            add_spec('impulsive',6,seed,bpm,'heldout');
            add_spec('white',15,seed,bpm,'heldout');
            add_spec('periodic_motion',15,seed,bpm,'heldout');
        end
    end
end
windows=struct([]);beats=struct([]);runs=struct([]);example=[];
for case_id=1:numel(spec)
    s=spec(case_id);
    clean=bppe_synthetic(cfg,duration,struct('noise_std',0,'heart_rate_bpm',s.bpm));
    if strcmp(s.kind,'clean'),frames=clean;
    else,frames=bppe_inject_noise(clean,cfg,s.kind,s.snr_db,s.seed);end
    actual=bppe_run(frames,cfg,true,p);
    assert(all(actual.accepted) && ~actual.state.fx.math.failed(), ...
        'BPPE:AnalysisDomain','This diagnostic requires accepted, numeric-fault-free synthetic frames.');
    [w,b]=reconstruct(actual,frames,cfg,p,s,case_id);
    if isempty(windows),windows=w;else,windows=[windows w];end %#ok<AGROW>
    if isempty(beats),beats=b;else,beats=[beats b];end %#ok<AGROW>
    valid=[w.baseline_valid];bad=[w.bad_hr_proxy];
    r=struct('case_id',case_id,'kind',s.kind,'snr_db',s.snr_db,'seed',s.seed,'true_bpm',s.bpm,'split',s.split, ...
        'frames',numel(frames),'candidates',numel(w),'baseline_valid',sum(valid),'bad_hr_proxy',sum(valid&bad));
    if isempty(runs),runs=r;else,runs(end+1)=r;end %#ok<AGROW>
    if s.bpm==75 && strcmp(s.kind,'impulsive') && s.snr_db==0 && s.seed==37
        example=struct('clean',clean,'frames',frames,'run',actual,'windows',w,'beats',b);
    end
    fprintf('IMPULSE_ANALYSIS_CASE %d/%d %s snr=%g seed=%d bpm=%g candidates=%d valid=%d bad=%d\n', ...
        case_id,numel(spec),s.kind,s.snr_db,s.seed,s.bpm,numel(w),sum(valid),sum(valid&bad));
end
assert(~isempty(example) && any([example.windows.baseline_valid]&[example.windows.bad_hr_proxy]), ...
    'BPPE:KnownGap','Fixed seed37 gap must remain visible.');
W=struct2table(windows);B=struct2table(beats);R=struct2table(runs);
G=shadow_gates(W,R,duration);
report=struct('windows',W,'beats',B,'runs',R,'gates',G,'mode',mode,'config',cfg, ...
    'discovery_seeds',discovery,'heldout_seeds',heldout,'data_kind','synthetic; no reference blood pressure', ...
    'scope','balanced single-channel constant-HR 32s accepted frames; offline gates only');
writetable(W,fullfile(output_dir,'candidate_windows.csv'));
writetable(B,fullfile(output_dir,'emitted_beats.csv'));
writetable(R,fullfile(output_dir,'runs.csv'));
writetable(G,fullfile(output_dir,'shadow_gates.csv'));
save(fullfile(output_dir,'impulse_analysis.mat'),'report','example');
plot_example(example,cfg,p,output_dir);
bppe_write_manifest(output_dir,'impulse-root-cause',struct('mode',mode,'cases',numel(spec), ...
    'duration_s',duration,'discovery_seeds',discovery,'heldout_seeds',heldout,'production_changed',false));
fprintf('IMPULSE_ANALYSIS_PASSED cases=%d frames=%d candidates=%d baseline_valid=%d bad_hr_proxy=%d\n', ...
    height(R),sum(R.frames),height(W),sum(W.baseline_valid),sum(W.baseline_valid&W.bad_hr_proxy));

    function add_spec(kind,snr,seed,bpm,split)
        value=struct('kind',kind,'snr_db',snr,'seed',seed,'bpm',bpm,'split',split);
        if isempty(spec),spec=value;else,spec(end+1)=value;end
    end
end

function [windows,beats]=reconstruct(run,frames,cfg,p,s,case_id)
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

function result=shadow_gates(W,R,duration)
% Predeclared research grid, never applied back to model state or RTL.
names={'baseline','sqi175','sqi200','sqi225','morph010','morph020','morph030','morph050'};
keep=[W.baseline_valid,W.baseline_valid&W.sqi>=175,W.baseline_valid&W.sqi>=200,W.baseline_valid&W.sqi>=225, ...
    W.baseline_valid&W.morphology_cv_max<=0.1,W.baseline_valid&W.morphology_cv_max<=0.2, ...
    W.baseline_valid&W.morphology_cv_max<=0.3,W.baseline_valid&W.morphology_cv_max<=0.5];
rows=struct([]);
for split={'control','discovery','heldout'}
    selected=strcmp(W.split,split{1});run_ids=R.case_id(strcmp(R.split,split{1}));
    if isempty(run_ids),continue;end
    for k=1:numel(names)
        accepted=selected&keep(:,k);base=selected&W.baseline_valid;bad=W.bad_hr_proxy;
        max_gap=0;
        for id=reshape(run_ids,1,[])
            times=W.time_s(accepted&W.case_id==id);max_gap=max(max_gap,max(diff([0;times;duration])));
        end
        r=struct('split',split{1},'gate',names{k},'runs',numel(run_ids),'candidates',sum(selected), ...
            'baseline_valid',sum(base),'baseline_bad',sum(base&bad),'retained',sum(accepted),'retained_bad',sum(accepted&bad), ...
            'removed_bad',sum(base&bad&~keep(:,k)),'removed_good_proxy',sum(base&~bad&~keep(:,k)), ...
            'max_no_report_interval_s',max_gap);
        if isempty(rows),rows=r;else,rows(end+1)=r;end %#ok<AGROW>
    end
end
result=struct2table(rows);
end

function plot_example(ex,cfg,p,output_dir)
bad=find([ex.windows.baseline_valid]&[ex.windows.bad_hr_proxy],1);w=ex.windows(bad);
clean=bppe_run(ex.clean,cfg,true,p);time=(0:numel(ex.frames)-1)'/cfg.fs_hz;
b=ex.beats(w.first_beat:w.last_beat);lo=max(0,w.window_start_s-0.8);hi=min(time(end),w.time_s+0.8);
fig=figure('Visible','off','Color','white','Position',[100 100 1200 820]);cleanup=onCleanup(@()close(fig));
tiledlayout(3,1);
nexttile;plot(time,vertcat(ex.frames.ppg)-vertcat(ex.clean.ppg));xlim([lo hi]);grid on;
ylabel('Added ADC codes');title({'Synthetic impulse, seed 37, 0 dB', ...
    sprintf('Accepted %.2f bpm versus known 75 bpm; SQI %d',w.hr_bpm,w.sqi)});
nexttile;plot(time,clean.trace.filtered,time,ex.run.trace.filtered);hold on;
for k=1:numel(b),xline(b(k).end_s,':');end
xlim([lo hi]);grid on;ylabel('Filtered ADC codes');legend('Clean','Impulsive','Location','best');
nexttile;stem([b.end_s],[b.period_s],'filled');hold on;yline(0.8,'--','Synthetic period 0.8 s');
xlim([lo hi]);ylim([0 1.1]);grid on;xlabel('Time (s)');ylabel('Accepted beat period (s)');
set(findall(fig,'Type','axes'),'Color','white','XColor',[0.15 0.15 0.15], ...
    'YColor',[0.15 0.15 0.15],'GridColor',[0.7 0.7 0.7],'FontSize',11);
set(findall(fig,'Type','text'),'Color',[0.1 0.1 0.1]);
set(findall(fig,'Type','legend'),'Color','white','TextColor',[0.1 0.1 0.1],'EdgeColor',[0.6 0.6 0.6]);
set(findall(fig,'Type','constantline'),'Color',[0.35 0.35 0.35]);
exportgraphics(fig,fullfile(output_dir,'known_impulse_window.png'),'Resolution',150);
clear cleanup
end
