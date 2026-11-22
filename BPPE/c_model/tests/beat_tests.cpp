#include "bppe/beat_extractor.hpp"
#include <iostream>

int main() {
    try {
        bppe::integer_math q;
        bppe::beat_extractor b({0,0,8,1000000,90,384,1500,304,4});
        auto check=[](bool ok) { if (!ok) throw std::runtime_error("beat property failure"); };
        // A hand-computed 800 ms triangular cycle with interpolated endpoints.
        check(!b.step(0,10000,0,false,q).emitted);
        check(!b.step(100,10000,200,false,q).emitted);
        check(!b.step(0,10000,400,false,q).emitted);
        check(!b.step(-100,10000,600,false,q).emitted);
        check(!b.step(0,10000,800,false,q).emitted);
        const auto out=b.step(100,10000,1000,false,q);
        check(out.emitted && out.crossing_time==800);
        check(out.features==bppe::beat_features{205,64,64,64,5});
        check(b.state().cycle_t==std::vector<std::int64_t>({800,1000}));
        check(!q.status.failed());
        // Warmup updates history but never starts a cycle.
        b.clear_history(); b.step(-10,10000,10,true,q); b.step(10,10000,20,true,q);
        check(!b.state().tracking && b.state().previous_y==10 && b.state().previous_t==20);
        // Capacity is checked after append and rejects only strictly above bound.
        bppe::beat_extractor small({0,0,8,1000000,90,384,1500,3,4});
        small.step(1,10000,0,false,q); small.step(1,10000,1,false,q);
        check(small.state().cycle_t.size()==3 && small.state().tracking);
        small.step(1,10000,2,false,q);
        check(!small.state().tracking && small.state().rejected_beats==1 && small.state().cycle_t.empty());
        // History clear cannot clear a caller-owned latched numeric fault.
        q.divide(1,0); small.clear_history(); check(q.status.divzero==1);
        bool rejected=false;
        try { small.step(1,1,std::int64_t{1}<<47,false,q); } catch (const std::invalid_argument&) { rejected=true; }
        check(rejected);
        std::cout<<"BEAT_PROPERTIES_PASSED\n";
    } catch (const std::exception& e) { std::cerr<<e.what()<<'\n'; return 1; }
}
