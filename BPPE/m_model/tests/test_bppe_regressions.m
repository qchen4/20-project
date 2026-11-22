function tests = test_bppe_regressions
tests = functiontests(localfunctions);
end

function testStrictIntervalMatching(t)
r = struct('result_valid',true,'reason_flags',uint16(0),'sbp',120,'dbp',80);
a = struct('candidate_frame_index',[100,200],'candidates',[r,r]);
b = struct('candidate_frame_index',[101,200],'candidates',[r,r]);
c = bppe_compare_candidates(a,b);
verifyEqual(t,c.matched,0); % Both observation starts and ends must agree.
verifyEqual(t,c.unmatched_reference,2); verifyEqual(t,c.unmatched_actual,2);
verifyTrue(t,isnan(c.bp_max));
end

function testInvalidCandidatesAreNotDropped(t)
r = struct('result_valid',false,'reason_flags',uint16(1),'sbp',NaN,'dbp',NaN);
a = struct('candidate_frame_index',100,'candidates',r); b = a;
b.candidates.result_valid = true; b.candidates.sbp = 120; b.candidates.dbp = 80;
c = bppe_compare_candidates(a,b);
verifyEqual(t,c.matched,1); verifyEqual(t,c.validity_mismatches,1);
verifyEqual(t,c.valid_pairs,0); verifyTrue(t,isnan(c.bp_max));
end

function testNonfiniteValidPressureRejected(t)
r = struct('result_valid',true,'reason_flags',uint16(0),'sbp',NaN,'dbp',80);
a = struct('candidate_frame_index',100,'candidates',r);
verifyError(t,@()bppe_compare_candidates(a,a),'BPPE:Comparison');
end

function testWhiteNoiseThresholdCase(t)
cfg = bppe_demo_config();
clean = bppe_synthetic(cfg,32,struct('noise_std',0,'heart_rate_bpm',75));
frames = bppe_inject_noise(clean,cfg,'white',15,37);
a = bppe_run(frames,cfg); b = bppe_run(frames,cfg,true,bppe_fixed_profile());
c = bppe_compare_candidates(a,b);
verifyEqual(t,c.unmatched_reference+c.unmatched_actual,0);
verifyEqual(t,c.validity_mismatches,0); verifyGreaterThan(t,c.valid_pairs,0);
verifyLessThan(t,c.bp_max,0.1); % Case-specific guard, not a product accuracy target.
verifyFalse(t,b.state.fx.math.failed());
end

function testManifestRecordsSourceAndParameters(t)
fixture = t.applyFixture(matlab.unittest.fixtures.TemporaryFolderFixture);
parameters = struct('seed',37,'data_kind','synthetic');
manifest = bppe_write_manifest(fixture.Folder,'manifest-unit-test',parameters);
verifyGreaterThan(t,height(manifest),0);
verifyEqual(t,numel(unique(manifest.Path)),height(manifest));
verifyTrue(t,all(strlength(manifest.SHA256)==64));
verifyFalse(t,any(contains(manifest.Path,'artifacts/')));
verifyFalse(t,any(contains(manifest.Path,'intent.md')));
metadata = jsondecode(fileread(fullfile(fixture.Folder,'run_metadata.json')));
verifyEqual(t,metadata.parameters,parameters);
verifyEqual(t,metadata.source_files,height(manifest));
end

function testIntegerWindowTimingConstants(t)
cfg=bppe_default_config();timing=bppe_window_timing(cfg);
verifyTrue(t,timing.exact_ns_constants);
verifyEqual(t,[timing.warmup_ticks,timing.timeout_ticks,timing.initial_deadline_ticks],[2000,10000,12000]);
cfg.warmup_s=0.0025;cfg.timeout_s=0.0035;timing=bppe_window_timing(cfg);
verifyEqual(t,[timing.warmup_ticks,timing.timeout_ticks,timing.initial_deadline_ticks],[3,4,6]);
cfg.timeout_s=10.16;timing=bppe_window_timing(cfg);verifyEqual(t,timing.timeout_ticks,10160);
end

function testTimeoutAtExactTickBoundary(t)
cfg=bppe_demo_config();
for fixed=[false,true]
    if fixed,state=bppe_init_fixed(cfg);else,state=bppe_init(cfg);end
    state=bppe_control(state,'start');
    state.p.have_frame=true;state.p.last_seq=0;state.p.last_ts=18000;
    state.p.elapsed_ticks=18000;state.p.elapsed_s=18000*cfg.tick_period_ns*1e-9;
    state.p.window_start_s=8020*cfg.tick_period_ns*1e-9;state.p.window_deadline_ticks=18020;
    state.p.channel.initialized=true;state.p.channel.dc=2^20;state.p.channel.y=0;
    state.p.channel.previous_y=0;state.p.channel.previous_t=18;
    if fixed
        state.p.channel.dc=2^20*2^state.fx.profile.signal_f;
        state.p.channel.previous_t=18000*2^state.fx.profile.time_f;
    end
    frames=bppe_synthetic(cfg,0.02);frame=frames(1);frame.ppg=2^20;
    frame.frame_seq=1;frame.timestamp=18010;[first,state]=bppe_step_fixed_or_float(frame,state,fixed);
    verifyTrue(t,first.accepted);verifyEmpty(t,first.candidate);
    frame.frame_seq=2;frame.timestamp=18020;[second,state]=bppe_step_fixed_or_float(frame,state,fixed);
    verifyTrue(t,second.accepted);verifyTrue(t,second.published);verifyEqual(t,second.candidate.result_ts,uint32(18020));
    verifyEqual(t,state.p.window_deadline_ticks,28020);
end
end

function [out,state]=bppe_step_fixed_or_float(frame,state,fixed)
if fixed,[out,state]=bppe_step_fixed(frame,state);else,[out,state]=bppe_step_float(frame,state);end
end
