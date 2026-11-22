function report = validate_bppe(output_dir)
% One local validation entry point; preserves evidence outside source files.
root = fileparts(mfilename('fullpath'));
if nargin<1, output_dir = fullfile(root,'artifacts','validation'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
report.tests = run_bppe_tests(fullfile(output_dir,'tests'));
files = dir(fullfile(root,'**','*.m'));
findings = 0;
for k = 1:numel(files)
    path = fullfile(files(k).folder,files(k).name);
    if contains(path,[filesep 'artifacts' filesep]), continue; end
    messages = checkcode(path,'-id');
    for j = 1:numel(messages)
        fprintf('%s:%d [%s] %s\n',path,messages(j).line,messages(j).id,messages(j).message);
    end
    findings = findings+numel(messages);
end
report.analyzer_findings = findings;
report.regressions = bppe_regression_cases();
writetable(report.regressions.detail,fullfile(output_dir,'regression_cases.csv'));
bppe_write_manifest(output_dir,'local-validation',struct( ...
    'tests',numel(report.tests),'analyzer_findings',findings, ...
    'engineering_passed',report.regressions.engineering_passed, ...
    'known_quality_gap',report.regressions.known_quality_gap));
save(fullfile(output_dir,'validation.mat'),'report');
disp(report.regressions.detail);
if report.regressions.known_quality_gap
    fprintf('KNOWN GAP: strong impulse noise still produces inaccurate accepted periods.\n');
end
assert(findings==0,'BPPE:Analyzer','Code Analyzer reported findings.');
assert(report.regressions.engineering_passed,'BPPE:Regression','Engineering regression failed.');
fprintf('BPPE validation: %d tests passed; %d analyzer findings; quality gap=%d.\n', ...
    numel(report.tests),findings,report.regressions.known_quality_gap);
end
