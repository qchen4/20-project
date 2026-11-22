function tests = test_bppe
tests=functiontests(localfunctions);
end

function testDefaultModelCannotPublishValidBP(testCase)
cfg=bppe_default_config(); frames=bppe_synthetic(cfg,16);
r=bppe_run(frames,cfg); f=bppe_flags();
verifyNotEmpty(testCase,r.results);
verifyFalse(testCase,any([r.results.result_valid]));
verifyTrue(testCase,all(bitand([r.results.reason_flags],f.MODEL_UNCONFIGURED)~=0));
verifyTrue(testCase,all(isnan([r.results.sbp])));
end

function testCleanSyntheticDemo(testCase)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,20);
r=bppe_run(frames,cfg);
verifyGreaterThanOrEqual(testCase,numel(r.results),3);
verifyTrue(testCase,all(r.accepted));
verifyTrue(testCase,all([r.results.result_valid]));
verifyTrue(testCase,all([r.results.demo_only]));
features=vertcat(r.results.features);
verifyLessThan(testCase,max(abs(features(:,1)-0.8)),0.02);
verifyLessThanOrEqual(testCase,max(abs(double([r.results.sbp_uq9_7])/128-[r.results.sbp])),1/256);
end

function testDemoRequiresExplicitOptIn(testCase)
cfg=bppe_demo_config(); cfg.allow_demo_model=false;
r=bppe_run(bppe_synthetic(cfg,12),cfg);
verifyFalse(testCase,any([r.results.result_valid]));
end

function testAllChannelModes(testCase)
for channels=1:3
    cfg=bppe_default_config(); cfg.channels=channels; cfg=bppe_demo_config(cfg);
    r=bppe_run(bppe_synthetic(cfg,12),cfg);
    verifyNotEmpty(testCase,r.results);
    verifyTrue(testCase,all([r.results.result_valid]));
    verifySize(testCase,r.trace.filtered,[1200 channels]);
end
end

function testCounterWrapMatchesUnwrapped(testCase)
cfg=bppe_demo_config();
a=bppe_run(bppe_synthetic(cfg,12,struct('noise_std',0)),cfg);
b=bppe_run(bppe_synthetic(cfg,12,struct('noise_std',0, ...
    'start_tick',2^32-500,'start_seq',65500)),cfg);
verifyEqual(testCase,vertcat(a.results.features),vertcat(b.results.features),'AbsTol',1e-12);
verifyTrue(testCase,all(b.accepted));
end

function testGapRejectsAndRecovers(testCase)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,20); frames(401)=[];
r=bppe_run(frames,cfg); f=bppe_flags();
verifyEqual(testCase,r.fault_flags(401),f.SAMPLE_GAP);
verifyFalse(testCase,r.accepted(401));
verifyTrue(testCase,any([r.results.result_valid]));
end

function testTimestampFault(testCase)
cfg=bppe_default_config(); frames=bppe_synthetic(cfg,1);
frames(4).timestamp=frames(3).timestamp;
r=bppe_run(frames,cfg); f=bppe_flags();
verifyEqual(testCase,r.fault_flags(4),f.TIMESTAMP_ERROR);
end

function testSaturationAndInvalidMask(testCase)
cfg=bppe_default_config(); frames=bppe_synthetic(cfg,1);
frames(3).channel_saturated=true; frames(7).channel_valid=false;
r=bppe_run(frames,cfg); f=bppe_flags();
verifyEqual(testCase,r.fault_flags(3),f.ADC_SATURATED);
verifyEqual(testCase,r.fault_flags(7),f.SAMPLE_GAP);
end

function testGainAndProfileTransition(testCase)
cfg=bppe_default_config(); frames=bppe_synthetic(cfg,1);
frames(5).gain_transition=true; frames(10).gain_profile_id=1;
r=bppe_run(frames,cfg); f=bppe_flags();
verifyEqual(testCase,r.fault_flags(5),f.LOW_SQI);
verifyEqual(testCase,r.fault_flags(10),f.LOW_SQI);
end

