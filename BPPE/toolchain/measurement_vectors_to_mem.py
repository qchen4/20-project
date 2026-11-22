"""Convert existing MATLAB measurement CSV observations to RTL hex records."""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import platform

HEADER = ('case,feature_f,regression_f,channels,primary,beats_limit,min_amplitude,max_amplitude,max_cv,sqi_threshold,'
          'configured,calibrated,demo_only,allow_demo,center,scale,beta,min_enabled,feature_min,max_enabled,feature_max,'
          'bp_min,bp_max,rejected,beats,before_faults,has_features,features,sqi,channel_sqi,reasons,valid,pressure_raw,codes,after_faults').split(',')

def integer(text):
    value = int(text)
    if str(value) != text or not -(1 << 63) <= value < (1 << 63):
        raise ValueError('expected canonical signed 64-bit decimal')
    return value

def codes(text, count=None):
    values = [] if text == '-' else [integer(word) for word in text.split(';')]
    if count is not None and len(values) != count:
        raise ValueError('unexpected vector length')
    return values

def convert(source, target):
    rows, seen = 0, set()
    with source.open(newline='', encoding='utf-8') as src, target.open('w', encoding='ascii', newline='\n') as dst:
        reader = csv.DictReader(src)
        if reader.fieldnames != HEADER:
            raise ValueError('unexpected MATLAB measurement CSV schema')
        for row in reader:
            if None in row or row['case'] in seen or not row['case']:
                raise ValueError('malformed or duplicate case')
            seen.add(row['case'])
            channels, primary, required = (integer(row[key]) for key in ('channels', 'primary', 'beats_limit'))
            if not 1 <= channels <= 3 or not 1 <= primary <= channels or not 1 <= required <= 64:
                raise ValueError('invalid bounded window shape')
            matrices = [codes(text) for text in row['beats'].split('|')]
            if len(matrices) != channels or any(len(m) % 5 or len(m) // 5 > required for m in matrices):
                raise ValueError('invalid beat matrices')
            counts = [len(m) // 5 for m in matrices] + [0] * (3 - channels)
            rejected = codes(row['rejected'], channels) + [0] * (3 - channels)
            if any(value < 0 or value > (1 << 53) - 1 for value in rejected):
                raise ValueError('invalid rejected count')
            words = [rows + 1, integer(row['feature_f']), integer(row['regression_f']), channels, primary - 1, required]
            words += [integer(row[key]) for key in ('min_amplitude', 'max_amplitude', 'max_cv', 'sqi_threshold',
                                                    'configured', 'calibrated', 'demo_only', 'allow_demo')]
            for key, count in (('center', 5), ('scale', 5), ('beta', 12), ('min_enabled', 5), ('feature_min', 5),
                               ('max_enabled', 5), ('feature_max', 5), ('bp_min', 2), ('bp_max', 2)):
                words += codes(row[key], count)
            words += counts + rejected + codes(row['before_faults'], 3)
            words += [integer(row['has_features'])] + codes(row['features'], 5) + [integer(row['sqi'])]
            words += codes(row['channel_sqi'], channels) + [0] * (3 - channels)
            words += [integer(row['reasons']), integer(row['valid'])]
            words += codes(row['pressure_raw'], 2) + codes(row['codes'], 2) + codes(row['after_faults'], 3)
            assert len(words) == 88
            words += [value for matrix in matrices for value in matrix]
            dst.write(' '.join(f'{value & ((1 << 64) - 1):016X}' for value in words) + '\n')
            rows += 1
    if not rows:
        raise ValueError('no measurement cases')
    metadata = {'schema': 'measurement-rtl-v1-88', 'rows': rows, 'python': platform.python_version(),
                'input_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
                'output_sha256': hashlib.sha256(target.read_bytes()).hexdigest()}
    target.with_suffix('.manifest.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')
    return metadata

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('csv', type=Path)
    parser.add_argument('mem', type=Path)
    args = parser.parse_args()
    print(json.dumps(convert(args.csv, args.mem)))
