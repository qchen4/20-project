#include "bppe/frame_validator.hpp"
#include <iostream>
#include <random>
#include <string>

namespace {
void require(bool value,const char* message) {
    if (!value) throw std::runtime_error(message);
}
bppe::input_frame frame(std::uint32_t time,std::uint16_t sequence) {
    bppe::input_frame f;
    f.timestamp.fill(time); f.adc.fill(100000); f.sequence=sequence; f.valid=7;
    return f;
}
bool same(const bppe::frame_decision& a,const bppe::frame_decision& b) {
    return a.accepted==b.accepted && a.history_reset==b.history_reset &&
        a.reason==b.reason && a.faults==b.faults && a.channel_ticks==b.channel_ticks;
}
}
int main() {
    try {
        using validator=bppe::frame_validator;
        const bppe::frame_config cfg{3,8,12,2};
        // Exhaust all combinations of seven ordered error predicates.
        constexpr std::uint16_t reasons[]={1024,2,4,8,1,2,8};
        for (unsigned bits=0;bits<128;++bits) {
            validator v(cfg); require(v.step(frame(1000,10)).accepted,"initial anchor");
            auto input=frame((bits&64U)!=0?1000U:1010U,(bits&32U)!=0?10:11);
            input.config_error=(bits&1U)!=0;
            if ((bits&2U)!=0) input.valid=3;
            if ((bits&4U)!=0) input.saturated=4;
            if ((bits&8U)!=0) input.timestamp[2]+=3;
            input.gain_transition=(bits&16U)!=0;
            std::uint16_t expected=0;
            for (unsigned b=0;b<7;++b) if ((bits&(1U<<b))!=0) {expected=reasons[b];break;}
            const auto out=v.step(input);
            require(out.reason==expected && out.faults==expected,"first-reason precedence");
            require(out.accepted==(bits==0) && out.history_reset==(expected!=0 && expected!=1024),"decision flags");
            require(v.state().have_frame==(expected==0 || expected==1024),"history retention policy");
            if (expected!=0) {
                require(out.channel_ticks==std::array<std::int64_t,3>{},"rejection emitted samples");
                const auto retry=v.step(frame(1010,11));
                require(retry.accepted && retry.faults==expected,"recovery retains sticky faults");
                require(v.state().elapsed_ticks==(expected==1024?10:0),"retry versus re-anchor");
            }
            v.reset(); require(!v.state().have_frame && v.state().faults==0,"explicit reset clears frame state");
            require(v.step(frame(17,65000)).accepted,"reset accepts fresh sequence");
        }
        for (const std::uint32_t delta:{0U,7U,8U,9U,10U,11U,12U,13U,0x7fffffffU,0x80000000U,0xffffffffU}) {
            validator v(cfg); v.step(frame(0xfffffff8U,65535));
            const auto out=v.step(frame(static_cast<std::uint32_t>(0xfffffff8U+delta),0));
            require(out.accepted==(delta>=8 && delta<=12),"inclusive delta bounds and modular wrap");
            if (out.accepted) require(out.channel_ticks[0]==delta,"elapsed wrap uses delta");
        }
        for (const std::int64_t skew:{-2147483648LL,-3LL,-2LL,-1LL,0LL,1LL,2LL,3LL,2147483647LL}) {
            validator v(cfg); auto f=frame(0,0); f.timestamp[1]=static_cast<std::uint32_t>(skew);
            const auto out=v.step(f);
            require(out.accepted==(skew>=-2 && skew<=2),"signed circular skew bounds");
            if (out.accepted) require(out.channel_ticks[1]==skew,"negative first-channel-relative time");
        }
        validator half({2,8,12,0x80000000U});
        auto edge=frame(0,0);edge.timestamp[1]=0x80000000U;
        require(half.step(edge).channel_ticks[1]==-2147483648LL,"half-range skew is negative without overflow");
        validator inactive({1,8,12,0});
        auto f=frame(77,1);f.valid=1;f.saturated=6;f.timestamp[1]=0x80000000U;f.timestamp[2]=0xffffffffU;
        require(inactive.step(f).accepted,"inactive channel flags and timestamps ignored");
        for (const bool optical:{false,true}) {
            validator v(cfg);v.step(frame(100,0));auto changed=frame(110,1);
            if(optical) changed.optical=1;else changed.gain=1;
            require(v.step(changed).reason==1,"gain or optical change resets history");
            changed.timestamp.fill(120);changed.sequence=2;
            require(v.step(changed).accepted && v.state().elapsed_ticks==0,"changed profile re-anchors after rejection");
        }
        for (const bppe::frame_config bad:std::array<bppe::frame_config,6>{{{0,8,12,2},{4,8,12,2},
            {1,0,12,2},{1,13,12,2},{1,8,0x80000000U,2},{1,8,12,0x80000001U}}}) {
            bool caught=false;try {validator invalid(bad);} catch(const std::invalid_argument&) {caught=true;}
            require(caught,"invalid constructor configuration");
        }
        validator host(cfg);host.step(frame(100,9));
        for(unsigned kind=0;kind<3;++kind) {
            auto invalid=frame(110,10);
            if(kind==0)invalid.adc[0]=0x1000000U;else if(kind==1)invalid.valid=8;else invalid.saturated=8;
            bool caught=false;try {host.step(invalid);}catch(const std::invalid_argument&){caught=true;}
            require(caught && host.state().last_sequence==9 && host.state().elapsed_ticks==0 &&
                host.state().faults==0,"malformed host input changed state");
        }
        // Modular timestamp/sequence translation must not alter decisions,
        // elapsed time or recovery. Deterministic seed, no duplicated oracle.
        std::mt19937 random(20261106U);
        std::uint64_t translated_frames=0;
        for(unsigned trial=0;trial<10000;++trial) {
            const auto channels=1U+static_cast<std::uint32_t>(random()%3U);
            validator a({channels,8,12,2}),b({channels,8,12,2});
            const auto shift=static_cast<std::uint32_t>(random());
            const auto sequence_shift=static_cast<std::uint16_t>(random());
            std::uint32_t t=static_cast<std::uint32_t>(random());
            auto seq=static_cast<std::uint16_t>(random());
            for(unsigned step=0;step<24;++step) {
                t+=static_cast<std::uint32_t>(random()%15U);seq=static_cast<std::uint16_t>(seq+1U);
                auto x=frame(t,seq);const auto mode=random()%12U;
                if(mode==0)x.config_error=true;
                if(mode==1)x.valid=0;
                if(mode==2)x.saturated=7;
                if(mode==3)x.gain_transition=true;
                if(mode==4)x.sequence=static_cast<std::uint16_t>(seq-1U);
                x.gain=static_cast<std::uint8_t>(step/8);x.optical=static_cast<std::uint8_t>(trial%2U);
                for(std::uint32_t c=1;c<channels;++c)x.timestamp[c]+=static_cast<std::uint32_t>(random()%7U)-3U;
                auto y=x;for(auto& timestamp:y.timestamp)timestamp+=shift;
                y.sequence=static_cast<std::uint16_t>(y.sequence+sequence_shift);
                require(same(a.step(x),b.step(y)),"modular translation changed transaction result");
                require(a.state().elapsed_ticks==b.state().elapsed_ticks && a.state().have_frame==b.state().have_frame,"translated history diverged");
                ++translated_frames;
            }
        }
        std::cout<<"FRAME_PROPERTIES_PASSED precedence=128 translated_frames="<<translated_frames<<'\n';
    } catch(const std::exception& error) {std::cerr<<error.what()<<'\n';return 1;}
}
