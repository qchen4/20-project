"""Diagnose observed EXP-029 windows; no threshold selection or production gate."""
from pathlib import Path
from bisect import bisect_left
from collections import defaultdict
import argparse,csv,hashlib,json,math,struct

def correspondence(clean,start,end):
    if len(clean)<2 or any(not math.isfinite(x) for x in clean) or any(b<=a for a,b in zip(clean,clean[1:])):
        raise ValueError('Clean crossings must be finite and strictly increasing')
    if not math.isfinite(start+end) or end<=start or start<clean[0] or end>clean[-1]:
        raise ValueError('Interval must be positive and inside clean reference extent')
    def nearest(t):
        i=bisect_left(clean,t)
        choices=[j for j in (i-1,i) if 0<=j<len(clean)]
        return min(choices,key=lambda j:(abs(clean[j]-t),j))
    a,b=nearest(start),nearest(end)
    return dict(clean_start_index=a+1,clean_end_index=b+1,clean_interval_count=b-a,
        start_shift_s=start-clean[a],end_shift_s=end-clean[b],
        matched_clean_duration_s=clean[b]-clean[a])

def self_test():
    clean=[0.,1.,2.,3.,4.]
    assert correspondence(clean,1,2)['clean_interval_count']==1
    assert correspondence(clean,1,1.4)['clean_interval_count']==0
    assert correspondence(clean,1,3)['clean_interval_count']==2
    c=correspondence(clean,1.1,2.2)
    assert abs(c['end_shift_s']-c['start_shift_s']-.1)<1e-12
    assert correspondence(clean,.5,1.5)['clean_start_index']==1  # Ties choose earlier.
    for values,start,end in (([0,1,1],0,1),(clean,2,1),(clean,-1,1),(clean,1,math.nan)):
        try:correspondence(values,start,end)
        except ValueError:pass
        else:raise AssertionError('Invalid diagnostic interval accepted')

