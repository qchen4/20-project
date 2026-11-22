function f = bppe_flags()
% Reason bits follow the existing register proposal.
names = {'LOW_SQI','SAMPLE_GAP','ADC_SATURATED','TIMESTAMP_ERROR', ...
    'INSUFFICIENT_BEATS','MODEL_UNCONFIGURED','NUMERIC_FAULT', ...
    'DIVZERO','INPUT_OVERFLOW','RESULT_OVERFLOW','CONFIG_ERROR', ...
    'ABORTED','BUS_ACCESS_ERROR'};
for k = 1:numel(names)
    f.(names{k}) = bitshift(uint16(1), k-1);
end
end