function testChannelSkew(testCase)
cfg=bppe_default_config(); cfg.channels=2;
frames=bppe_synthetic(cfg,1); frames(4).timestamp(2)=frames(4).timestamp(2)+10;
r=bppe_run(frames,cfg); f=bppe_flags();
verifyEqual(testCase,r.fault_flags(4),f.TIMESTAMP_ERROR);
end

function testFlatSignalTimesOut(testCase)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,15,struct('amplitude',0,'noise_std',0));
r=bppe_run(frames,cfg); f=bppe_flags();
verifyNotEmpty(testCase,r.results);
verifyFalse(testCase,any([r.results.result_valid]));
verifyNotEqual(testCase,bitand(r.results(1).reason_flags,f.INSUFFICIENT_BEATS),uint16(0));
end

function testLowAmplitudeRejected(testCase)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,15,struct('amplitude',100,'noise_std',0));
r=bppe_run(frames,cfg); f=bppe_flags();
verifyNotEmpty(testCase,r.results);
verifyFalse(testCase,any([r.results.result_valid]));
verifyNotEqual(testCase,bitand(r.results(1).reason_flags,f.LOW_SQI),uint16(0));
end

function testUnreadSnapshotStable(testCase)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,20);
a=bppe_run(frames,cfg,true); b=bppe_run(frames,cfg,false); f=bppe_flags();
verifyEqual(testCase,numel(b.results),1);
verifyEqual(testCase,b.state.snapshot,a.results(1));
verifyGreaterThan(testCase,numel(b.candidates),1);
verifyNotEqual(testCase,bitand(b.state.fault_flags,f.RESULT_OVERFLOW),uint16(0));
s=bppe_control(b.state,'ack');
verifyFalse(testCase,s.pending);
verifyEqual(testCase,s.snapshot,b.state.snapshot);
end

function testLifecycleAndConfigLock(testCase)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,1);
s=bppe_init(cfg); [out,s]=bppe_step_float(frames(1),s);
verifyFalse(testCase,out.accepted);
s=bppe_control(s,'start'); [out,s]=bppe_step_float(frames(1),s);
verifyTrue(testCase,out.accepted);
verifyError(testCase,@() bppe_control(s,'start'),'BPPE:Busy');
changed=cfg; changed.config_epoch=1;
[out,s2]=bppe_step_float(frames(2),s,changed); f=bppe_flags();
verifyEqual(testCase,out.fault_flags,f.CONFIG_ERROR);
verifyEqual(testCase,s2.p,s.p);
verifyError(testCase,@() bppe_control(s,'configure',changed),'BPPE:Busy');
s=bppe_control(s,'abort'); verifyFalse(testCase,s.running);
s=bppe_control(s,'reset'); verifyEqual(testCase,s.fault_flags,uint16(0));
verifyFalse(testCase,s.pending); verifyFalse(testCase,s.p.have_frame);
end

function testMalformedInputNoNumericLeak(testCase)
cfg=bppe_default_config(); frames=bppe_synthetic(cfg,1);
frames(2).ppg=NaN; frames(4).ppg=2^24;
r=bppe_run(frames,cfg); f=bppe_flags();
verifyEqual(testCase,r.fault_flags([2 4]),repmat(f.CONFIG_ERROR,2,1));
end

function testColumnVectors(testCase)
cfg=bppe_default_config(); cfg.channels=3; cfg=bppe_demo_config(cfg);
a=bppe_synthetic(cfg,12); b=a;
for i=1:numel(b)
    b(i).ppg=b(i).ppg'; b(i).timestamp=b(i).timestamp';
    b(i).channel_valid=b(i).channel_valid'; b(i).channel_saturated=b(i).channel_saturated';
end
x=bppe_run(a,cfg); y=bppe_run(b,cfg);
verifyEqual(testCase,x.results,y.results);
end

function testCausalPrefix(testCase)
cfg=bppe_demo_config(); a=bppe_synthetic(cfg,12); b=a;
for i=801:numel(b), b(i).ppg=0; end
x=bppe_run(a,cfg); y=bppe_run(b,cfg);
verifyEqual(testCase,x.trace.filtered(1:800,:),y.trace.filtered(1:800,:));
verifyEqual(testCase,x.trace.new_beat(1:800,:),y.trace.new_beat(1:800,:));
end

