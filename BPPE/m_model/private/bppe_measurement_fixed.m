function r = bppe_measurement_fixed(state_p,cfg,sequence,timestamp,fx)
p=fx.profile; q=fx.math; f=bppe_flags(); reasons=uint16(0);
one=2^p.feature_f; quality=zeros(1,cfg.channels);
for k=1:cfg.channels
    beats=state_p.channel(k).beats; n=size(beats,1);
    if n<cfg.beats_per_result
        reasons=bitor(reasons,f.INSUFFICIENT_BEATS); continue
    end
    avg=q.divide(sum(beats(:,1)),n);
    variance_sum=0;
    for j=1:n
        d=beats(j,1)-avg;
        variance_sum=q.add(variance_sum,q.mul(d,d));
    end
    deviation=q.sqrt_nearest(q.divide(variance_sum,n));
    cv=q.clip(q.divide(q.mul(deviation,one),avg),p.feature_w,true,'period_cv');
    amplitude_ok=all(beats(:,5)>=fx.min_amplitude & beats(:,5)<=fx.max_amplitude);
    regularity=max(0,one-q.divide(q.mul(cv,one),fx.max_cv));
    clean=q.divide(cfg.beats_per_result*one,cfg.beats_per_result+state_p.channel(k).rejected_beats);
    quality(k)=q.divide(q.mul(q.mul(255*double(amplitude_ok),regularity),clean),one^2);
end
sqi=min(quality);
if sqi<cfg.sqi_threshold, reasons=bitor(reasons,f.LOW_SQI); end
features=nan(1,5); feature_raw=zeros(1,5);
has_features=size(state_p.channel(cfg.primary_channel).beats,1)>=cfg.beats_per_result;
if has_features
    sums=sum(state_p.channel(cfg.primary_channel).beats,1);
    for j=1:5, feature_raw(j)=q.divide(sums(j),cfg.beats_per_result); end
    feature_raw=q.clip(feature_raw,p.feature_w,true,'mean_feature');
    features=feature_raw/one; % Reporting only; never fed back to arithmetic.
end
model_ok=cfg.model.configured && cfg.model.calibrated && ...
    (~cfg.model.demo_only || cfg.allow_demo_model);
if ~model_ok, reasons=bitor(reasons,f.MODEL_UNCONFIGURED); end
bp_raw=zeros(1,2);
if model_ok && has_features
    if any(feature_raw<fx.feature_min | feature_raw>fx.feature_max)
        reasons=bitor(reasons,f.CONFIG_ERROR);
    else
        z=zeros(1,5);
        for j=1:5
            numerator=q.mul(feature_raw(j)-fx.center(j),2^p.regression_f);
            z(j)=q.clip(q.divide(numerator,fx.scale(j)),p.z_w,true,'standardized_feature');
        end
        for output=1:2
            acc=fx.beta(1,output);
            for j=1:5
                product=q.mul(z(j),fx.beta(j+1,output));
                term=q.rescale(product,2*p.regression_f,p.regression_f);
                acc=q.clip(q.add(acc,term),p.accumulator_w,true,'regression_accumulator');
            end
            bp_raw(output)=acc;
        end
        if any(bp_raw<fx.bp_min | bp_raw>fx.bp_max) || bp_raw(1)<=bp_raw(2)
            reasons=bitor(reasons,f.CONFIG_ERROR);
        end
    end
end
codes=q.clip(q.rescale(bp_raw,p.regression_f,7),16,false,'output_code');
if q.failed(), reasons=bitor(reasons,f.NUMERIC_FAULT); end
if q.divzero_count>0, reasons=bitor(reasons,f.DIVZERO); end
r.result_seq=uint16(mod(sequence,65536)); r.config_epoch=uint8(cfg.config_epoch);
r.result_ts=uint32(timestamp); r.window_start_s=state_p.window_start_s;
r.window_end_s=state_p.elapsed_s; r.result_valid=(reasons==0);
r.reason_flags=reasons; r.sqi=uint8(sqi); r.channel_sqi=uint8(quality);
r.features=features; r.demo_only=cfg.model.demo_only; r.model_id=cfg.model.id;
r.sbp=NaN; r.dbp=NaN; r.sbp_uq9_7=uint16(0); r.dbp_uq9_7=uint16(0);
if r.result_valid
    r.sbp=bp_raw(1)/2^p.regression_f; r.dbp=bp_raw(2)/2^p.regression_f;
    r.sbp_uq9_7=uint16(codes(1)); r.dbp_uq9_7=uint16(codes(2));
end
end
