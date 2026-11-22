function test_shadow_morphology()
% Offline helper contract only. No validation-set data or threshold fitting.
valid=logical([1 1 0 1 1 1 1 1]);cv=[0.1 0.2 0.1 0.20000000001 NaN Inf 0 -1];
assert(isequal(bppe_shadow_morphology(valid,cv),valid));
assert(isequal(bppe_shadow_morphology(valid,cv,false),valid));
assert(isequal(bppe_shadow_morphology(valid,cv,true),logical([1 1 0 0 0 0 1 0])));
assert(isequal(bppe_shadow_morphology(valid',cv',true),logical([1 1 0 0 0 0 1 0])'));
assert(isempty(bppe_shadow_morphology(false(0,1),zeros(0,1),true)));
expect_input_error(@()bppe_shadow_morphology(valid,cv',true));
expect_input_error(@()bppe_shadow_morphology(double(valid),cv,true));
expect_input_error(@()bppe_shadow_morphology(valid,cv,1));
fprintf('SHADOW_HELPER_PASSED default_off inclusive_boundary nonfinite negative shape type\n');
end

function expect_input_error(action)
try
    action();
catch err
    assert(strcmp(err.identifier,'BPPE:ShadowInput'));
    return;
end
error('BPPE:MissingError','Invalid input was accepted.');
end
