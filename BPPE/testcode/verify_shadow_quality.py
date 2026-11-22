# Frozen research protocol only; no production gating or clinical claims.
from pathlib import Path
from collections import defaultdict
import argparse, csv, hashlib, itertools, json, math, statistics

if not __debug__:
    raise RuntimeError('Run verification without Python -O; assertions are required.')
parser=argparse.ArgumentParser(description="Independently verify frozen EXP-029 synthetic study outputs.")
parser.add_argument('--output',type=Path,required=True)
parser.add_argument('--source-root',type=Path,required=True)
parser.add_argument('--log',type=Path,required=True)
parser.add_argument('--error-log',type=Path,required=True)
args=parser.parse_args()
stage=args.source_root
out=args.output
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest().upper()
def rows(name):
    with (out/name).open(encoding='utf-8-sig',newline='') as f:return list(csv.DictReader(f))
def num(row,key):return float(row[key])
def flag(row,key):return row[key] in ('1','true')
P=json.loads((out/'frozen_protocol.json').read_text())
assert sha(out/'frozen_protocol.json')==sha(stage/'m_model/experiments/shadow_quality_protocol.json')=='788EEF12E38A0924080916ACE4E3B52468330FD482B1623050F08E9257CCA991'
metadata=json.loads((out/'run_metadata.json').read_text())
assert metadata['parameters']['enable_morphology'] is True
assert metadata['parameters']['protocol_sha256'].upper()==sha(out/'frozen_protocol.json')
assert metadata['platform']=='PCWIN64'
assert not set(P['fresh_seeds'])&set(P['previously_used_seeds'])
R,W,C,G=map(rows,['runs.csv','candidate_windows.csv','per_run_gates.csv','summary.csv'])
assert len(R)==P['expected_total_runs']==408 and sum(num(r,'frames') for r in R)==P['expected_total_frames']==1632000
assert sum(flag(r,'is_clean') for r in R)==24 and len(C)==408*3
assert len({r['input_sha256_le_u32_columns'] for r in R})==408
expected=set()
for pattern,shape,amp in itertools.product(P['patterns'],P['shapes'],P['amplitudes']):
    expected.add((pattern,shape,amp,'clean',math.inf,0))
    for seed in P['fresh_seeds']:
        for kind,snr in zip(P['noise_kinds'],P['noise_snr_db']):expected.add((pattern,shape,amp,kind,snr,seed))
actual={(r['pattern'],r['shape'],num(r,'amplitude'),r['kind'],num(r,'snr_db'),num(r,'seed')) for r in R}
assert actual==expected and len(expected)==408
bycase=defaultdict(list)
for w in W:bycase[int(w['case_id'])].append(w)
phase={}
for pattern in P['patterns']:
    rates=[]
    for i in range(4000):
        t=i/100
        if pattern.startswith('constant'):rate=float(pattern[8:])
        elif pattern=='ramp55to140':rate=55+85*min(1,max(0,(t-8)/16))
        elif pattern=='step85to125':rate=85 if t<16 else 125
        else:raise AssertionError(pattern)
        rates.append(rate)
    phase[pattern]=(rates,[0])
    for rate in rates:phase[pattern][1].append(phase[pattern][1][-1]+rate/6000)
def integral(pattern,t):
    rates,cumulative=phase[pattern];i=min(3999,math.floor(t*100))
    return cumulative[i]+rates[i]*(t-i/100)/60
truth_checks=0
for r in R:
    cid=int(r['case_id']);ws=bycase[cid]
    assert len(ws)==int(r['candidates']) and num(r,'clipped_samples')==0
    assert sum(flag(w,'baseline_valid') for w in ws)==num(r,'baseline_valid')
    assert sum(flag(w,'baseline_valid') and flag(w,'bad_hr_proxy') for w in ws)==num(r,'baseline_bad')
    for w in ws:
        assert abs(num(w,'time_s')-(num(w,'frame')-1)/100)<1e-10
        if num(w,'count')>0:
            first,last=num(w,'window_start_s'),num(w,'window_end_s')
            ref=60*(integral(r['pattern'],last)-integral(r['pattern'],first))/(last-first)
            assert abs(ref-num(w,'reference_hr_bpm'))<1e-7,(cid,w['candidate'])
            truth_checks+=1
        if flag(w,'baseline_valid'):
            err=abs(num(w,'hr_bpm')-num(w,'reference_hr_bpm'))
            assert abs(err-num(w,'hr_error_bpm'))<1e-8
            assert flag(w,'bad_hr_proxy')==(err>5)
