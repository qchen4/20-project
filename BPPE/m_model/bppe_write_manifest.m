function manifest = bppe_write_manifest(output_dir, run_name, parameters)
% Bind generated results to exact MATLAB sources and explicit run parameters.
if ~exist(output_dir,'dir'), mkdir(output_dir); end
root = fileparts(mfilename('fullpath'));
files = dir(fullfile(root,'**','*.m'));
paths = strings(0,1); hashes = strings(0,1);
for k = 1:numel(files)
    path = fullfile(files(k).folder,files(k).name);
    relative = strrep(path(numel(root)+2:end),'\','/');
    if startsWith(relative,'artifacts/'), continue; end
    fid = fopen(path,'rb');
    assert(fid>=0,'BPPE:Manifest','Cannot read source: %s',path);
    cleanup = onCleanup(@()fclose(fid));
    bytes = fread(fid,Inf,'*uint8'); clear cleanup
    digest = javaMethod('getInstance','java.security.MessageDigest','SHA-256');
    digest.update(typecast(bytes,'int8'));
    hash = lower(reshape(dec2hex(typecast(digest.digest(),'uint8'),2).',1,[]));
    paths(end+1,1) = "m_model/"+relative; %#ok<AGROW>
    hashes(end+1,1) = string(hash); %#ok<AGROW>
end
manifest = sortrows(table(paths,hashes,'VariableNames',{'Path','SHA256'}),'Path');
writetable(manifest,fullfile(output_dir,'source_manifest.csv'));
metadata = struct('run',run_name,'matlab_version',version,'platform',computer, ...
    'created_utc',char(datetime('now','TimeZone','UTC','Format',"yyyy-MM-dd'T'HH:mm:ss'Z'")), ...
    'parameters',parameters,'source_files',height(manifest));
fid = fopen(fullfile(output_dir,'run_metadata.json'),'w');
assert(fid>=0,'BPPE:Manifest','Cannot write metadata.');
cleanup = onCleanup(@()fclose(fid));
fprintf(fid,'%s\n',jsonencode(metadata,'PrettyPrint',true));
end
