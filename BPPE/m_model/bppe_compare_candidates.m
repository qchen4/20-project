function report = bppe_compare_candidates(reference, actual)
% Compare identical observation intervals, including invalid candidates.
% A nearest-time match can conceal changed beat/window boundaries.
a = reference.candidate_frame_index(:);
b = actual.candidate_frame_index(:);
ka = zeros(0,2); kb = zeros(0,2);
if ~isempty(a), ka = [[0;a(1:end-1)],a]; end
if ~isempty(b), kb = [[0;b(1:end-1)],b]; end
[~,ia,ib] = intersect(ka,kb,'rows','stable');
report = struct('matched',numel(ia),'unmatched_reference',numel(a)-numel(ia), ...
    'unmatched_actual',numel(b)-numel(ib),'validity_mismatches',0, ...
    'reason_mismatches',0,'valid_pairs',0,'bp_max',NaN);
for k = 1:numel(ia)
    x = reference.candidates(ia(k)); y = actual.candidates(ib(k));
    report.validity_mismatches = report.validity_mismatches + (x.result_valid ~= y.result_valid);
    report.reason_mismatches = report.reason_mismatches + (x.reason_flags ~= y.reason_flags);
    if x.result_valid && y.result_valid
        values = [x.sbp,x.dbp,y.sbp,y.dbp];
        assert(all(isfinite(values)),'BPPE:Comparison','Valid pressure must be finite.');
        delta = max(abs(values(1:2)-values(3:4)));
        if isnan(report.bp_max), report.bp_max = delta;
        else, report.bp_max = max(report.bp_max,delta); end
        report.valid_pairs = report.valid_pairs + 1;
    end
end
end
