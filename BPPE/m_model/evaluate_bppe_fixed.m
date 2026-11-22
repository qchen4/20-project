function report=evaluate_bppe_fixed(output_dir)
% Reproducible synthetic precision sweep; no reference blood pressure labels.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','fixed'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
cases=build_cases(); names={'compact','balanced','wide'};
rows=struct([]); range_rows=struct([]); summary=struct([]);
errors=cell(1,numel(names)); output_errors=cell(1,numel(names));
demo=struct();
for i=1:numel(cases)
    c=cases(i); reference=bppe_run(c.frames,c.cfg);
    for j=1:numel(names)
        profile=bppe_fixed_profile(names{j});
        fixed=bppe_run(c.frames,c.cfg,true,profile);
        [row,err,coded_err]=compare_runs(reference,fixed);
        row.case_name=c.name; row.category=c.category; row.profile=names{j};
        rows=append(rows,row); errors{j}=[errors{j};err];
        output_errors{j}=[output_errors{j};coded_err];
        fields=fieldnames(fixed.state.fx.math.stats);
        for k=1:numel(fields)
            s=fixed.state.fx.math.stats.(fields{k});
            s.case_name=c.name; s.profile=names{j}; s.stage=fields{k};
            range_rows=append(range_rows,s);
        end
        if strcmp(c.name,'clean_75') && strcmp(names{j},'balanced')
            demo.reference=reference; demo.fixed=fixed;
            demo.frames=c.frames;
        end
    end
    fprintf('Compared case %d/%d: %s\n',i,numel(cases),c.name);
end
detail=struct2table(rows); ranges=struct2table(range_rows);
for j=1:numel(names)
    s=struct();
    selected=strcmp(detail.profile,names{j});
    s.profile=names{j}; s.cases=sum(selected); s.frames=sum(detail.frames(selected));
    s.reference_results=sum(detail.reference_results(selected));
    s.fixed_results=sum(detail.fixed_results(selected));
    s.matched_windows=sum(detail.matched_windows(selected));
    s.unmatched_reference=sum(detail.unmatched_reference(selected));
    s.unmatched_fixed=sum(detail.unmatched_fixed(selected));
    s.validity_mismatches=sum(detail.validity_mismatches(selected));
    s.reason_mismatches=sum(detail.reason_mismatches(selected));
    s.valid_pairs=size(errors{j},1);
    s.sbp_mae=mean_abs(errors{j},1); s.dbp_mae=mean_abs(errors{j},2);
    s.sbp_max=max_abs(errors{j},1); s.dbp_max=max_abs(errors{j},2);
    s.sbp_rmse=rmse_value(errors{j},1); s.dbp_rmse=rmse_value(errors{j},2);
    s.sbp_p95=percentile_abs(errors{j},1,95); s.dbp_p95=percentile_abs(errors{j},2,95);
    s.output_sbp_max_lsb=max_abs(output_errors{j},1);
    s.output_dbp_max_lsb=max_abs(output_errors{j},2);
    s.filtered_max=max(detail.filtered_max(selected));
    s.sqi_max=max(detail.sqi_max(selected));
    s.beat_event_mismatches=sum(detail.beat_event_mismatches(selected));
    s.acceptance_mismatches=sum(detail.acceptance_mismatches(selected));
    s.saturations=sum(detail.saturations(selected));
    s.divzero=sum(detail.divzero(selected));
    s.precision_faults=sum(detail.precision_faults(selected));
    s.reference_valid=sum(detail.reference_valid(selected));
    s.fixed_valid=sum(detail.fixed_valid(selected));
    s.reference_valid_rate=s.reference_valid/max(s.reference_results,1);
    s.fixed_valid_rate=s.fixed_valid/max(s.fixed_results,1);
    summary=append(summary,s);
end
report=struct('summary',struct2table(summary),'detail',detail,'ranges',ranges, ...
    'matlab_version',version,'data_kind','synthetic-no-reference-bp', ...
    'matching','identical previous/current candidate frame indices, including invalid results', ...
    'seed',7,'profiles',{names});
writetable(report.summary,fullfile(output_dir,'summary.csv'));
writetable(detail,fullfile(output_dir,'cases.csv'));
writetable(ranges,fullfile(output_dir,'ranges.csv'));
save(fullfile(output_dir,'evaluation.mat'),'report','demo','errors','output_errors');
bppe_write_manifest(output_dir,'fixed-sweep',struct('seed',7, ...
    'profiles',{names},'case_names',{ {cases.name} },'data_kind','synthetic-demo'));
export_vectors(demo,output_dir);
write_plot(report,demo,output_dir);
disp(report.summary);
end

