function [c,beat] = bppe_beat_fixed(c,t,ticks,cfg,fx)
% Existing downstream kernel extracted without changing operation order.
p=fx.profile; q=fx.math; beat=[];
if ticks*cfg.tick_period_ns < round(cfg.warmup_s*1e9)
    c.previous_y=c.y; c.previous_t=t; return
end
crossing=c.previous_y<=0 && c.y>0;
if crossing
    offset=q.divide(q.mul(-c.previous_y,t-c.previous_t),c.y-c.previous_y);
    tc=q.clip(c.previous_t+offset,p.time_w,true,'crossing_time');
    if c.tracking
        tt=[c.cycle_t,tc]; yy=[c.cycle_y,0];
        period=tc-tt(1); [peak,ip]=max(yy);
        amplitude=q.clip(max(yy)-min(yy),p.signal_w,true,'beat_amplitude');
        sec_n=q.mul(period,cfg.tick_period_ns);
        sec_n=q.rescale(sec_n,p.time_f,p.feature_f);
        period_s=q.clip(q.divide(sec_n,1e9),p.feature_w,true,'period_feature');
        if period>0 && period_s>=fx.min_period && period_s<=fx.max_period && peak>0 && c.dc>0
            rise=q.divide(q.mul(tt(ip)-tt(1),2^p.feature_f),period);
            width_sum=0; area_sum=0;
            norm=zeros(size(yy)); mask=(2*yy>=peak);
            for j=1:numel(yy)
                norm(j)=q.divide(q.mul(max(yy(j),0),2^p.feature_f),peak);
            end
            for j=1:numel(tt)-1
                dt=tt(j+1)-tt(j);
                width_sum=q.add(width_sum,q.mul(dt,double(mask(j))+double(mask(j+1))));
                area_sum=q.add(area_sum,q.mul(dt,norm(j)+norm(j+1)));
            end
            width=q.divide(q.mul(width_sum,2^p.feature_f),2*period);
            area=q.divide(area_sum,2*period);
            ratio=q.divide(q.mul(amplitude,2^p.feature_f),c.dc);
            beat=q.clip([period_s,rise,width,area,ratio],p.feature_w,true,'beat_feature');
            c.beats(end+1,:)=beat; c.beat_times(end+1)=tc;
            if size(c.beats,1)>cfg.beats_per_result
                c.beats(1,:)=[]; c.beat_times(1)=[];
            end
        else
            c.rejected_beats=c.rejected_beats+1;
        end
    end
    c.tracking=true; c.cycle_t=tc; c.cycle_y=0;
end
if c.tracking
    c.cycle_t(end+1)=t; c.cycle_y(end+1)=c.y;
    % Constant max-period threshold converted by the host, not a DSP divide.
    max_period_ticks=round(cfg.max_period_s*1e9/cfg.tick_period_ns*2^p.time_f);
    if t-c.cycle_t(1)>max_period_ticks || ...
            numel(c.cycle_t)>ceil(2*cfg.fs_hz*cfg.max_period_s)+4
        c.tracking=false; c.cycle_t=[]; c.cycle_y=[];
        c.rejected_beats=c.rejected_beats+1;
    end
end
c.previous_y=c.y; c.previous_t=t;
end
