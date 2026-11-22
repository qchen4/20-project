function report=evaluate_bppe_noise(output_dir)
% Monte Carlo synthetic robustness study inspired by ADI quality/coverage framing.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','noise'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
cfg=bppe_demo_config(); duration=32; bpm=75;
clean=bppe_synthetic(cfg,duration,struct('noise_std',0,'heart_rate_bpm',bpm));
baseline=bppe_run(clean,cfg,true,bppe_fixed_profile());
types={'white','colored','baseline','periodic_motion','impulsive'};
levels=[30 20 15 6 0]; seeds=[11 23 37 51 79];
rows=struct([]); examples=struct([]); count=0;
for k=1:numel(types)
    for level=levels
        for seed=seeds
            [frames,meta]=bppe_inject_noise(clean,cfg,types{k},level,seed);
            fixed=bppe_run(frames,cfg,true,bppe_fixed_profile());
            floating=bppe_run(frames,cfg);
            r=metrics(fixed,baseline,cfg,bpm);
            r.kind=types{k}; r.target_snr_db=level; r.seed=seed;
            r.realized_snr_db=meta.realized_snr_db(1); r.clipped_samples=meta.clipped_samples;
            r.estimated_psnr_db=spectral_psnr(vertcat(frames.ppg),cfg.fs_hz,bpm/60);
            [r.quant_matched,r.quant_unmatched,r.quant_validity_mismatch,r.quant_valid_pairs,r.quant_bp_max]=quant_compare(floating,fixed);
            rows=append(rows,r); count=count+1;
            if level==6 && seed==seeds(1)
                ex=struct('kind',types{k},'input',vertcat(frames.ppg), ...
                    'filtered',fixed.trace.filtered,'beat',fixed.trace.new_beat, ...
                    'results',fixed.results,'frame_indices',fixed.candidate_frame_index);
                examples=append(examples,ex);
            end
        end
        fprintf('Noise sweep: %d/125 runs (%s, %g dB).\n',count,types{k},level);
    end
end
detail=struct2table(rows); groups=struct([]);
for k=1:numel(types)
    for level=levels
        d=detail(strcmp(detail.kind,types{k}) & detail.target_snr_db==level,:);
        g=struct('kind',types{k},'snr_db',level,'repeats',height(d), ...
            'coverage_mean',mean(d.coverage_pct),'coverage_min',min(d.coverage_pct), ...
            'coverage_max',max(d.coverage_pct),'valid_reports',sum(d.valid_reports), ...
            'total_reports',sum(d.total_reports),'hr_mae',safe_ratio(sum(d.hr_abs_error_sum),sum(d.valid_reports)), ...
            'hr_bad_pct',100*safe_ratio(sum(d.hr_bad_count),sum(d.valid_reports)), ...
            'missed_beat_pct',100*sum(d.missed_beats)/sum(d.clean_beats), ...
            'extra_beat_count',sum(d.extra_beats),'demo_bp_mae',mean(d.demo_bp_mae,'omitnan'), ...
            'estimated_psnr_mean',mean(d.estimated_psnr_db), ...
            'numeric_saturations',sum(d.saturations),'validity_mismatches',sum(d.quant_validity_mismatch));
        groups=append(groups,g);
    end
end
summary=struct2table(groups);
report=struct('summary',summary,'detail',detail,'config',cfg,'duration_s',duration, ...
    'true_bpm',bpm,'seeds',seeds,'snr_definition','20log10(clean AC RMS / added RMS)', ...
    'coverage_definition','one-to-one valid report matching to clean report times, tolerance half median clean interval', ...
    'source','synthetic; no real BP reference','matlab_version',version, ...
    'reference_url','https://www.analog.com/en/resources/app-notes/maxim-integrated-ppg-algorithms-specifications.html');
writetable(detail,fullfile(output_dir,'noise_runs.csv'));
writetable(summary,fullfile(output_dir,'noise_summary.csv'));
save(fullfile(output_dir,'noise_evaluation.mat'),'report','examples','baseline','clean');
bppe_write_manifest(output_dir,'noise-sweep',struct('seeds',seeds, ...
    'types',{types},'snr_db',levels,'duration_s',duration,'config',cfg, ...
    'data_kind','synthetic-demo'));