function testFitAndSchemaGuard(testCase)
cfg=bppe_default_config(); stream=RandStream('mt19937ar','Seed',42);
x=randn(stream,80,5); beta=[120 80;1 .5;2 1;1 .2;-.2 .4;.1 -.1];
y=[ones(80,1),x]*beta;
provenance=struct('id','fit-unit-test','data_kind','synthetic','split_id','unit-only');
[model,report]=bppe_fit_model(x,y,cfg,provenance,0);
verifyLessThan(testCase,max(report.max_abs),1e-10);
verifyTrue(testCase,model.demo_only);
cfg.model=model; cfg.fs_hz=200;
verifyError(testCase,@() bppe_init(cfg),'BPPE:Config');
end

function testRegressionRangeRejected(testCase)
cfg=bppe_demo_config(); cfg.model.beta=zeros(6,2); cfg.model.beta(1,:)=[80 120];
r=bppe_run(bppe_synthetic(cfg,12),cfg); f=bppe_flags();
verifyFalse(testCase,any([r.results.result_valid]));
verifyNotEqual(testCase,bitand(r.results(1).reason_flags,f.CONFIG_ERROR),uint16(0));
end

function testMemoryBound(testCase)
cfg=bppe_demo_config(); r=bppe_run(bppe_synthetic(cfg,60),cfg);
verifyLessThanOrEqual(testCase,numel(r.state.p.channel.cycle_t),ceil(2*cfg.fs_hz*cfg.max_period_s)+4);
verifyLessThanOrEqual(testCase,size(r.state.p.channel.beats,1),cfg.beats_per_result);
end

function testSecondaryChannelQualityGate(testCase)
cfg=bppe_default_config(); cfg.channels=2; cfg=bppe_demo_config(cfg);
frames=bppe_synthetic(cfg,15,struct('noise_std',0));
for i=1:numel(frames), frames(i).ppg(2)=2^20; end
r=bppe_run(frames,cfg);
verifyNotEmpty(testCase,r.results);
verifyFalse(testCase,any([r.results.result_valid]));
end

function testFeatureEnvelopeGate(testCase)
cfg=bppe_demo_config(); cfg.model.feature_max(1)=0.5;
r=bppe_run(bppe_synthetic(cfg,12),cfg); f=bppe_flags();
verifyFalse(testCase,any([r.results.result_valid]));
verifyNotEqual(testCase,bitand(r.results(1).reason_flags,f.CONFIG_ERROR),uint16(0));
end

function testArithmeticNonfiniteRejected(testCase)
cfg=bppe_demo_config(); cfg.model.beta=zeros(6,2);
cfg.model.beta(2,:)=[realmax realmax]; cfg.model.scale(1)=1e-300;
r=bppe_run(bppe_synthetic(cfg,12),cfg); f=bppe_flags();
verifyFalse(testCase,any([r.results.result_valid]));
verifyNotEqual(testCase,bitand(r.results(1).reason_flags,f.NUMERIC_FAULT),uint16(0));
end

function testEpochAndResultSequence(testCase)
cfg=bppe_demo_config(); cfg.config_epoch=23;
r=bppe_run(bppe_synthetic(cfg,16),cfg);
verifyEqual(testCase,[r.results.config_epoch],repmat(uint8(23),1,numel(r.results)));
verifyEqual(testCase,[r.results.result_seq],uint16(1:numel(r.results)));
end

function testRidgeAndTrainingInputGuard(testCase)
cfg=bppe_default_config(); x=repmat([.8 .2 .3 .2 .04],10,1); y=repmat([120 80],10,1);
p=struct('id','constant-fit-test','data_kind','synthetic','split_id','unit');
[model,report]=bppe_fit_model(x,y,cfg,p,0.01);
verifyTrue(testCase,all(isfinite(model.beta(:))));
verifyLessThan(testCase,max(report.mae),1e-10);
verifyError(testCase,@() bppe_fit_model(x,y,cfg,p,0),'BPPE:Training');
end
