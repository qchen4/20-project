function result = bppe_measurement(p, cfg, sequence, timestamp)
f=bppe_flags(); reasons=uint16(0);
quality=zeros(1,cfg.channels);
for k=1:cfg.channels
    beats=p.channel(k).beats;
    if size(beats,1)<cfg.beats_per_result
        reasons=bitor(reasons,f.INSUFFICIENT_BEATS);
        continue
    end
    cv=std(beats(:,1),1)/mean(beats(:,1));
    amplitudes=beats(:,5);
    amplitude_ok=all(amplitudes>=cfg.min_ac_dc & amplitudes<=cfg.max_ac_dc);
    regularity=max(0,1-cv/cfg.max_period_cv);
    clean_fraction=cfg.beats_per_result/(cfg.beats_per_result+p.channel(k).rejected_beats);
    quality(k)=round(255*amplitude_ok*regularity*clean_fraction);
end
sqi=min(quality);
if sqi<cfg.sqi_threshold, reasons=bitor(reasons,f.LOW_SQI); end
features=nan(1,5);
if size(p.channel(cfg.primary_channel).beats,1)>=cfg.beats_per_result
    features=mean(p.channel(cfg.primary_channel).beats,1);
end
model_ok=cfg.model.configured && cfg.model.calibrated && ...
    (~cfg.model.demo_only || cfg.allow_demo_model);
if ~model_ok, reasons=bitor(reasons,f.MODEL_UNCONFIGURED); end
bp=[NaN NaN];
if model_ok && all(isfinite(features))
    if any(features<cfg.model.feature_min | features>cfg.model.feature_max)
        reasons=bitor(reasons,f.CONFIG_ERROR);
    else
        z=(features-cfg.model.center)./cfg.model.scale;
        bp=[1 z]*cfg.model.beta;
        if any(~isfinite(bp))
            reasons=bitor(reasons,f.NUMERIC_FAULT);
        elseif bp(1)<cfg.sbp_limits(1) || bp(1)>cfg.sbp_limits(2) || ...
                bp(2)<cfg.dbp_limits(1) || bp(2)>cfg.dbp_limits(2) || bp(1)<=bp(2)
            % Existing reason allocation lacks a range-specific bit.
            reasons=bitor(reasons,f.CONFIG_ERROR);
        end
    end
end
result.result_seq=uint16(mod(sequence,65536));
result.config_epoch=uint8(cfg.config_epoch);
result.result_ts=uint32(timestamp);
result.window_start_s=p.window_start_s;
result.window_end_s=p.elapsed_s;
result.result_valid=(reasons==0);
result.reason_flags=reasons;
result.sqi=uint8(sqi);
result.channel_sqi=uint8(quality);
result.features=features;
result.demo_only=cfg.model.demo_only;
result.model_id=cfg.model.id;
result.sbp=NaN; result.dbp=NaN;
result.sbp_uq9_7=uint16(0); result.dbp_uq9_7=uint16(0);
if result.result_valid
    result.sbp=bp(1); result.dbp=bp(2);
    result.sbp_uq9_7=uint16(round(bp(1)*128));
    result.dbp_uq9_7=uint16(round(bp(2)*128));
end
end