for c in C:
    ws=bycase[int(c['case_id'])];kept=[]
    for w in ws:
        keep=flag(w,'baseline_valid')
        if c['gate']=='sqi200':keep=keep and num(w,'sqi')>=200
        elif c['gate']=='morph020':keep=keep and 0<=num(w,'morphology_cv_max')<=.2
        else:assert c['gate']=='baseline'
        if keep:kept.append(w)
    assert len(kept)==num(c,'retained')
    assert sum(flag(w,'bad_hr_proxy') for w in kept)==num(c,'retained_bad')
    assert num(c,'removed_low_error')==num(c,'baseline_valid')-num(c,'baseline_bad')-len(kept)+num(c,'retained_bad')
    times=[0]+[num(w,'time_s') for w in kept]+[40]
    assert abs(max(b-a for a,b in zip(times,times[1:]))-num(c,'max_no_report_s'))<1e-9
    assert flag(c,'zero_report')==(len(kept)==0)
def selected(c,stratum):
    clean,dynamic=flag(c,'is_clean'),flag(c,'is_dynamic')
    return {'all':True,'clean':clean,'noisy':not clean,'constant':not dynamic,'dynamic':dynamic,
        'clean_constant':clean and not dynamic,'clean_dynamic':clean and dynamic,
        'noisy_constant':not clean and not dynamic,'noisy_dynamic':not clean and dynamic,
        'impulse0':c['kind']=='impulsive' and num(c,'snr_db')==0,
        'impulse6':c['kind']=='impulsive' and num(c,'snr_db')==6,
        'white15':c['kind']=='white','motion15':c['kind']=='periodic_motion',
        'original':c['shape']=='original','broad':c['shape']=='broad'}[stratum]
for g in G:
    cs=[c for c in C if c['gate']==g['gate'] and selected(c,g['stratum'])]
    assert len(cs)==num(g,'runs')
    for key in ('baseline_valid','baseline_bad','retained','retained_bad','removed_low_error'):
        assert sum(num(c,key) for c in cs)==num(g,key)
    assert sum(flag(c,'zero_report') for c in cs)==num(g,'zero_report_runs')
    gaps=[num(c,'max_no_report_s') for c in cs]
    assert abs(statistics.median(gaps)-num(g,'median_run_max_no_report_s'))<1e-9
    assert abs(max(gaps)-num(g,'maximum_no_report_s'))<1e-9
sources=rows('source_manifest.csv')
for s in sources:assert sha(stage/s['Path'])==s['SHA256'].upper(),s['Path']
log=args.log.read_text(encoding='utf-8',errors='replace')
assert log.count('SHADOW_CASE ')==408 and 'SHADOW_VALIDATION_PASSED cases=408 frames=1632000' in log
assert 'SHADOW_HELPER_PASSED' in log
assert not args.error_log.read_text().strip()
result={'study':P['study'],'baseline_commit':P['baseline_commit'],'cases':len(R),'frames':1632000,
    'verifier_sha256':sha(Path(__file__).resolve()),
    'candidates':len(W),'independent_phase_reference_checks':truth_checks,'independent_gate_run_checks':len(C),
    'independent_stratum_checks':len(G),'matlab_source_files':len(sources),
    'protocol_sha256':sha(out/'frozen_protocol.json'),
    'artifacts':{p.name:sha(p) for p in sorted(out.iterdir()) if p.is_file() and p.name!='verification.json'},
    'log_sha256':sha(args.log),'all_summary':[g for g in G if g['stratum']=='all']}
(out/'verification.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2))
