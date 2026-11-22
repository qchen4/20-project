function count = bppe_export_integer_vectors(output_dir)
% Scalar integer DSP vectors for an independent C++ checker; no product data.
root = fileparts(mfilename('fullpath'));
if nargin<1, output_dir = fullfile(root,'artifacts','integer-vectors'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fid = fopen(fullfile(output_dir,'integer_vectors.csv'),'w');
assert(fid>=0,'BPPE:Vectors','Cannot write integer vectors.');
cleanup = onCleanup(@()fclose(fid));
fprintf(fid,'operation,a,b,c,d,result,saturations,divzero,precision\n');
count = 0; limit = 2^53-1;
edges = [-2^53,-limit,-limit+1,-2^52,-257,-3,-1,0,1,3,257,2^52,limit-1,limit,2^53];
for a = edges
    for b = edges
        emit('add',a,b,0,0); emit('mul',a,b,0,0); emit('divide',a,b,0,0);
    end
end
for a = -129:129
    for b = -33:33, emit('divide',a,b,0,0); end
end
for a = [0:1024,edges], emit('sqrt',a,0,0,0); end
for width = [1,8,16,34,52]
    for signed = [0,1]
        top = 2^(width-signed); lo = -signed*top; hi = top-1;
        for a = unique([edges,lo-1,lo,hi,hi+1])
            emit('clip',a,0,width,signed);
        end
    end
end
for a = edges
    for from = [0,1,8,16,18,52]
        for to = [0,1,8,16,18,52], emit('rescale',a,0,from,to); end
    end
end
clear cleanup
bppe_write_manifest(output_dir,'scalar-integer-vectors',struct( ...
    'vectors',count,'exact_integer_limit',limit,'scope','scalar DSP operations only'));
fprintf('EXPORTED_INTEGER_VECTORS=%d\n',count);

    function emit(operation,a,b,c,d)
        math = bppe_integer_math();
        switch operation
            case 'add', result = math.add(a,b);
            case 'mul', result = math.mul(a,b);
            case 'divide', result = math.divide(a,b);
            case 'sqrt', result = math.sqrt_nearest(a);
            case 'clip', result = math.clip(a,c,logical(d),'vector');
            case 'rescale', result = math.rescale(a,c,d);
            otherwise, error('BPPE:Vectors','Unknown scalar operation.');
        end
        fprintf(fid,'%s,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f\n', ...
            operation,a,b,c,d,result,math.saturation_count, ...
            math.divzero_count,math.precision_fault_count);
        count = count+1;
    end
end
