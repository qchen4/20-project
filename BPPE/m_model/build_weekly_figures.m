function build_weekly_figures(output_dir)
% Export slide-ready PNG/SVG figures from verified project evidence.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'..','reports','weekly-2026-10-22','figures'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fixed=readtable(fullfile(root,'artifacts','fixed','summary.csv'));
noise=load(fullfile(root,'artifacts','noise','noise_evaluation.mat'));
fixed_summary(fixed,output_dir);
noise_summary(noise.report,output_dir);
noise_examples(noise,output_dir);
fprintf('Weekly figures: %s\n',output_dir);
end

function fixed_summary(s,out)
f=canvas(); cleanup=onCleanup(@()close(f));
annotation(f,'textbox',[.04 .87 .92 .1],'String','定点精度与位宽选择', ...
    'EdgeColor','none','FontSize',27,'FontWeight','bold');
ax=axes(f,'Position',[.08 .22 .52 .59]);
bar(ax,[s.sbp_max s.dbp_max]); set(ax,'YScale','log','XTick',1:3,'XTickLabel',s.profile);
ylabel(ax,'最大新增误差（mmHg，对数轴）'); title(ax,'浮点与定点的压力数值差异');
legend(ax,{'SBP','DBP'},'Location','northeast'); grid(ax,'on');
annotation(f,'textbox',[.65 .65 .31 .14],'String',{'169 / 169','平衡配置窗口匹配'}, ...
    'EdgeColor','none','FontSize',22,'FontWeight','bold');
annotation(f,'textbox',[.65 .46 .31 .15],'String',{'≤ 1 LSB','UQ9.7 输出编码差异'}, ...
    'EdgeColor','none','FontSize',22,'FontWeight','bold');
annotation(f,'textbox',[.65 .25 .31 .15],'String',{'低位宽不推荐','出现 6 次低质量误接受'}, ...
    'EdgeColor','none','FontSize',20,'Color',[.65 .24 .12]);
annotation(f,'textbox',[.05 .06 .92 .08],'String', ...
    {'依据：23 个合成场景，每组 64,799 帧；压力误差基于 143 个双方有效的匹配结果', ...
     '边界：全量程阶跃另有 5 次特征饱和并报告数值故障；不代表真实血压准确性'}, ...
    'EdgeColor','none','FontSize',13);
savefigure(f,out,'02_fixed_point_results');
end

function noise_summary(report,out)
f=canvas(); cleanup=onCleanup(@()close(f));
annotation(f,'textbox',[.04 .87 .92 .1],'String','抗噪评估同时观察输出覆盖率与有效输出误差', ...
    'EdgeColor','none','FontSize',26,'FontWeight','bold');
types={'white','colored','baseline','periodic_motion','impulsive'};
labels={'白噪声','相关噪声','基线漂移','周期运动干扰','脉冲干扰'};
colors=[.12 .43 .70;.24 .58 .42;.55 .36 .64;.80 .30 .17;.65 .48 .12];
ax1=axes(f,'Position',[.07 .24 .40 .56]); hold(ax1,'on');
ax2=axes(f,'Position',[.57 .24 .38 .56]); hold(ax2,'on');
for k=1:5
    d=report.summary(strcmp(report.summary.kind,types{k}),:); d=sortrows(d,'snr_db');
    plot(ax1,d.snr_db,d.coverage_mean,'-o','LineWidth',2,'Color',colors(k,:));
    plot(ax2,d.snr_db,d.hr_mae,'-o','LineWidth',2,'Color',colors(k,:));
end
xlabel(ax1,'注入 SNR（dB，AC RMS 定义）'); ylabel(ax1,'有效报告覆盖率（%）'); ylim(ax1,[0 105]);
xlabel(ax2,'注入 SNR（dB，AC RMS 定义）'); ylabel(ax2,'有效输出的周期折算心率 MAE（bpm）');
title(ax1,'覆盖率：匹配干净参考的报告时刻'); title(ax2,'误差：只统计通过质量门控的结果');
grid(ax1,'on'); grid(ax2,'on');
legend(ax1,labels,'Location','best','FontSize',11);
annotation(f,'textbox',[.05 .05 .92 .10],'String', ...
    {'5 类干扰 × 5 档 SNR × 5 个随机种子；每次 32 秒，100 Hz，合成心率 75 bpm', ...
     '曲线为重复试验汇总；无有效输出时 MAE 留空。注入 SNR 不等于 ADI 文档的频域 pSNR；没有真实血压标签'}, ...
    'EdgeColor','none','FontSize',12);
savefigure(f,out,'03_noise_robustness');
end

function noise_examples(data,out)
f=canvas(); cleanup=onCleanup(@()close(f));
annotation(f,'textbox',[.04 .88 .92 .09],'String','相同注入 SNR 下，不同干扰具有不同波形特征', ...
    'EdgeColor','none','FontSize',25,'FontWeight','bold');
labels={'白噪声','相关噪声','基线漂移','周期运动干扰','脉冲干扰'};
clean=vertcat(data.clean.ppg); center=mean(clean(:,1)); scale=std(clean(:,1),1);
t=(0:size(clean,1)-1)/data.report.config.fs_hz; select=t>=8 & t<=12;
for k=1:5
    ax=axes(f,'Position',[.14 .72-(k-1)*.135 .80 .105]); hold(ax,'on');
    plot(ax,t(select),(clean(select,1)-center)/scale,'Color',[.15 .3 .45],'LineWidth',1.6);
    plot(ax,t(select),(data.examples(k).input(select,1)-center)/scale,'Color',[.85 .40 .12],'LineWidth',.9);
    ylabel(ax,labels{k},'FontSize',13); xlim(ax,[8 12]); grid(ax,'on');
    if k==1, legend(ax,{'干净参考','含噪输入'},'Location','northeast','Orientation','horizontal'); end
    if k<5, set(ax,'XTickLabel',[]); else, xlabel(ax,'时间（秒）'); end
end
annotation(f,'textbox',[.05 .035 .92 .07],'String', ...
    '全部为 6 dB 注入 SNR、随机种子 11；纵轴按干净 AC 的 RMS 归一化。波形为合成干扰，不代表实际活动记录', ...
    'EdgeColor','none','FontSize',12);
savefigure(f,out,'04_noise_examples');
end

function f=canvas()
f=figure('Visible','off','Color','w','Position',[100 100 1600 900]);
end
function savefigure(f,out,name)
set(findall(f,'Type','axes'),'Color','w','XColor','k','YColor','k','FontSize',13,'FontName','Microsoft YaHei');
set(findall(f,'Type','text'),'FontName','Microsoft YaHei','Interpreter','none','Color','k');
set(findall(f,'Type','legend'),'Color','w','TextColor','k','FontName','Microsoft YaHei');
boxes=findall(f,'Type','textbox');
if ~isempty(boxes), set(boxes,'FontName','Microsoft YaHei','Interpreter','none','Color','k'); end
set(f,'PaperPositionMode','auto','InvertHardcopy','off');
print(f,fullfile(out,[name '.png']),'-dpng','-r160');
print(f,fullfile(out,[name '.svg']),'-dsvg');
end
