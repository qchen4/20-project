#include "bppe/integer_math.hpp"

#include <charconv>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

namespace {
std::int64_t parse(const std::string& text) {
    std::int64_t result=0;
    const auto parsed=std::from_chars(text.data(),text.data()+text.size(),result);
    if (parsed.ec!=std::errc{} || parsed.ptr!=text.data()+text.size())
        throw std::runtime_error("invalid integer in vector file");
    return result;
}

int parameter(std::int64_t value) {
    if (value<0 || value>52) throw std::runtime_error("invalid format parameter");
    return static_cast<int>(value);
}

std::uint64_t counter(const std::string& text) {
    const auto value=parse(text);
    if (value<0) throw std::runtime_error("negative fault counter");
    return static_cast<std::uint64_t>(value);
}
} // namespace

int main(int argc, char** argv) {
    try {
        if (argc!=2) throw std::runtime_error("usage: bppe_check_vectors <integer_vectors.csv>");
        std::ifstream file(argv[1]);
        if (!file) throw std::runtime_error("cannot open vector file");
        std::string line;
        if (!std::getline(file,line)) throw std::runtime_error("missing CSV header");
        if (!line.empty() && line.back()=='\r') line.pop_back();
        if (line!="operation,a,b,c,d,result,saturations,divzero,precision")
            throw std::runtime_error("unexpected CSV header");
        std::uint64_t rows=0;
        while (std::getline(file,line)) {
            if (!line.empty() && line.back()=='\r') line.pop_back();
            std::istringstream stream(line); std::vector<std::string> fields; std::string field;
            while (std::getline(stream,field,',')) fields.push_back(field);
            if (fields.size()!=9) throw std::runtime_error("expected nine CSV fields");
            const auto a=parse(fields[1]), b=parse(fields[2]);
            const auto c=parse(fields[3]), d=parse(fields[4]);
            bppe::integer_math math; std::int64_t result=0;
            if (fields[0]=="add") result=math.add(a,b);
            else if (fields[0]=="mul") result=math.mul(a,b);
            else if (fields[0]=="divide") result=math.divide(a,b);
            else if (fields[0]=="sqrt") result=math.sqrt_nearest(a);
            else if (fields[0]=="clip") {
                if (d!=0 && d!=1) throw std::runtime_error("invalid signed flag");
                result=math.clip(a,parameter(c),d!=0);
            } else if (fields[0]=="rescale") result=math.rescale(a,parameter(c),parameter(d));
            else throw std::runtime_error("unknown operation");
            if (result!=parse(fields[5]) || math.status.saturations!=counter(fields[6]) ||
                math.status.divzero!=counter(fields[7]) || math.status.precision!=counter(fields[8]))
                throw std::runtime_error("MATLAB mismatch at vector row "+std::to_string(rows+1));
            ++rows;
        }
        if (file.bad() || rows==0) throw std::runtime_error("empty or unreadable vectors");
        std::cout << "MATLAB_INTEGER_VECTORS_PASSED rows=" << rows << '\n';
    } catch (const std::exception& error) {
        std::cerr << error.what() << '\n'; return 1;
    }
}
