function report = bppe_export_preprocess_vectors(output_dir)
% Observe the existing private channel kernel, isolating its preprocessing.
% Warmup suppresses beat extraction; time-limit injections use flat zero ADC.
root = fileparts(mfilename('fullpath'));
if nargin<1, output_dir = fullfile(root,'artifacts','preprocess-vectors'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fid = fopen(fullfile(output_dir,'preprocess_vectors.csv'),'w');
assert(fid>=0,'BPPE:Vectors','Cannot write preprocessing vectors.');
cleanup = onCleanup(@()fclose(fid));
mem_fid = fopen(fullfile(output_dir,'preprocess_vectors.mem'),'w');
assert(mem_fid>=0,'BPPE:Vectors','Cannot write RTL preprocessing vectors.');
mem_cleanup = onCleanup(@()fclose(mem_fid));
fprintf(mem_fid,'# Same nineteen fields as CSV, hexadecimal integers; case is numeric.\n');
fprintf(fid,['case,frame,action,channel,channels,signal_f,coefficient_f,time_f,a,b,' ...
    'adc,ticks,initialized,dc,filtered,sample_time,saturations,divzero,precision\n']);
report = struct('rows',0,'cases',0,'fault_observations',0,'clear_events',0,'reset_events',0);
profiles = {'compact','balanced','wide'};
for index = 1:numel(profiles)
    profile = bppe_fixed_profile(profiles{index});
    run_case('zero',profile,zeros(128,1),[],{},false);
    run_case('maximum',profile,repmat(2^24-1,128,1),[],{},false);
    run_case('steps',profile,repmat([zeros(32,1);repmat(2^24-1,32,1)],2,1),[],{},false);
    run_case('alternating',profile,repmat([0;2^24-1],64,1),[],{},false);
    run_case('small_changes',profile,repmat([1000;1001;999;1002;998;1000;1003;997],32,1),[],{},false);
    cfg = bppe_default_config(); cfg.channels = 3;
    frames = bppe_synthetic(cfg,8);
    ticks = (0:numel(frames)-1)'*10+[0,1,-1];
    run_case('three_channels',profile,vertcat(frames.ppg),ticks,{},false);
    limit = 2^(47-profile.time_f);
    ticks = [0;1;limit-1;limit;limit+1;1;2;3;0;2^53;0;0];
    actions = repmat({'sample'},12,1);
    actions{6} = 'clear'; actions{9} = 'reset';
    actions{11} = 'clear'; actions{12} = 'reset';
    run_case('time_recovery',profile,zeros(12,1),ticks,actions,false);
    run_case('zero_coefficients',profile,repmat([1000;2000;0;2^24-1],32,1),[],{},true);
end
clear cleanup mem_cleanup
parameters = report;
parameters.profiles = profiles; parameters.warmup_s = 1000;
parameters.scope = 'Direct accepted-sample preprocessing only; no frame validation or beat extraction';
bppe_write_manifest(output_dir,'causal-preprocess-vectors',parameters);
fprintf('EXPORTED_PREPROCESS_VECTORS rows=%d cases=%d\n',report.rows,report.cases);

    function run_case(name,profile,values,ticks,actions,zero_coefficients)
        cfg = bppe_default_config(); cfg.channels = size(values,2); cfg.warmup_s = 1000;
        if zero_coefficients, cfg.dc_cutoff_hz = 1e-7; cfg.lowpass_hz = 2e-7; end
        if isempty(ticks), ticks = repmat((0:size(values,1)-1)'*10,1,cfg.channels); end
        if isempty(actions), actions = repmat({'sample'},size(values,1),1); end
        state = bppe_init_fixed(cfg,profile); channels = state.p.channel;
        assert(~state.fx.math.failed(),'BPPE:Vectors','Host-loading faults are outside this stage.');
        report.cases = report.cases+1;
        for frame = 1:size(values,1)
            action = actions{frame};
            if strcmp(action,'clear')
                processing = bppe_processing_init(cfg); channels = processing.channel;
                report.clear_events = report.clear_events+1;
            elseif strcmp(action,'reset')
                state = bppe_init_fixed(cfg,profile); channels = state.p.channel;
                report.reset_events = report.reset_events+1;
            end
            for channel = 1:cfg.channels
                [channels(channel),beat] = bppe_channel_fixed(channels(channel),values(frame,channel), ...
                    ticks(frame,channel),cfg,state.fx);
                assert(isempty(beat) && ~channels(channel).tracking, ...
                    'BPPE:Vectors','A beat path escaped preprocessing isolation.');
                c = channels(channel); math = state.fx.math;
                row_action = 'sample'; if channel==1, row_action = action; end
                fprintf(fid,'%s_%s,%d,%s,%d,%d,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%d,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f\n', ...
                    profile.name,name,frame,row_action,channel,cfg.channels,profile.signal_f, ...
                    profile.coefficient_f,profile.time_f,state.fx.a,state.fx.b,values(frame,channel), ...
                    ticks(frame,channel),c.initialized,c.dc,c.y,c.previous_t,math.saturation_count, ...
                    math.divzero_count,math.precision_fault_count);
                action_code = strcmp(row_action,'clear')+2*strcmp(row_action,'reset');
                words = [report.cases,frame,action_code,channel,cfg.channels,profile.signal_f, ...
                    profile.coefficient_f,profile.time_f,state.fx.a,state.fx.b,values(frame,channel), ...
                    ticks(frame,channel),c.initialized,c.dc,c.y,c.previous_t,math.saturation_count, ...
                    math.divzero_count,math.precision_fault_count];
                hex = cellstr(dec2hex(typecast(int64(words),'uint64'),16));
                fprintf(mem_fid,'%s\n',strjoin(hex,' '));
                report.rows = report.rows+1;
                report.fault_observations = report.fault_observations+math.failed();
            end
        end
    end
end
