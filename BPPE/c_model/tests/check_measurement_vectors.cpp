#include "bppe/measurement.hpp"
#include <charconv>
#include <fstream>
#include <iostream>
#include <set>
#include <sstream>
#include <string>

namespace {
std::int64_t integer(const std::string& text) {
    std::int64_t value=0; const auto p=std::from_chars(text.data(),text.data()+text.size(),value);
    if(p.ec!=std::errc{} || p.ptr!=text.data()+text.size()) throw std::runtime_error("invalid measurement integer");
    return value;
}
std::uint64_t natural(const std::string& text,std::uint64_t maximum=static_cast<std::uint64_t>(bppe::integer_math::limit)) {
    const auto n=integer(text); if(n<0 || static_cast<std::uint64_t>(n)>maximum) throw std::runtime_error("invalid measurement count");
    return static_cast<std::uint64_t>(n);
}
bool boolean(const std::string& text) {return natural(text,1)!=0;}
std::vector<std::string> split(const std::string& text,char separator) {
    std::istringstream stream(text); std::string word; std::vector<std::string> result;
    while(std::getline(stream,word,separator)) result.push_back(word);
    return result;
}
std::vector<std::int64_t> codes(const std::string& text,std::size_t expected) {
    std::vector<std::int64_t> result;
    if(text!="-") for(const auto& x:split(text,';')) result.push_back(integer(x));
    if(expected!=static_cast<std::size_t>(-1) && result.size()!=expected) throw std::runtime_error("wrong measurement vector length");
    return result;
}
template<std::size_t N> std::array<std::int64_t,N> array(const std::string& text) {
    const auto values=codes(text,N); std::array<std::int64_t,N> result{}; std::copy(values.begin(),values.end(),result.begin()); return result;
}
bppe::faults faults(const std::string& text) {
    const auto words=split(text,';'); if(words.size()!=3) throw std::runtime_error("wrong fault vector");
    return {natural(words[0]),natural(words[1]),natural(words[2])};
}
}
int main(int argc,char** argv) {
    try {
        if(argc!=2) throw std::runtime_error("usage: bppe_check_measurement_vectors <vectors.csv>");
        std::ifstream file(argv[1]); std::string line;
        if(!std::getline(file,line)) throw std::runtime_error("missing measurement header");
        if(!line.empty() && line.back()=='\r') line.pop_back();
        if(line!="case,feature_f,regression_f,channels,primary,beats_limit,min_amplitude,max_amplitude,max_cv,sqi_threshold,configured,calibrated,demo_only,allow_demo,center,scale,beta,min_enabled,feature_min,max_enabled,feature_max,bp_min,bp_max,rejected,beats,before_faults,has_features,features,sqi,channel_sqi,reasons,valid,pressure_raw,codes,after_faults")
            throw std::runtime_error("unexpected measurement header");
        std::set<std::string> seen; std::size_t rows=0,valid=0;
        while(std::getline(file,line)) {
            if(!line.empty() && line.back()=='\r') line.pop_back();
            const auto f=split(line,',');
            if(f.size()!=35 || f[0].empty() || !seen.insert(f[0]).second) throw std::runtime_error("malformed/repeated measurement case");
            bppe::measurement_config c;
            c.feature_f=static_cast<int>(natural(f[1],52)); c.regression_f=static_cast<int>(natural(f[2],52));
            const auto channels=static_cast<std::size_t>(natural(f[3],3));
            const auto primary=natural(f[4],3); if(primary==0) throw std::runtime_error("primary index starts at one");
            c.primary_channel=static_cast<std::size_t>(primary-1); c.beats_per_result=static_cast<std::size_t>(natural(f[5],64));
            c.min_amplitude=integer(f[6]); c.max_amplitude=integer(f[7]); c.max_cv=integer(f[8]);
            c.sqi_threshold=static_cast<std::uint16_t>(natural(f[9],255));
            c.configured=boolean(f[10]);c.calibrated=boolean(f[11]);c.demo_only=boolean(f[12]);c.allow_demo=boolean(f[13]);
            c.center=array<5>(f[14]); c.scale=array<5>(f[15]); const auto beta=array<12>(f[16]);
            for(std::size_t j=0;j<6;++j) for(std::size_t k=0;k<2;++k) c.beta[j][k]=beta[2*j+k];
            const auto lo_enabled=array<5>(f[17]),lo=array<5>(f[18]),hi_enabled=array<5>(f[19]),hi=array<5>(f[20]);
            for(std::size_t j=0;j<5;++j) {
                if((lo_enabled[j]!=0 && lo_enabled[j]!=1) || (hi_enabled[j]!=0 && hi_enabled[j]!=1)) throw std::runtime_error("invalid envelope switch");
                if(lo_enabled[j]) c.feature_min[j]=lo[j];
                if(hi_enabled[j]) c.feature_max[j]=hi[j];
            }
            c.bp_min=array<2>(f[21]); c.bp_max=array<2>(f[22]);
            const auto rejected=codes(f[23],channels); const auto channel_beats=split(f[24],'|');
            if(channel_beats.size()!=channels) throw std::runtime_error("wrong channel count");
            std::vector<bppe::channel_window> windows(channels);
            for(std::size_t k=0;k<channels;++k) {
                if(rejected[k]<0) throw std::runtime_error("negative rejected count");
                windows[k].rejected=static_cast<std::uint64_t>(rejected[k]);
                const auto values=codes(channel_beats[k],static_cast<std::size_t>(-1));
                if(values.size()%5!=0 || values.size()/5>64) throw std::runtime_error("invalid beat matrix");
                for(std::size_t j=0;j<values.size();j+=5) {
                    bppe::beat_features beat{}; std::copy_n(values.begin()+static_cast<std::ptrdiff_t>(j),5,beat.begin()); windows[k].beats.push_back(beat);
                }
            }
            bppe::integer_math q; q.status=faults(f[25]);
            const auto out=bppe::measure_window(windows,c,q);
            const auto expected_quality=codes(f[29],channels);
            const auto expected_codes=array<2>(f[33]);
            const auto after=faults(f[34]);
            bool quality_ok=true;
            for(std::size_t k=0;k<channels;++k) quality_ok=quality_ok && out.channel_sqi[k]==expected_quality[k];
            if(out.has_features!=boolean(f[26]) || out.features!=array<5>(f[27]) || out.sqi!=natural(f[28],255) ||
                !quality_ok || out.reasons!=natural(f[30],65535) || out.valid!=boolean(f[31]) || out.pressure_raw!=array<2>(f[32]) ||
                out.pressure_codes[0]!=expected_codes[0] || out.pressure_codes[1]!=expected_codes[1] ||
                q.status.saturations!=after.saturations || q.status.divzero!=after.divzero || q.status.precision!=after.precision)
                throw std::runtime_error("measurement mismatch case "+f[0]);
            ++rows; if(out.valid) ++valid;
        }
        if(file.bad() || rows==0) throw std::runtime_error("empty/unreadable measurement vectors");
        std::cout<<"MEASUREMENT_MATLAB_VECTORS_PASSED cases="<<rows<<" valid="<<valid<<'\n';
    } catch(const std::exception& e) {std::cerr<<e.what()<<'\n';return 1;}
}
