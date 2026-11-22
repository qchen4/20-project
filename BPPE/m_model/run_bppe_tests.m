function results = run_bppe_tests(output_dir)
%RUN_BPPE_TESTS Run real MATLAB tests and preserve machine-readable evidence.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','tests'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
results=runtests(fullfile(root,'tests'));
writetable(table(results),fullfile(output_dir,'test_results.csv'));
save(fullfile(output_dir,'test_results.mat'),'results');
bppe_write_manifest(output_dir,'unit-tests',struct('total',numel(results), ...
    'passed',sum([results.Passed]),'failed',sum([results.Failed]), ...
    'incomplete',sum([results.Incomplete])));
disp(results);
assert(all([results.Passed]),'BPPE:Tests','One or more tests failed or were incomplete.');
end
