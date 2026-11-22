function tests=test_bppe_fixed
tests=functiontests(localfunctions);
end

function testIntegerRoundingAndSaturation(t)
q=bppe_integer_math();
verifyEqual(t,q.divide(5,2),3); verifyEqual(t,q.divide(-5,2),-3);
verifyEqual(t,q.divide(7,3),2); verifyEqual(t,q.divide(-8,3),-3);
verifyEqual(t,q.divide(2^53-1,2),2^52);
verifyEqual(t,q.divide(2^53-2,2^53-1),1);
verifyEqual(t,q.clip([-129 128],8,true,'test'),[-128 127]);
verifyEqual(t,q.saturation_count,2);
q.divide(1,0); verifyEqual(t,q.divzero_count,1);
q.mul(2^40,2^20); verifyEqual(t,q.precision_fault_count,1);
end

function testIntegerSqrt(t)
q=bppe_integer_math();
for n=[0:1000,2^32-1,2^40+7]
    verifyEqual(t,q.sqrt_nearest(n),round(sqrt(n)));
end
end

function testCleanAgreement(t)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,16);
a=bppe_run(frames,cfg); b=bppe_run(frames,cfg,true,bppe_fixed_profile());
verifyEqual(t,[a.results.result_valid],[b.results.result_valid]);
verifyEqual(t,[a.results.result_ts],[b.results.result_ts]);
verifyLessThan(t,max(abs([a.results.sbp]-[b.results.sbp])),0.1);
verifyFalse(t,b.state.fx.math.failed());
end

function testUnconfiguredGate(t)
cfg=bppe_default_config(); b=bppe_run(bppe_synthetic(cfg,12),cfg,true,bppe_fixed_profile());
verifyNotEmpty(t,b.results); verifyFalse(t,any([b.results.result_valid]));
end

function testChannelsAndWrap(t)
cfg=bppe_default_config(); cfg.channels=3; cfg=bppe_demo_config(cfg);
a=bppe_run(bppe_synthetic(cfg,12),cfg,true,bppe_fixed_profile());
b=bppe_run(bppe_synthetic(cfg,12,struct('start_tick',2^32-100,'start_seq',65500)), ...
    cfg,true,bppe_fixed_profile());
verifyEqual(t,vertcat(a.results.features),vertcat(b.results.features));
verifyTrue(t,all([b.results.result_valid]));
end

function testFaultAndSnapshot(t)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,16);
a=bppe_run(frames,cfg,false,bppe_fixed_profile());
verifyEqual(t,numel(a.results),1); verifyGreaterThan(t,numel(a.candidates),1);
verifyEqual(t,a.state.snapshot,a.results(1));
f=bppe_flags(); verifyNotEqual(t,bitand(a.state.fault_flags,f.RESULT_OVERFLOW),uint16(0));
frames(200).channel_saturated=true;
b=bppe_run(frames,cfg,true,bppe_fixed_profile());
verifyEqual(t,b.fault_flags(200),f.ADC_SATURATED);
verifyTrue(t,any([b.results.result_valid]));
end

function testNumericFaultInvalidates(t)
cfg=bppe_demo_config(); cfg.model.beta(1,1)=1e5;
b=bppe_run(bppe_synthetic(cfg,12),cfg,true,bppe_fixed_profile()); f=bppe_flags();
verifyGreaterThan(t,b.state.fx.math.saturation_count,0);
verifyFalse(t,any([b.results.result_valid]));
verifyNotEqual(t,bitand(b.results(1).reason_flags,f.NUMERIC_FAULT),uint16(0));
end

function testScaleUnderflow(t)
cfg=bppe_demo_config(); cfg.model.scale(1)=1e-12;
b=bppe_run(bppe_synthetic(cfg,12),cfg,true,bppe_fixed_profile()); f=bppe_flags();
verifyFalse(t,any([b.results.result_valid]));
verifyNotEqual(t,bitand(b.results(1).reason_flags,f.DIVZERO),uint16(0));
end

function testResetRetainsFixedMode(t)
cfg=bppe_demo_config(); s=bppe_init_fixed(cfg);
s.fx.math.divide(1,0); verifyTrue(t,s.fx.math.failed());
s=bppe_control(s,'reset');
verifyTrue(t,isfield(s,'fx')); verifyFalse(t,s.fx.math.failed());
verifyFalse(t,s.running); verifyEqual(t,s.p.elapsed_ticks,0);
end

function testMaxADCAndFlat(t)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,15,struct('baseline',2^24-1,'amplitude',0,'noise_std',0));
b=bppe_run(frames,cfg,true,bppe_fixed_profile());
verifyFalse(t,b.state.fx.math.failed()); verifyFalse(t,any([b.results.result_valid]));
verifyTrue(t,all(b.trace.filtered==0));
end

function testDeterminism(t)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,12);
a=bppe_run(frames,cfg,true,bppe_fixed_profile());
b=bppe_run(frames,cfg,true,bppe_fixed_profile());
verifyEqual(t,a.results,b.results); verifyEqual(t,a.trace,b.trace);
end

function testFullRangeFaultAndResetRecovery(t)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,12);
for i=1:numel(frames), frames(i).ppg=double(mod(floor((i-1)/50),2))*(2^24-1); end
b=bppe_run(frames,cfg,true,bppe_fixed_profile());
verifyTrue(t,b.state.fx.math.failed()); verifyFalse(t,any([b.results.result_valid]));
s=bppe_control(b.state,'reset'); verifyFalse(t,s.fx.math.failed());
s=bppe_control(s,'start'); clean=bppe_synthetic(cfg,12); published=false;
for i=1:numel(clean)
    [out,s]=bppe_step_fixed(clean(i),s);
    if out.published
        verifyTrue(t,out.snapshot.result_valid); published=true;
        s=bppe_control(s,'ack');
    end
end
verifyTrue(t,published);
end

function testCompactThresholdBiasIsObservable(t)
cfg=bppe_demo_config(); frames=bppe_synthetic(cfg,12,struct('amplitude',2250,'noise_std',0));
a=bppe_run(frames,cfg); b=bppe_run(frames,cfg,true,bppe_fixed_profile('compact'));
verifyFalse(t,any([a.results.result_valid]));
verifyTrue(t,any([b.results.result_valid])); % Documents why compact is NOT selected.
end