disp(summary);
end

function r=metrics(run,baseline,cfg,bpm)
all_results=run.results;
valid=all_results([all_results.result_valid]);
r.total_reports=numel(all_results); r.valid_reports=numel(valid);
if isempty(valid)
    r.hr_abs_error_sum=0; r.hr_mae=NaN; r.hr_bad_count=0; r.demo_bp_mae=NaN;
else
    features=vertcat(valid.features); err=abs(60./features(:,1)-bpm);
    r.hr_abs_error_sum=sum(err); r.hr_mae=mean(err); r.hr_bad_count=sum(err>5);
    ref=baseline.results([baseline.results.result_valid]);
    r.demo_bp_mae=mean(abs([valid.sbp]-median([ref.sbp])));
end
% Match reporting opportunities with a half-interval timing tolerance.
% Binning at clean end times spuriously penalizes small timing jitter.
reference_index=baseline.candidate_frame_index;
valid_index=run.candidate_frame_index([run.candidates.result_valid]);
tolerance=floor(median(diff(reference_index))/2);
covered=match_events(reference_index,valid_index,tolerance);
r.clean_windows=numel(reference_index); r.covered_windows=covered;
r.unmatched_valid_reports=numel(valid_index)-covered;
r.coverage_pct=100*covered/r.clean_windows;
ref=find(baseline.trace.new_beat(:,cfg.primary_channel));
got=find(run.trace.new_beat(:,cfg.primary_channel));
% One-to-one matching against clean filtered cycles; no arbitrary time shift.
tolerance=round(0.15*cfg.fs_hz);
matched=match_events(ref,got,tolerance);
r.clean_beats=numel(ref); r.missed_beats=numel(ref)-matched; r.extra_beats=numel(got)-matched;
r.saturations=run.state.fx.math.saturation_count;
r.divzero=run.state.fx.math.divzero_count;
r.precision_faults=run.state.fx.math.precision_fault_count;
end

function matched=match_events(ref,got,tolerance)
a=1; b=1; matched=0;
while a<=numel(ref) && b<=numel(got)
    if abs(ref(a)-got(b))<=tolerance, matched=matched+1; a=a+1; b=b+1;
    elseif got(b)<ref(a)-tolerance, b=b+1;
    else, a=a+1;
    end
end
end

function [matched,unmatched,mismatches,valid_pairs,max_error]=quant_compare(a,b)
ia=a.candidate_frame_index(:); ib=b.candidate_frame_index(:);
ka=zeros(0,2); kb=zeros(0,2);
if ~isempty(ia), ka=[[0;ia(1:end-1)],ia]; end
if ~isempty(ib), kb=[[0;ib(1:end-1)],ib]; end
[~,ma,mb]=intersect(ka,kb,'rows','stable');
matched=numel(ma); unmatched=numel(ia)+numel(ib)-2*matched;
mismatches=0; valid_pairs=0; max_error=NaN;
for k=1:matched
    x=a.candidates(ma(k)); y=b.candidates(mb(k));
    mismatches=mismatches+(x.result_valid~=y.result_valid);
    if x.result_valid && y.result_valid
        e=max(abs([x.sbp-y.sbp,x.dbp-y.dbp]));
        if isnan(max_error), max_error=e; else, max_error=max(max_error,e); end
        valid_pairs=valid_pairs+1;
    end
end
end

function value=spectral_psnr(x,fs,fundamental)
% Explicit estimator, not an implementation of the unpublished vendor tool.
x=x(:,1)-mean(x(:,1)); n=numel(x);
window=0.5-0.5*cos(2*pi*(0:n-1)'/(n-1));
power=abs(fft(x.*window)).^2;
freq=(0:n-1)'*fs/n; valid=freq>=0.1 & freq<=fs/2;
harmonic=false(n,1); halfwidth=max(2*fs/n,0.08);
for h=1:3, harmonic=harmonic | abs(freq-h*fundamental)<=halfwidth; end
value=10*log10(sum(power(valid&harmonic))/max(sum(power(valid&~harmonic)),realmin));
end
function a=append(a,b)
if isempty(a), a=b; else, a(end+1)=b; end
end
function v=safe_ratio(a,b)
if b==0, v=NaN; else, v=a/b; end
end
