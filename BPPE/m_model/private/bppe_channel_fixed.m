function [c,beat] = bppe_channel_fixed(c,x,ticks,cfg,fx)
% State, times, samples, features and coefficients are raw integer codes.
p=fx.profile; q=fx.math;
t=q.clip(q.mul(ticks,2^p.time_f),p.time_w,true,'sample_time');
xraw=q.mul(x,2^p.signal_f);
if ~c.initialized
    c.dc=xraw; c.initialized=true; c.previous_t=t;
end
delta=q.clip(xraw-c.dc,p.signal_w,true,'dc_delta');
increment=q.rescale(q.mul(fx.a,delta),p.coefficient_f,0);
c.dc=q.clip(q.add(c.dc,increment),p.signal_w,true,'dc_state');
ac=q.clip(xraw-c.dc,p.signal_w,true,'ac_signal');
delta=q.clip(ac-c.y,p.signal_w,true,'lowpass_delta');
increment=q.rescale(q.mul(fx.b,delta),p.coefficient_f,0);
c.y=q.clip(q.add(c.y,increment),p.signal_w,true,'filtered_state');
[c,beat]=bppe_beat_fixed(c,t,ticks,cfg,fx);
end
