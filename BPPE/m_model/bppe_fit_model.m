function [model, report] = bppe_fit_model(features, reference_bp, cfg, provenance, lambda)
%BPPE_FIT_MODEL Standardized ridge regression for an already aligned dataset.
% Caller owns subject/session splits, pairing, calibration and test isolation.
% This reports TRAINING residuals only; does not establish clinical accuracy.
if nargin<5, lambda=1e-3; end
validateattributes(features,{'numeric'},{'2d','real','finite','ncols',5});
validateattributes(reference_bp,{'numeric'},{'2d','real','finite','ncols',2});
validateattributes(lambda,{'numeric'},{'scalar','finite','nonnegative'});
assert(size(features,1)==size(reference_bp,1) && size(features,1)>=7, ...
    'BPPE:Training', 'Need at least seven paired rows.');
assert(isstruct(provenance) && all(isfield(provenance,{'id','data_kind','split_id'})), ...
    'BPPE:Training', 'Explicit id, data_kind and split_id are required.');
assert(any(strcmp(provenance.data_kind,{'synthetic','recorded'})), ...
    'BPPE:Training', 'data_kind must be synthetic or recorded.');
assert(all(reference_bp(:,1)>reference_bp(:,2)), 'BPPE:Training', 'SBP must exceed DBP.');
model=cfg.model;
model.center=mean(features,1); model.scale=std(features,0,1);
model.scale(model.scale<1e-12)=1;
z=(features-model.center)./model.scale;
a=[ones(size(z,1),1),z];
if lambda==0
    assert(rank(a)==6,'BPPE:Training','Unregularized design is rank deficient.');
    model.beta=a\reference_bp;
else
    penalty=diag([0,ones(1,5)]);
    % Augmented least squares avoids explicitly squaring the condition number.
    model.beta=[a;sqrt(lambda)*penalty]\[reference_bp;zeros(6,2)];
end
model.feature_min=min(features,[],1); model.feature_max=max(features,[],1);
model.id=provenance.id; model.provenance=provenance;
model.profile=cfg.profile; model.feature_names=bppe_feature_names();
model.extractor=bppe_extractor_signature(cfg);
model.configured=true; model.calibrated=true;
model.demo_only=strcmp(provenance.data_kind,'synthetic');
residual=a*model.beta-reference_bp;
report=struct('evaluation','training_only','n',size(features,1),'lambda',lambda, ...
    'bias',mean(residual,1),'mae',mean(abs(residual),1), ...
    'rmse',sqrt(mean(residual.^2,1)),'max_abs',max(abs(residual),[],1), ...
    'design_rank',rank(a));
end