function export_vectors(demo,output_dir)
fixed=demo.fixed; p=fixed.state.fx.profile;
frame_seq=arrayfun(@(f) f.frame_seq,demo.frames);
timestamp=arrayfun(@(f) f.timestamp(1),demo.frames);
ppg=arrayfun(@(f) f.ppg(1),demo.frames);
dc_raw=round(fixed.trace.dc(:,1)*2^p.signal_f);
filtered_raw=round(fixed.trace.filtered(:,1)*2^p.signal_f);
new_beat=fixed.trace.new_beat(:,1);
fault_flags=fixed.fault_flags;
vectors=table(frame_seq,timestamp,ppg,dc_raw,filtered_raw,new_beat,fault_flags);
writetable(vectors,fullfile(output_dir,'balanced_input_trace.csv'));
writetable(struct2table(fixed.results),fullfile(output_dir,'balanced_results.csv'));
fid=fopen(fullfile(output_dir,'balanced_profile.json'),'w');
assert(fid>=0,'BPPE:Export','Cannot write profile.');
cleanup=onCleanup(@()fclose(fid));
fprintf(fid,'%s',jsonencode(p,'PrettyPrint',true));
end

function cases=build_cases()
cases=struct([]); duration=24;
for hr=[45 60 75 90 120 160]
    cfg=bppe_demo_config();
    c=make(sprintf('clean_%d',hr),'clean',cfg,duration,struct('heart_rate_bpm',hr));
    cases=append(cases,c);
end
for n=[2 3]
    cfg=bppe_default_config(); cfg.channels=n; cfg=bppe_demo_config(cfg);
    cases=append(cases,make(sprintf('channels_%d',n),'clean',cfg,duration,struct()));
end
cfg=bppe_demo_config();
cases=append(cases,make('noise_400','stress',cfg,duration,struct('noise_std',400)));
cases=append(cases,make('near_amplitude_gate','boundary',cfg,duration,struct('amplitude',2350,'noise_std',0)));
cases=append(cases,make('below_amplitude_gate','boundary',cfg,duration,struct('amplitude',2250,'noise_std',0)));
cases=append(cases,make('noise_2000','stress',cfg,duration,struct('noise_std',2000)));
cases=append(cases,make('low_amplitude','invalid',cfg,duration,struct('amplitude',100,'noise_std',0)));
cases=append(cases,make('flat','invalid',cfg,duration,struct('amplitude',0,'noise_std',0)));
cases=append(cases,make('counter_wrap','clean',cfg,duration,struct('start_tick',2^32-500,'start_seq',65500)));
cases=append(cases,make('near_adc_max','stress',cfg,duration, ...
    struct('baseline',1.55e7,'amplitude',4e5,'noise_std',50)));
c=make('adc_full_range_steps','boundary',cfg,duration,struct());
for i=1:numel(c.frames), c.frames(i).ppg=double(mod(floor((i-1)/50),2))*(2^24-1); end
cases=append(cases,c);
c=make('missing_frame','fault',cfg,duration,struct()); c.frames(501)=[]; cases=append(cases,c);
c=make('saturation_flag','fault',cfg,duration,struct()); c.frames(501).channel_saturated=true; cases=append(cases,c);
c=make('timestamp_duplicate','fault',cfg,duration,struct());
c.frames(501).timestamp=c.frames(500).timestamp; cases=append(cases,c);
c=make('gain_transition','fault',cfg,duration,struct());
c.frames(501).gain_transition=true; cases=append(cases,c);
cfg=bppe_default_config(); cases=append(cases,make('unconfigured','invalid',cfg,duration,struct()));
cfg=bppe_demo_config(); cases=append(cases,make('long_120s','stress',cfg,120,struct()));
end

function c=make(name,category,cfg,duration,options)
c=struct('name',name,'category',category,'cfg',cfg, ...
    'frames',bppe_synthetic(cfg,duration,options));
end

