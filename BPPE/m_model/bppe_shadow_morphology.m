function keep=bppe_shadow_morphology(baseline_valid,morphology_cv,enabled)
% EXPERIMENT ONLY. Default is exact pass-through of the existing valid mask.
% Fixed EXP-028 candidate; no runtime configuration or production call site.
if nargin<3,enabled=false;end
assert(islogical(baseline_valid) && isequal(size(baseline_valid),size(morphology_cv)) && ...
    isnumeric(morphology_cv) && isreal(morphology_cv),'BPPE:ShadowInput','Invalid shadow inputs.');
assert(islogical(enabled) && isscalar(enabled),'BPPE:ShadowInput','Enable must be scalar logical.');
keep=baseline_valid;
if enabled
    keep=baseline_valid & isfinite(morphology_cv) & morphology_cv>=0 & morphology_cv<=0.20;
end
end
