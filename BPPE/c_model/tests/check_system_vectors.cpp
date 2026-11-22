#include "bppe/system_reference.hpp"
#include <charconv>
#include <fstream>
#include <iostream>
#include <memory>
#include <set>
#include <sstream>
#include <string>

namespace {
using record=std::vector<std::uint64_t>;
void require(bool ok,const char* message) {if(!ok)throw std::runtime_error(message);}
std::int64_t code(std::uint64_t value) {
    return value<=0x7fffffffffffffffULL?static_cast<std::int64_t>(value):-static_cast<std::int64_t>(~value)-1;
}
std::uint32_t bounded(std::uint64_t value,std::uint32_t maximum) {
    require(value<=maximum,"system field outside domain");return static_cast<std::uint32_t>(value);
}
bool flag(std::uint64_t value) {return bounded(value,1)!=0;}
record parse(const std::string& line) {
    record out;std::istringstream stream(line);std::string token;
    while(stream>>token) {
        std::uint64_t value=0;
        const auto p=std::from_chars(token.data(),token.data()+token.size(),value,16);
        require(token.size()==16 && p.ec==std::errc{} && p.ptr==token.data()+token.size(),"invalid system hexadecimal field");
        out.push_back(value);
    }
    require(!out.empty() && ((out[0]==0 && out.size()==78) || (out[0]==1 && out.size()==60)),"invalid system record length/type");
    return out;
}
bppe::system_config configuration(const record& w) {
    bppe::system_config c{};
    const auto sf=static_cast<int>(bounded(w[2],10)),cf=static_cast<int>(bounded(w[3],18));
    const auto tf=static_cast<int>(bounded(w[4],10)),ff=static_cast<int>(bounded(w[5],18));
    c.preprocess={sf,cf,tf,code(w[6]),code(w[7])};
    const auto count=bounded(w[12],64);
    c.beat={sf,tf,ff,code(w[8]),code(w[9]),code(w[10]),code(w[11]),304,count};
    auto& m=c.measurement;m.feature_f=ff;m.regression_f=ff;m.beats_per_result=count;
    m.min_amplitude=code(w[13]);m.max_amplitude=code(w[14]);m.max_cv=code(w[15]);
    m.sqi_threshold=static_cast<std::uint16_t>(bounded(w[16],255));
    m.configured=flag(w[17]);m.calibrated=flag(w[18]);m.demo_only=flag(w[19]);m.allow_demo=flag(w[20]);
    for(std::size_t i=0;i<5;++i) {
        m.center[i]=code(w[21+i]);m.scale[i]=code(w[26+i]);
        if(flag(w[43+i]))m.feature_min[i]=code(w[48+i]);
        if(flag(w[53+i]))m.feature_max[i]=code(w[58+i]);
    }
    for(std::size_t i=0;i<6;++i)for(std::size_t j=0;j<2;++j)m.beta[i][j]=code(w[31+2*i+j]);
    for(std::size_t i=0;i<2;++i){m.bp_min[i]=code(w[63+i]);m.bp_max[i]=code(w[65+i]);}
    c.initial_faults={w[67],w[68],w[69]};c.warmup_ticks=code(w[70]);
    c.timeout_ticks=code(w[71]);c.initial_deadline_ticks=code(w[72]);
    c.frame={bounded(w[73],3),bounded(w[75],0xffffffffU),bounded(w[76],0xffffffffU),bounded(w[77],0xffffffffU)};
    m.primary_channel=bounded(w[74],2);
    return c;
}
void compare_payload(const bppe::system_result& r,const record& w,std::size_t start,bool snapshot) {
    const auto& m=r.measurement;
    const auto at=[&](std::size_t i){return w[start+i+(snapshot && i>=1?1U:0U)];};
    require(r.sequence==at(0) && r.timestamp==at(1) && m.has_features==flag(at(2)) && m.valid==flag(at(3)) &&
        m.reasons==at(4) && m.sqi==at(5),snapshot?"system snapshot metadata mismatch":"system candidate metadata mismatch");
    for(std::size_t i=0;i<5;++i)require(m.features[i]==code(at(6+i)),snapshot?"system snapshot feature mismatch":"system candidate feature mismatch");
    for(std::size_t i=0;i<2;++i)require(m.pressure_raw[i]==code(at(11+i)) && m.pressure_codes[i]==at(13+i),
        snapshot?"system snapshot pressure mismatch":"system candidate pressure mismatch");
    if(snapshot)require(r.tag==w[start+1],"system snapshot tag mismatch");
}
}
int main(int argc,char** argv) {
    std::uint64_t line_number=0,current=0,case_frame=0;
    try {
        require(argc==2,"usage: bppe_check_system_vectors <system_vectors.mem>");
        std::ifstream file(argv[1]);require(static_cast<bool>(file),"cannot open system vectors");
        std::string line;std::set<std::uint64_t> seen;
        std::unique_ptr<bppe::system_reference> system;
        std::uint64_t frames=0,accepted=0,rejected=0,candidates=0,published=0,acks=0,overflows=0,overflow_frames=0;
        std::uint64_t numeric_frames=0,pending_rejections=0,known_gap=0;
        int feature_f=0;
        while(std::getline(file,line)) {
            ++line_number;const auto w=parse(line);
            if(w[0]==0) {
                require(!system || case_frame>0,"empty system case");
                require(w[1]>0 && seen.insert(w[1]).second,"duplicate/zero system case");
                current=w[1];case_frame=0;const auto cfg=configuration(w);feature_f=cfg.measurement.feature_f;
                system=std::make_unique<bppe::system_reference>(cfg);
                continue;
            }
            require(system && w[1]==current && w[2]==++case_frame,"system case/frame order mismatch");
            const auto tag=bounded(w[2],0xffffffffU);
            if(flag(w[3])){system->ack();++acks;}
            bppe::input_frame input;
            input.config_error=flag(w[47]);input.sequence=static_cast<std::uint16_t>(bounded(w[48],65535));
            input.gain=static_cast<std::uint8_t>(bounded(w[49],255));input.optical=static_cast<std::uint8_t>(bounded(w[50],255));
            input.gain_transition=flag(w[51]);input.valid=static_cast<std::uint8_t>(bounded(w[52],7));
            input.saturated=static_cast<std::uint8_t>(bounded(w[53],7));
            for(std::size_t i=0;i<3;++i){input.adc[i]=bounded(w[54+i],0xffffffU);input.timestamp[i]=bounded(w[57+i],0xffffffffU);}
            const auto out=system->step(input,tag);const auto& q=system->numeric_faults();
            require(out.accepted==flag(w[4]) && out.reasons==w[5],"system sample decision mismatch");
            require(system->acquisition_state().elapsed_ticks==code(w[6]) && system->deadline_ticks()==code(w[7]) &&
                system->acquisition_state().have_frame==flag(w[8]),"system acquisition/deadline mismatch");
            require(q.saturations==w[9] && q.divzero==w[10] && q.precision==w[11],"system numeric fault mismatch");
            require(out.candidate.has_value()==flag(w[12]),"system candidate-valid mismatch");
            const bppe::system_result empty;
            compare_payload(out.candidate?*out.candidate:empty,w,13,false);
            if(out.candidate)require(out.candidate->tag==tag,"system candidate tag mismatch");
            require(system->pending()==flag(w[28]),"system pending mismatch");
            compare_payload(system->snapshot()?*system->snapshot():empty,w,29,true);
            require(system->result_counter()==w[45] && system->fault_flags()==w[46],"system counter/sticky fault mismatch");
            ++frames;if(out.accepted)++accepted;else ++rejected;
            if(out.candidate) {
                ++candidates;if(out.published)++published;else ++overflows;
                // Diagnostic only: match the existing fixed known-gap fixture's
                // >5 bpm deviation without a floating-point division oracle.
                if((current%8)==0 && out.candidate->measurement.valid) {
                    const auto period=out.candidate->measurement.features[0];
                    const auto numerator=60LL*(std::int64_t{1}<<feature_f);
                    if(period<=0 || numerator<70*period || numerator>80*period)++known_gap;
                }
            }
            if((system->fault_flags()&512U)!=0)++overflow_frames;
            if(q.failed())++numeric_frames;
            if(!out.accepted && system->pending())++pending_rejections;
        }
        require(!file.bad() && frames>0 && case_frame>0,"empty/incomplete system vectors");
        std::cout<<"SYSTEM_MATLAB_VECTORS_PASSED cases="<<seen.size()<<" frames="<<frames<<" accepted="<<accepted<<
            " rejected="<<rejected<<" candidates="<<candidates<<" published="<<published<<" overflow_candidates="<<overflows<<
            " acks="<<acks<<" overflow_frames="<<overflow_frames<<" numeric_frames="<<numeric_frames<<
            " pending_rejections="<<pending_rejections<<" known_gap="<<known_gap<<'\n';
    } catch(const std::exception& error) {
        std::cerr<<"line="<<line_number<<" case="<<current<<" frame="<<case_frame<<": "<<error.what()<<'\n';return 1;
    }
}
