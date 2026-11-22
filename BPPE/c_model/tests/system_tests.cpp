#include "bppe/system_reference.hpp"
#include <iostream>

namespace {
void require(bool value,const char* message) {if(!value)throw std::runtime_error(message);}
bppe::system_config config(std::uint32_t channels=3) {
    bppe::system_config c{};
    c.frame={channels,8,12,2};c.preprocess={0,8,0,8,101};
    c.beat={0,0,8,1000000,90,384,1500,304,4};
    auto& m=c.measurement;m.feature_f=8;m.regression_f=8;m.beats_per_result=4;
    m.primary_channel=channels-1;m.min_amplitude=0;m.max_amplitude=256;m.max_cv=64;
    m.configured=true;m.calibrated=true;m.demo_only=true;m.allow_demo=true;
    m.scale.fill(256);m.beta[0]={120*256,80*256};m.bp_min={40*256,20*256};m.bp_max={250*256,180*256};
    c.warmup_ticks=0;c.timeout_ticks=20;c.initial_deadline_ticks=20;return c;
}
bppe::input_frame frame(std::uint32_t time,std::uint16_t seq) {
    bppe::input_frame f;f.adc.fill(100000);f.timestamp={time,time-1U,time+2U};f.sequence=seq;f.valid=7;return f;
}
bool same(const bppe::system_result& a,const bppe::system_result& b) {
    const auto& x=a.measurement;const auto& y=b.measurement;
    return a.sequence==b.sequence && a.tag==b.tag && a.timestamp==b.timestamp &&
        x.has_features==y.has_features && x.valid==y.valid && x.features==y.features &&
        x.channel_sqi==y.channel_sqi && x.sqi==y.sqi && x.reasons==y.reasons &&
        x.pressure_raw==y.pressure_raw && x.pressure_codes==y.pressure_codes;
}
void faults_equal(const bppe::faults& q,const bppe::faults& expected) {
    require(q.saturations==expected.saturations && q.divzero==expected.divzero && q.precision==expected.precision,"numeric fault lifetime");
}
}
int main() {
    try {
        auto cfg=config();bppe::system_reference s(cfg);
        s.ack();s.ack();require(!s.pending() && !s.snapshot(),"ACK empty mailbox");
        const std::uint32_t base=0xfffffff6U;
        auto out=s.step(frame(base,65534),100);require(!out.candidate,"first frame anchors");
        out=s.step(frame(base+10U,65535),101);require(!out.candidate,"before exact deadline");
        out=s.step(frame(base+20U,0),102);
        require(out.candidate && out.published && s.pending() && s.result_counter()==1 && s.deadline_ticks()==40,"inclusive timeout and publication");
        require(out.candidate->timestamp==12 && out.candidate->tag==102 && out.candidate->measurement.reasons==17 &&
            !out.candidate->measurement.valid && !out.candidate->measurement.has_features,"wrapped latest-channel timestamp and insufficient flat result");
        const auto first=*s.snapshot();
        s.step(frame(base+30U,1),103);out=s.step(frame(base+40U,2),104);
        require(out.candidate && !out.published && out.reasons==512 && s.result_counter()==2 &&
            same(*s.snapshot(),first) && s.fault_flags()==512,"pending keeps first snapshot while computing");
        s.ack();s.ack();require(!s.pending() && same(*s.snapshot(),first) && s.fault_flags()==512,"duplicate ACK retains payload/faults");
        s.step(frame(base+50U,3),105);out=s.step(frame(base+60U,4),106);
        require(out.published && out.candidate->sequence==3 && s.snapshot()->tag==106,"ACK permits later publication");
        const auto retained=*s.snapshot();const auto before=s.filter_state(0);
        auto rejected=frame(base+70U,5);rejected.config_error=true;rejected.valid=0;
        out=s.step(rejected,107);
        require(!out.accepted && out.reasons==1024 && s.acquisition_state().elapsed_ticks==60 &&
            s.deadline_ticks()==80 && s.filter_state(0).dc==before.dc && same(*s.snapshot(),retained),"configuration retry keeps history and snapshot");
        require(s.step(frame(base+70U,5),107).accepted,"configuration retry accepts original transaction");
        rejected=frame(base+80U,6);rejected.valid=0;out=s.step(rejected,108);
        require(!out.accepted && out.reasons==2 && !s.acquisition_state().have_frame && s.deadline_ticks()==20 &&
            !s.filter_state(0).initialized && s.channel_state(0).beats.empty() && s.pending() &&
            same(*s.snapshot(),retained) && s.result_counter()==3,"frame fault clears processing only");
        s.step(frame(200,999),109);s.step(frame(210,1000),110);out=s.step(frame(220,1001),111);
        require(out.candidate && !out.published && out.candidate->sequence==4 && same(*s.snapshot(),retained),"post-fault re-anchor and retained pending");
        s.reset();require(!s.pending() && !s.snapshot() && s.result_counter()==0 && s.fault_flags()==0 &&
            s.deadline_ticks()==20 && !s.filter_state(0).initialized,"coordinated reset into running session");

        // Reproduce the previously approved integer deadline boundary exactly.
        auto exact=config(1);exact.frame={1,1,20000,0};exact.warmup_ticks=20000;
        exact.timeout_ticks=10000;exact.initial_deadline_ticks=8020;
        bppe::system_reference ticks(exact);ticks.step(frame(0,0),0);
        require(ticks.step(frame(8020,1),1).candidate.has_value() && ticks.deadline_ticks()==18020,"8020 starts exact 10000 tick window");
        require(!ticks.step(frame(18019,2),2).candidate,"one tick before deadline");
        require(ticks.step(frame(18020,3),3).candidate.has_value() && ticks.deadline_ticks()==28020,"exact 18020 tick timeout");

        // Initial host faults persist across errors/ACK and reset to the seed.
        auto seeded=config(1);seeded.initial_faults={3,4,5};bppe::system_reference faults(seeded);
        out=faults.step(frame(0,0),0);require(out.reasons==192 && faults.fault_flags()==192,"initial numeric faults surfaced on accepted input");
        auto bad=frame(10,1);bad.valid=0;out=faults.step(bad,1);
        require(out.reasons==2 && faults.fault_flags()==194,"rejected frame does not append numeric reason");
        faults_equal(faults.numeric_faults(),seeded.initial_faults);faults.ack();faults.reset();
        faults_equal(faults.numeric_faults(),seeded.initial_faults);require(faults.fault_flags()==0,"reset retains seeds but clears reported flags");

        // Flat per-frame timeout isolates the existing 16-bit result counter
        // wrap without requiring thousands of physical beat windows.
        auto wrap=config(1);wrap.frame={1,1,1,0};wrap.initial_deadline_ticks=0;wrap.timeout_ticks=1;
        bppe::system_reference counter(wrap);
        for(std::uint32_t i=0;i<65537U;++i) {
            counter.ack();out=counter.step(frame(i,static_cast<std::uint16_t>(i)),i);
            require(out.published && out.candidate && out.candidate->sequence==static_cast<std::uint16_t>(i+1U),"result counter wraps modulo 65536");
        }
        require(counter.result_counter()==1 && counter.snapshot()->tag==65536U,"wrapped result retains full caller tag");

        // Malformed host input is rejected before any system state changes.
        const auto saved=*counter.snapshot();const auto deadline=counter.deadline_ticks();
        bad=frame(65537U,1);bad.adc[0]=0x1000000U;
        bool threw=false;try{counter.step(bad,65537);}catch(const std::invalid_argument&){threw=true;}
        require(threw && same(*counter.snapshot(),saved) && counter.deadline_ticks()==deadline && counter.result_counter()==1,"bad host input is atomic");
        auto invalid=config();invalid.beat.beats_per_result=3;threw=false;
        try{bppe::system_reference rejected_config(invalid);}catch(const std::invalid_argument&){threw=true;}
        require(threw,"inconsistent component configuration rejected");
        std::cout<<"SYSTEM_PROPERTIES_PASSED exact_deadline=18020 counter_publications=65537\n";
    } catch(const std::exception& error){std::cerr<<error.what()<<'\n';return 1;}
}