function [s,err,coded_err]=compare_runs(a,b)
ia=a.candidate_frame_index(:); ib=b.candidate_frame_index(:);
ka=zeros(0,2); kb=zeros(0,2);
if ~isempty(ia), ka=[[0;ia(1:end-1)],ia]; end
if ~isempty(ib), kb=[[0;ib(1:end-1)],ib]; end
[~,ma,mb]=intersect(ka,kb,'rows','stable');
s.frames=numel(a.accepted); s.reference_results=numel(ia); s.fixed_results=numel(ib);
s.matched_windows=numel(ma); s.unmatched_reference=numel(ia)-numel(ma); s.unmatched_fixed=numel(ib)-numel(mb);
s.validity_mismatches=0; s.reason_mismatches=0; s.sqi_max=0; s.feature_max=zeros(1,5);
err=zeros(0,2); coded_err=zeros(0,2);
for k=1:numel(ma)
    x=a.candidates(ma(k)); y=b.candidates(mb(k));
    s.validity_mismatches=s.validity_mismatches+(x.result_valid~=y.result_valid);
    s.reason_mismatches=s.reason_mismatches+(x.reason_flags~=y.reason_flags);
    s.sqi_max=max(s.sqi_max,abs(double(x.sqi)-double(y.sqi)));
    if all(isfinite([x.features y.features]))
        s.feature_max=max(s.feature_max,abs(x.features-y.features));
    end
    if x.result_valid && y.result_valid
        err(end+1,:)=[y.sbp-x.sbp,y.dbp-x.dbp]; %#ok<AGROW>
        coded_err(end+1,:)=double([y.sbp_uq9_7,y.dbp_uq9_7])-double([x.sbp_uq9_7,x.dbp_uq9_7]); %#ok<AGROW>
    end
end
delta=b.trace.filtered-a.trace.filtered;
delta=delta(isfinite(delta));
s.filtered_max=max(abs(delta)); s.filtered_rmse=sqrt(mean(delta.^2));
s.beat_event_mismatches=sum(a.trace.new_beat~=b.trace.new_beat,'all');
s.acceptance_mismatches=sum(a.accepted~=b.accepted);
s.reference_valid=sum([a.candidates.result_valid]); s.fixed_valid=sum([b.candidates.result_valid]);
s.valid_pairs=size(err,1); s.sbp_mae=mean_abs(err,1); s.dbp_mae=mean_abs(err,2);
s.sbp_max=max_abs(err,1); s.dbp_max=max_abs(err,2);
s.saturations=b.state.fx.math.saturation_count;
s.divzero=b.state.fx.math.divzero_count;
s.precision_faults=b.state.fx.math.precision_fault_count;
end

function a=append(a,b)
if isempty(a), a=b; else, a(end+1)=b; end
end
function x=mean_abs(e,j)
if isempty(e), x=NaN; else, x=mean(abs(e(:,j))); end
end
function x=max_abs(e,j)
if isempty(e), x=NaN; else, x=max(abs(e(:,j))); end
end
function x=rmse_value(e,j)
if isempty(e), x=NaN; else, x=sqrt(mean(e(:,j).^2)); end
end
function x=percentile_abs(e,j,p)
if isempty(e), x=NaN; else, sorted=sort(abs(e(:,j))); x=sorted(max(1,ceil(numel(sorted)*p/100))); end
end

function write_plot(report,demo,output_dir)
fig=figure('Visible','off','Color','w','Position',[100 100 1150 850]);
cleanup=onCleanup(@()close(fig));
subplot(2,2,1);
bar([report.summary.sbp_max report.summary.dbp_max]);
set(gca,'XTick',1:3,'XTickLabel',report.summary.profile);
set(gca,'YScale','log');
ylabel('Max added error (mmHg)'); title('Matched, jointly valid synthetic windows');
legend('SBP','DBP','Location','best'); grid on
subplot(2,2,2);
bar([report.summary.unmatched_reference report.summary.validity_mismatches report.summary.beat_event_mismatches]);
set(gca,'XTick',1:3,'XTickLabel',report.summary.profile);
ylabel('Count'); title('Behavior differences are reported separately');
legend('Unmatched reference windows','Validity disagreements','Beat-frame disagreements','Location','best'); grid on
subplot(2,2,3);
t=(0:numel(demo.reference.accepted)-1)/demo.reference.cfg.fs_hz;
plot(t,demo.fixed.trace.filtered-demo.reference.trace.filtered);
xlabel('Time (s)'); ylabel('Fixed - float (ADC code)');
title('Balanced filter error, synthetic 75 bpm'); grid on
subplot(2,2,4);
af=vertcat(demo.reference.results.features); bf=vertcat(demo.fixed.results.features);
plot(1:size(af,1),bf-af,'-o');
xlabel('Matched observation number'); ylabel('Feature difference (native units)');
title('Balanced feature errors, synthetic 75 bpm');
legend('Period (s)','Rise ratio','Width ratio','Area ratio','AC/DC ratio','Location','best'); grid on
set(findall(fig,'Type','axes'),'Color','w','XColor','k','YColor','k','FontSize',9);
set(findall(fig,'Type','text'),'Color','k');
set(findall(fig,'Type','legend'),'Color','w','TextColor','k');
exportgraphics(fig,fullfile(output_dir,'fixed_evaluation.png'),'Resolution',140);
end
