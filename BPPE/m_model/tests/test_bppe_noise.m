function tests=test_bppe_noise
tests=functiontests(localfunctions);
end
function testReproducibleAndTargetSNR(t)
cfg=bppe_demo_config(); clean=bppe_synthetic(cfg,8,struct('noise_std',0));
for kind={'white','colored','baseline','periodic_motion','impulsive'}
    [a,meta]=bppe_inject_noise(clean,cfg,kind{1},15,11);
    b=bppe_inject_noise(clean,cfg,kind{1},15,11);
    c=bppe_inject_noise(clean,cfg,kind{1},15,23);
    verifyEqual(t,a,b); verifyNotEqual(t,vertcat(a.ppg),vertcat(c.ppg));
    verifyLessThan(t,abs(meta.realized_snr_db-15),0.01);
    verifyEqual(t,[a.timestamp],[clean.timestamp]);
    verifyEqual(t,[a.frame_seq],[clean.frame_seq]);
end
end
function testClippingIsFlagged(t)
cfg=bppe_demo_config(); clean=bppe_synthetic(cfg,8,struct('noise_std',0));
[a,meta]=bppe_inject_noise(clean,cfg,'white',-60,11);
verifyGreaterThan(t,meta.clipped_samples,0);
verifyTrue(t,any([a.channel_saturated]));
verifyTrue(t,all([a.ppg]>=0 & [a.ppg]<=2^24-1));
end
function testUnsupportedNoiseRejected(t)
cfg=bppe_demo_config(); clean=bppe_synthetic(cfg,1);
verifyError(t,@()bppe_inject_noise(clean,cfg,'unknown',15,11),'BPPE:Noise');
end
