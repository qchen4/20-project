"""Exact arbitrary-precision division reference; deterministic boundary/random data."""
import argparse
import hashlib
import json
from pathlib import Path
import random

LIMIT=(1<<53)-1
def reference(x,y):
    if y==0:
        return 0,1
    if abs(x)>LIMIT or abs(y)>LIMIT:
        return 0,2
    q,r=divmod(abs(x),abs(y))
    q+=2*r>=abs(y)
    return (-q if (x<0)!=(y<0) else q),0

def generate(output):
    output.mkdir(parents=True,exist_ok=True)
    rng=random.Random(18053)
    edge=[0,1,-1,2,-2,3,-3,LIMIT,-LIMIT,LIMIT+1,-LIMIT-1,(1<<63)-1,-(1<<63)]
    pairs=[(x,y) for x in edge for y in edge]
    for k in range(1,53):
        for sign in (-1,1):
            for d in (-1,0,1):
                pairs.append((sign*((1<<k)+d),2))
    for _ in range(8000):
        pairs.append((rng.randint(-LIMIT,LIMIT),rng.randint(-LIMIT,LIMIT)))
    for _ in range(4000):
        pairs.append((rng.randint(-LIMIT,LIMIT),rng.randint(-255,255)))
    for _ in range(2000):
        pairs.append((rng.randint(-(1<<63),(1<<63)-1),rng.randint(-(1<<63),(1<<63)-1)))
    path=output/'divider_vectors.mem'
    flags={0:0,1:0,2:0}
    with path.open('w',encoding='ascii',newline='\n') as f:
        for x,y in pairs:
            q,flag=reference(x,y);flags[flag]+=1
            f.write(' '.join(f'{v&((1<<64)-1):016X}' for v in (x,y,q,flag))+'\n')
    metadata=dict(seed=18053,rows=len(pairs),flag_counts=flags,sha256=hashlib.sha256(path.read_bytes()).hexdigest())
    (output/'divider_metadata.json').write_text(json.dumps(metadata,indent=2))
    print(json.dumps(metadata))

if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('output',type=Path)
    generate(parser.parse_args().output)
