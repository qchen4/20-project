#include "bppe/causal_preprocessor.hpp"

#include <charconv>
#include <fstream>
#include <iostream>
#include <set>
#include <sstream>
#include <string>
#include <vector>

namespace {
std::int64_t integer(const std::string& text) {
    std::int64_t value=0;
    const auto parsed=std::from_chars(text.data(),text.data()+text.size(),value);
    if (parsed.ec!=std::errc{} || parsed.ptr!=text.data()+text.size())
        throw std::runtime_error("invalid integer in preprocessing vectors");
    return value;
}
std::uint64_t natural(const std::string& text) {
    const auto value=integer(text);
    if (value<0) throw std::runtime_error("negative count/index");
    return static_cast<std::uint64_t>(value);
}
int fraction(const std::string& text) {
    const auto value=integer(text);
    if (value<0 || value>52) throw std::runtime_error("invalid fractional width");
    return static_cast<int>(value);
}
std::vector<std::string> split(const std::string& line) {
    std::istringstream stream(line); std::vector<std::string> values; std::string value;
    while (std::getline(stream,value,',')) values.push_back(value);
    return values;
}
} // namespace

int main(int argc,char** argv) {
    try {
        if (argc!=2) throw std::runtime_error("usage: bppe_check_preprocess_vectors <vectors.csv>");
        std::ifstream file(argv[1]);
        if (!file) throw std::runtime_error("cannot open preprocessing vectors");
        std::string line;
        if (!std::getline(file,line)) throw std::runtime_error("missing CSV header");
        if (!line.empty() && line.back()=='\r') line.pop_back();
        if (line!="case,frame,action,channel,channels,signal_f,coefficient_f,time_f,a,b,adc,ticks,initialized,dc,filtered,sample_time,saturations,divzero,precision")
            throw std::runtime_error("unexpected preprocessing CSV header");
        std::string current;
        std::set<std::string> seen;
        std::vector<bppe::causal_preprocessor> filters;
        bppe::integer_math math;
        bppe::preprocess_config config{0,8,0,0,0};
        std::uint64_t channels=0,expected_frame=1,expected_channel=1,rows=0;
        while (std::getline(file,line)) {
            if (!line.empty() && line.back()=='\r') line.pop_back();
            const auto fields=split(line);
            if (fields.size()!=19) throw std::runtime_error("expected nineteen CSV fields");
            const auto frame=natural(fields[1]),channel=natural(fields[3]),count=natural(fields[4]);
            const bppe::preprocess_config row_config{fraction(fields[5]),fraction(fields[6]),fraction(fields[7]),
                                                   integer(fields[8]),integer(fields[9])};
            if (fields[0]!=current) {
                if (expected_channel!=1 || fields[0].empty() || !seen.insert(fields[0]).second)
                    throw std::runtime_error("incomplete or repeated case");
                if (count<1 || count>3) throw std::runtime_error("channel count outside [1,3]");
                current=fields[0]; config=row_config; channels=count;
                filters.clear();
                for (std::uint64_t k=0;k<channels;++k) filters.emplace_back(config);
                math={}; expected_frame=1; expected_channel=1;
            }
            if (!(row_config==config) || count!=channels || frame!=expected_frame || channel!=expected_channel)
                throw std::runtime_error("configuration changed or frame/channel order invalid");
            if (fields[2]=="clear" || fields[2]=="reset") {
                if (channel!=1) throw std::runtime_error("control events must begin a frame");
                for (auto& filter:filters) filter.clear_history();
                if (fields[2]=="reset") math={};
            } else if (fields[2]!="sample") throw std::runtime_error("unknown preprocessing action");
            const auto adc=integer(fields[10]);
            if (adc<0 || adc>16777215) throw std::runtime_error("ADC code outside 24-bit range");
            const auto out=filters[static_cast<std::size_t>(channel-1)].step(
                static_cast<std::uint32_t>(adc),integer(fields[11]),math);
            const auto initialized=integer(fields[12]);
            if ((initialized!=0 && initialized!=1) || out.state.initialized!=(initialized!=0) ||
                out.state.dc!=integer(fields[13]) || out.state.filtered!=integer(fields[14]) ||
                out.sample_time!=integer(fields[15]) || math.status.saturations!=natural(fields[16]) ||
                math.status.divzero!=natural(fields[17]) || math.status.precision!=natural(fields[18]))
                throw std::runtime_error("preprocessing mismatch at row "+std::to_string(rows+1)+" case "+current);
            ++rows; ++expected_channel;
            if (expected_channel>channels) { expected_channel=1; ++expected_frame; }
        }
        if (file.bad() || rows==0 || expected_channel!=1)
            throw std::runtime_error("empty, unreadable or incomplete preprocessing vectors");
        std::cout << "PREPROCESS_MATLAB_VECTORS_PASSED rows=" << rows << " cases=" << seen.size() << '\n';
    } catch (const std::exception& error) {
        std::cerr << error.what() << '\n'; return 1;
    }
}
