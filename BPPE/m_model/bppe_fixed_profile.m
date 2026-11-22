function p = bppe_fixed_profile(name)
% Explicit formats for the experimental integer M1-MATLAB implementation.
if nargin==0, name='balanced'; end
p.name=name;
switch name
    case 'compact'
        p.signal_f=0; p.coefficient_f=8; p.feature_f=8; p.time_f=0; p.regression_f=8;
    case 'balanced'
        p.signal_f=8; p.coefficient_f=18; p.feature_f=16; p.time_f=8; p.regression_f=16;
    case 'wide'
        p.signal_f=10; p.coefficient_f=18; p.feature_f=18; p.time_f=10; p.regression_f=18;
    otherwise
        error('BPPE:FixedProfile','Unknown profile: %s',name);
end
p.signal_w=26+p.signal_f;
p.feature_w=4+p.feature_f;
p.time_w=48;
p.z_w=6+p.regression_f;
p.beta_w=10+p.regression_f;
p.accumulator_w=20+p.regression_f;
p.rounding='nearest, ties away from zero';
p.overflow='saturate and latch NUMERIC_FAULT until reset/configure';
end