def main():
    if not __debug__:raise RuntimeError('Assertions required; do not use Python -O')
    self_test()
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--source-root',type=Path,required=True)
    args=parser.parse_args();out=args.output
    def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
    def read(name):
        with (out/name).open(encoding='utf-8-sig',newline='') as f:return list(csv.DictReader(f))
    def group(rows):
        result=defaultdict(list)
        for row in rows:result[int(row['case_id'])].append(row)
        return result
    def f(r,k):return float(r[k])
    def yes(r,k):return r[k] in ('1','true')
    R=read('runs.csv');B=group(read('beats.csv'));X=group(read('crossings.csv'))
    W=group(read('windows.csv'));F=group(read('float_candidates.csv'));T=group(read('traces.csv'))
    observed=read('observed_study_windows.csv')
    focus=[w for w in observed if yes(w,'baseline_valid') and yes(w,'bad_hr_proxy')]
    assert len(R)==12 and len(focus)==6 and sum(map(len,T.values()))==48000
    metadata=json.loads((out/'run_metadata.json').read_text())
    assert metadata['parameters']['fresh_validation'] is False
    assert metadata['parameters']['input_hashes']['windows'].upper()==sha(out/'observed_study_windows.csv')
    assert metadata['parameters']['input_hashes']['protocol'].upper()==sha(out/'frozen_protocol.json')
    assert sha(out/'frozen_protocol.json')=='788EEF12E38A0924080916ACE4E3B52468330FD482B1623050F08E9257CCA991'
    for s in read('source_manifest.csv'):assert sha(args.source_root/s['Path'])==s['SHA256'].upper(),s['Path']
    runs={int(r['case_id']):r for r in R}
    clean_beats_checked=0
    float_boundary_matches=0
    for cid,r in runs.items():
        trace=T[cid];assert len(trace)==4000
        rates=[];phase=[0.]
        for i,t in enumerate(trace):
            sec=i/100;pattern=r['pattern']
            if pattern.startswith('constant'):rate=float(pattern[8:])
            elif pattern=='ramp55to140':rate=55+85*min(1,max(0,(sec-8)/16))
            elif pattern=='step85to125':rate=85+40*(sec>=16)
            else:raise AssertionError(pattern)
            rates.append(rate)
            if i>0:phase.append(phase[-1]+rates[i-1]/6000)
            assert abs(f(t,'phase')-phase[i])<1e-10
            assert abs(f(t,'time_s')-sec)<1e-12
        adc=[int(t['adc']) for t in trace]
        raw=b''.join(struct.pack('<4000I',*col) for col in (adc,[i*10 for i in range(4000)],list(range(4000))))
        assert hashlib.sha256(raw).hexdigest()==r['input_sha256_le_u32_columns']
        def phase_at(t):
            i=min(3999,math.floor(t*100))
            return phase[i]+rates[i]*(t-i/100)/60
        crossing_frames=set()
        for x in X[cid]:
            n=int(x['frame']);crossing_frames.add(n)
            before=round(f(trace[n-2],'filtered')*256);after=round(f(trace[n-1],'filtered')*256)
            assert before<=0<after
            numerator=-before*2560;denominator=after-before
            offset=(2*numerator+denominator)//(2*denominator)
            exact=((n-2)*2560+offset)/256000
            assert abs(exact-f(x,'time_s'))<1e-12
            assert abs(phase_at(exact)-f(x,'phase'))<1e-10
            assert yes(x,'accepted_closing')==any(int(b['frame'])==n for b in B[cid])
        expected_frames={i+1 for i in range(1,4000) if i/100>=2 and f(trace[i-1],'filtered')<=0<f(trace[i],'filtered')}
        assert crossing_frames==expected_frames
        for b in B[cid]:
            start,end=f(b,'start_s'),f(b,'end_s')
            assert any(abs(f(x,'time_s')-start)<1e-12 for x in X[cid])
            assert any(abs(f(x,'time_s')-end)<1e-12 and yes(x,'accepted_closing') for x in X[cid])
            ticks=round((end-start)*256000)
            expected_code=(2*ticks*1000000*256+1000000000)//2000000000
            assert round(f(b,'period_s')*65536)==expected_code
            if yes(r,'is_clean'):
                c=correspondence([f(x,'time_s') for x in X[cid]],start,end)
                assert c['clean_interval_count']==1 and abs(c['start_shift_s'])<1e-12 and abs(c['end_shift_s'])<1e-12
                clean_beats_checked+=1
        float_boundary_matches+=len({int(w['frame']) for w in W[cid]}&{int(w['frame']) for w in F[cid]})
    details=[];summaries=[]
    for w in focus:
        cid=int(w['case_id']);r=runs[cid];clean_id=int(r['clean_case_id'])
        clean_times=[f(x,'time_s') for x in X[clean_id]]
        chosen=[b for b in B[cid] if int(w['first_beat'])<=int(b['beat_index'])<=int(w['last_beat'])]
        assert len(chosen)==int(w['count'])==4
        current=[]
        trace=T[cid]
        def phase_at(t):
            i=min(3998,math.floor(t*100));u=(t-i/100)*100
            return f(trace[i],'phase')*(1-u)+f(trace[i+1],'phase')*u
        for b in chosen:
            start,end=f(b,'start_s'),f(b,'end_s');c=correspondence(clean_times,start,end)
            assert abs((end-start)-c['matched_clean_duration_s']-(c['end_shift_s']-c['start_shift_s']))<1e-11
            center=.22
            row=dict(case_id=cid,candidate=int(w['candidate']),beat_index=int(b['beat_index']),
                start_s=start,end_s=end,period_s=f(b,'period_s'),duration_s=end-start,
                phase_advance=phase_at(end)-phase_at(start),
                ideal_main_centers=math.floor(phase_at(end)-center)-math.floor(phase_at(start)-center),**c)
            details.append(row);current.append(row)
        first,last=current[0]['start_s'],current[-1]['end_s']
        duration=sum(b['duration_s'] for b in current);clean_duration=sum(b['matched_clean_duration_s'] for b in current)
        matched_float=[v for v in F[cid] if int(v['frame'])==int(w['frame'])]
        assert len(matched_float)==1
        floating=matched_float[0]
        row=dict(case_id=cid,clean_case_id=clean_id,candidate=int(w['candidate']),frame=int(w['frame']),
            pattern=r['pattern'],shape=r['shape'],amplitude=int(r['amplitude']),seed=int(r['seed']),snr_db=f(r,'snr_db'),
            reference_hr_bpm=f(w,'reference_hr_bpm'),fixed_hr_bpm=f(w,'hr_bpm'),float_hr_bpm=f(floating,'hr_bpm'),
            float_valid=yes(floating,'baseline_valid'),fixed_sqi=int(w['sqi']),float_sqi=int(floating['sqi']),
            morphology_cv_max=f(w,'morphology_cv_max'),
            unquantized_period_hr_bpm=240/duration,
            accepted_duration_s=duration,envelope_s=last-first,gap_s=last-first-duration,
            accepted_phase_advance=sum(b['phase_advance'] for b in current),envelope_phase_advance=phase_at(last)-phase_at(first),
            ideal_main_centers=sum(b['ideal_main_centers'] for b in current),
            nearest_clean_intervals=sum(b['clean_interval_count'] for b in current),
            duplicate_nearest_boundary_beats=sum(b['clean_interval_count']==0 for b in current),
            multicycle_nearest_beats=sum(b['clean_interval_count']>1 for b in current),
            matched_clean_duration_s=clean_duration,net_boundary_duration_shift_s=duration-clean_duration,
            nonemitting_internal_crossings=sum(first+1e-12<f(x,'time_s')<=last+1e-12 and not yes(x,'accepted_closing') for x in X[cid]))
        summaries.append(row)
    def write(name,rows):
        with (out/name).open('w',encoding='utf-8',newline='') as stream:
            writer=csv.DictWriter(stream,fieldnames=list(rows[0]));writer.writeheader();writer.writerows(rows)
    write('cycle_details.csv',details);write('cycle_summary.csv',summaries)
    input_names=('runs.csv','beats.csv','windows.csv','crossings.csv','float_candidates.csv','traces.csv',
        'observed_study_windows.csv','frozen_protocol.json','run_metadata.json','source_manifest.csv')
    report=dict(cases=12,frames=48000,beats=sum(map(len,B.values())),crossings=sum(map(len,X.values())),
        fixed_candidates=sum(map(len,W.values())),float_boundary_matches=float_boundary_matches,
        clean_one_interval_checks=clean_beats_checked,focused_windows=len(summaries),focused_beats=len(details),
        self_tests_passed=True,fresh_validation=False,production_changed=False,
        analyzer_sha256=sha(Path(__file__).resolve()),input_hashes={name:sha(out/name) for name in input_names},
        summary=summaries)
    (out/'correspondence_analysis.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(report,indent=2))

if __name__=='__main__':main()
