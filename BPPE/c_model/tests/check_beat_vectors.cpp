#include "bppe/beat_extractor.hpp"
#include "bppe/causal_preprocessor.hpp"
#include <charconv>
#include <fstream>
#include <iostream>
#include <memory>
#include <set>
#include <sstream>
#include <string>

namespace {
std::int64_t integer(const std::string& text) {
    std::int64_t value=0;
    const auto p=std::from_chars(text.data(),text.data()+text.size(),value);
    if (p.ec!=std::errc{} || p.ptr!=text.data()+text.size()) throw std::runtime_error("invalid beat integer");
    return value;
}
std::vector<std::string> split(const std::string& text,char separator) {
    std::istringstream stream(text); std::string word; std::vector<std::string> result;
    while (std::getline(stream,word,separator)) result.push_back(word);
    return result;
}
std::vector<std::int64_t> codes(const std::string& text) {
    std::vector<std::int64_t> result;
    if (text!="-") for (const auto& field:split(text,';')) result.push_back(integer(field));
    return result;
}
int width(const std::string& text) {
    const auto value=integer(text);
    if (value<0 || value>52) throw std::runtime_error("invalid beat fraction");
    return static_cast<int>(value);
}
std::size_t count(const std::string& text) {
    const auto value=integer(text);
    if (value<0 || value>65536) throw std::runtime_error("invalid beat buffer bound");
    return static_cast<std::size_t>(value);
}
bool flag(const std::string& text) {
    if (text!="0" && text!="1") throw std::runtime_error("invalid beat boolean");
    return text=="1";
}
} // namespace

int main(int argc,char** argv) {
    try {
        if (argc!=2) throw std::runtime_error("usage: bppe_check_beat_vectors <vectors.csv>");
        std::ifstream file(argv[1]); std::string line;
        if (!std::getline(file,line)) throw std::runtime_error("cannot read beat CSV header");
        if (!line.empty() && line.back()=='\r') line.pop_back();
        if (line!="case,frame,action,kind,signal_f,time_f,feature_f,tick_ns,min_period,max_period,max_ticks,capacity,beats_limit,a,b,ticks,input,dc,time,warmup,previous_y,previous_t,tracking,rejected,cycle_t,cycle_y,beat_times,beats,emitted,features,saturations,divzero,precision")
            throw std::runtime_error("unexpected beat CSV header");
        std::unique_ptr<bppe::beat_extractor> beat;
        std::unique_ptr<bppe::causal_preprocessor> filter;
        std::set<std::string> seen;
        std::vector<std::string> configuration;
        std::string current,kind;
        bppe::integer_math math;
        std::uint64_t rows=0,emitted=0,frame=0;
        while (std::getline(file,line)) {
            if (!line.empty() && line.back()=='\r') line.pop_back();
            const auto f=split(line,',');
            if (f.size()!=33) throw std::runtime_error("expected 33 beat CSV fields");
            const std::vector<std::string> row_config(f.begin()+4,f.begin()+15);
            if (f[0]!=current) {
                if (f[0].empty() || !seen.insert(f[0]).second) throw std::runtime_error("empty or repeated beat case");
                current=f[0]; kind=f[3]; configuration=row_config; frame=0; math={};
                beat=std::make_unique<bppe::beat_extractor>(bppe::beat_config{width(f[4]),width(f[5]),width(f[6]),
                    integer(f[7]),integer(f[8]),integer(f[9]),integer(f[10]),count(f[11]),count(f[12])});
                filter=std::make_unique<bppe::causal_preprocessor>(bppe::preprocess_config{
                    width(f[4]),width(f[4])==0?8:18,width(f[5]),integer(f[13]),integer(f[14])});
            }
            if (row_config!=configuration || f[3]!=kind || integer(f[1])!=static_cast<std::int64_t>(++frame))
                throw std::runtime_error("changed beat configuration/order");
            if (f[2]=="clear" || f[2]=="reset") {
                beat->clear_history(); filter->clear_history();
                if (f[2]=="reset") math={};
            } else if (f[2]!="sample") throw std::runtime_error("unknown beat action");
            auto y=integer(f[16]),dc=integer(f[17]),t=integer(f[18]);
            if (kind=="adc") {
                if (y<0 || y>16777215) throw std::runtime_error("invalid beat ADC");
                const bool initial=!filter->state().initialized;
                const auto out=filter->step(static_cast<std::uint32_t>(y),integer(f[15]),math);
                if (out.state.dc!=dc || out.sample_time!=t) throw std::runtime_error("beat preprocessing mismatch");
                y=out.state.filtered;
                if (initial) beat->initialize_time(t);
            } else if (kind!="filtered") throw std::runtime_error("unknown beat input kind");
            const auto out=beat->step(y,dc,t,flag(f[19]),math);
            const auto& s=beat->state();
            std::vector<std::int64_t> history;
            for (const auto& record:s.beats) history.insert(history.end(),record.begin(),record.end());
            std::vector<std::int64_t> features;
            if (out.emitted) features.assign(out.features.begin(),out.features.end());
            if (s.previous_y!=integer(f[20]) || s.previous_t!=integer(f[21]) || s.tracking!=flag(f[22]) ||
                s.rejected_beats!=static_cast<std::uint64_t>(integer(f[23])) || s.cycle_t!=codes(f[24]) ||
                s.cycle_y!=codes(f[25]) || s.beat_times!=codes(f[26]) || history!=codes(f[27]) ||
                out.emitted!=flag(f[28]) || features!=codes(f[29]) ||
                math.status.saturations!=static_cast<std::uint64_t>(integer(f[30])) ||
                math.status.divzero!=static_cast<std::uint64_t>(integer(f[31])) ||
                math.status.precision!=static_cast<std::uint64_t>(integer(f[32])))
                throw std::runtime_error("beat state/features/fault mismatch at row "+std::to_string(rows+1)+" case "+current);
            ++rows; emitted+=out.emitted?1U:0U;
        }
        if (file.bad() || rows==0) throw std::runtime_error("empty/unreadable beat CSV");
        std::cout<<"BEAT_MATLAB_VECTORS_PASSED rows="<<rows<<" cases="<<seen.size()<<" beats="<<emitted<<'\n';
    } catch (const std::exception& error) { std::cerr<<error.what()<<'\n'; return 1; }
}
