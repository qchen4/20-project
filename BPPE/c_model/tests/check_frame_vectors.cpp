#include "bppe/frame_validator.hpp"
#include "bppe/causal_preprocessor.hpp"
#include "bppe/beat_extractor.hpp"
#include <charconv>
#include <fstream>
#include <iostream>
#include <memory>
#include <set>
#include <sstream>
#include <string>

namespace {
using words=std::array<std::uint64_t,74>;
std::int64_t signed_word(std::uint64_t value) {
    return value<=0x7fffffffffffffffULL?static_cast<std::int64_t>(value):
        -static_cast<std::int64_t>(~value)-1;
}
words parse(const std::string& line) {
    words out{};std::istringstream stream(line);std::string token;
    for(auto& word:out) {
        if(!(stream>>token))throw std::runtime_error("expected 74 hexadecimal frame fields");
        const auto p=std::from_chars(token.data(),token.data()+token.size(),word,16);
        if(token.size()!=16 || p.ec!=std::errc{} || p.ptr!=token.data()+token.size())
            throw std::runtime_error("invalid hexadecimal frame field");
    }
    if(stream>>token)throw std::runtime_error("extra frame fields");
    return out;
}
std::uint32_t bounded(std::uint64_t value,std::uint32_t maximum) {
    if(value>maximum)throw std::runtime_error("frame field outside domain");
    return static_cast<std::uint32_t>(value);
}
bool flag(std::uint64_t value) {return bounded(value,1)!=0;}
void require(bool value,const char* message) {if(!value)throw std::runtime_error(message);}
}
int main(int argc,char** argv) {
    std::uint64_t row=0,current=0;
    try {
        if(argc!=2)throw std::runtime_error("usage: bppe_check_frame_vectors <frame_vectors.mem>");
        std::ifstream file(argv[1]);if(!file)throw std::runtime_error("cannot open frame vectors");
        std::string line;
        std::unique_ptr<bppe::frame_validator> adapter;
        std::vector<bppe::causal_preprocessor> filters;
        std::vector<bppe::beat_extractor> beats;
        bppe::integer_math math;
        std::set<std::uint64_t> seen;
        std::array<std::uint64_t,12> config{};
        std::uint64_t case_frame=0,accepted=0,rejected=0,events=0,emitted=0;
        while(std::getline(file,line)) {
            ++row;const auto w=parse(line);
            require(w[0]>0 && w[1]>0,"zero case/frame index");
            const auto profile=bounded(w[2],2),channels=bounded(w[3],3);
            require(channels>0,"zero active channels");
            std::array<std::uint64_t,12> row_config{};
            std::copy(w.begin()+2,w.begin()+14,row_config.begin());
            if(w[0]!=current) {
                require(seen.insert(w[0]).second,"repeated frame case");
                current=w[0];case_frame=0;config=row_config;math={};
                adapter=std::make_unique<bppe::frame_validator>(bppe::frame_config{
                    channels,bounded(w[4],0xffffffffU),bounded(w[5],0xffffffffU),bounded(w[6],0xffffffffU)});
                const int sf=profile==0?0:(profile==1?8:10),cf=profile==0?8:18,ff=profile==0?8:(profile==1?16:18);
                filters.clear();beats.clear();
                for(std::uint32_t c=0;c<channels;++c) {
                    filters.emplace_back(bppe::preprocess_config{sf,cf,sf,signed_word(w[8]),signed_word(w[9])});
                    beats.emplace_back(bppe::beat_config{sf,sf,ff,signed_word(w[7]),signed_word(w[10]),signed_word(w[11]),
                        signed_word(w[12]),304,64});
                }
                require(signed_word(w[13])>=0,"negative warmup bound");
            }
            require(row_config==config && w[1]==++case_frame,"frame configuration/order changed");
            bppe::input_frame input;
            input.config_error=flag(w[14]);input.sequence=static_cast<std::uint16_t>(bounded(w[15],65535));
            input.gain=static_cast<std::uint8_t>(bounded(w[16],255));input.optical=static_cast<std::uint8_t>(bounded(w[17],255));
            input.gain_transition=flag(w[18]);input.valid=static_cast<std::uint8_t>(bounded(w[19],7));
            input.saturated=static_cast<std::uint8_t>(bounded(w[20],7));
            require(w[21]==w[1],"unexpected frame tag");
            for(std::size_t c=0;c<3;++c) {
                input.adc[c]=bounded(w[22+c],0xffffffU);input.timestamp[c]=bounded(w[25+c],0xffffffffU);
            }
            const auto decision=adapter->step(input);
            require(decision.accepted==flag(w[28]) && decision.reason==w[29] && decision.faults==w[30],"frame decision/fault mismatch");
            require(adapter->state().elapsed_ticks==signed_word(w[31]),"frame elapsed mismatch");
            if(decision.history_reset) {
                for(auto& filter:filters)filter.clear_history();
                for(auto& beat:beats)beat.clear_history();
            }
            for(std::uint32_t c=0;c<channels;++c) {
                bppe::beat_output out;
                if(decision.accepted) {
                    require(decision.channel_ticks[c]==signed_word(w[32+c]),"accepted channel tick mismatch");
                    const bool initial=!filters[c].state().initialized;
                    const auto p=filters[c].step(input.adc[c],decision.channel_ticks[c],math);
                    if(initial)beats[c].initialize_time(p.sample_time);
                    out=beats[c].step(p.state.filtered,p.state.dc,p.sample_time,
                        decision.channel_ticks[c]<signed_word(w[13]),math);
                }
                const auto& p=filters[c].state();const auto& b=beats[c].state();
                require(p.dc==signed_word(w[35+c]) && p.filtered==signed_word(w[38+c]) &&
                    b.previous_t==signed_word(w[41+c]) && b.tracking==flag(w[44+c]) && b.rejected_beats==w[47+c],
                    "acquisition channel history mismatch");
                require(out.emitted==flag(w[50+c]),"acquisition beat-valid mismatch");
                if(out.emitted) {
                    for(std::size_t k=0;k<5;++k)require(out.features[k]==signed_word(w[53+c*5+k]),"acquisition beat feature mismatch");
                    require(out.crossing_time==signed_word(w[68+c]),"acquisition beat time mismatch");
                    ++emitted;
                }
            }
            require(math.status.saturations==w[71] && math.status.divzero==w[72] && math.status.precision==w[73],"acquisition numeric fault mismatch");
            if(decision.accepted){++accepted;events+=channels;}else{++rejected;++events;}
        }
        require(!file.bad() && row>0,"empty/unreadable frame vectors");
        std::cout<<"ACQUISITION_MATLAB_VECTORS_PASSED rows="<<row<<" cases="<<seen.size()<<
            " accepted="<<accepted<<" rejected="<<rejected<<" events="<<events<<" beats="<<emitted<<'\n';
    } catch(const std::exception& error) {
        std::cerr<<"row="<<row<<" case="<<current<<": "<<error.what()<<'\n';return 1;
    }
}
