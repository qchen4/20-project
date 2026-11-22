function run = demo_bppe(output_dir)
%DEMO_BPPE Run and export SYNTHETIC demonstration (base MATLAB only).
if nargin<1
    output_dir=fullfile(fileparts(mfilename('fullpath')),'artifacts','demo');
end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
cfg=bppe_demo_config();
[frames,meta]=bppe_synthetic(cfg,24);
run=bppe_run(frames,cfg);
assert(~isempty(run.results),'BPPE:Demo','No results were produced.');
results=struct2table(run.results);
writetable(results,fullfile(output_dir,'synthetic_results.csv'));
save(fullfile(output_dir,'synthetic_run.mat'),'run','meta','frames');
fig=figure('Visible','off','Color','w','Position',[100 100 1100 800]);
guard=onCleanup(@() close(fig));
subplot(3,1,1);
plot(meta.time_s,arrayfun(@(f) f.ppg(1),frames));
xlabel('Time (s)'); ylabel('PPG (ADC code)');
title('Synthetic input only - no reference blood pressure'); grid on
subplot(3,1,2);
plot(meta.time_s,run.trace.filtered(:,1)); hold on
idx=find(run.trace.new_beat(:,1));
plot(meta.time_s(idx),run.trace.filtered(idx,1),'o');
xlabel('Time (s)'); ylabel('Filtered PPG (code)');
legend('Causal filtered signal','Completed cycle','Location','best'); grid on
subplot(3,1,3);
t=[run.results.window_end_s];
plot(t,[run.results.sbp],'-o',t,[run.results.dbp],'-s');
xlabel('Time (s)'); ylabel('Artificial output (mmHg)');
title('DEMO coefficients only - not validated blood pressure estimates');
legend('Demo SBP','Demo DBP','Location','best'); grid on
% Explicit export colors prevent desktop dark-theme preferences reducing contrast.
set(findall(fig,'Type','axes'),'Color','w','XColor','k','YColor','k', ...
    'GridColor',[0.65 0.65 0.65],'FontSize',10);
set(findall(fig,'Type','text'),'Color','k');
set(findall(fig,'Type','legend'),'Color','w','TextColor','k','EdgeColor',[.6 .6 .6]);
set(findall(fig,'Type','line'),'LineWidth',1.1);
exportgraphics(fig,fullfile(output_dir,'synthetic_demo.png'),'Resolution',140);
fprintf('Synthetic demo: %d frames, %d results, %d engineering-valid DEMO results.\n', ...
    numel(frames),numel(run.results),sum([run.results.result_valid]));
fprintf('Artifacts: %s\n',output_dir);
end
