#pragma once
#include "bppe/beat_extractor.hpp"
#include <optional>

namespace bppe {
struct channel_window {
    std::vector<beat_features> beats;
    std::uint64_t rejected=0;
};
struct measurement_config {
    int feature_f=16,regression_f=16;
    std::size_t beats_per_result=4,primary_channel=0;
    std::int64_t min_amplitude=0,max_amplitude=0,max_cv=0;
    std::uint16_t sqi_threshold=150;
    bool configured=false,calibrated=false,demo_only=true,allow_demo=false;
    beat_features center{},scale{};
    std::array<std::array<std::int64_t,2>,6> beta{};
    std::array<std::optional<std::int64_t>,5> feature_min{},feature_max{};
    std::array<std::int64_t,2> bp_min{},bp_max{};
};
struct measurement_output {
    bool has_features=false,valid=false;
    beat_features features{};
    std::vector<std::uint8_t> channel_sqi;
    std::uint8_t sqi=0;
    std::uint16_t reasons=0;
    std::array<std::int64_t,2> pressure_raw{};
    std::array<std::uint16_t,2> pressure_codes{};
};

// Evaluate an existing bounded beat window. Acquisition validation, timeout,
// candidate publication and ACK are caller-owned; no model fitting here.
inline measurement_output measure_window(const std::vector<channel_window>& channels,
                                         const measurement_config& cfg,integer_math& q) {
    const int f=cfg.feature_f,r=cfg.regression_f;
    if (!((f==8 || f==16 || f==18) && r==f) || channels.empty() || channels.size()>3 ||
        cfg.primary_channel>=channels.size() || cfg.beats_per_result<1 || cfg.beats_per_result>64 || cfg.sqi_threshold>255)
        throw std::invalid_argument("unsupported measurement configuration");
    const auto in_signed=[](std::int64_t x,int width) {
        const auto top=std::int64_t{1}<<(width-1); return x>=-top && x<top;
    };
    for (std::size_t j=0;j<5;++j) {
        if (!in_signed(cfg.center[j],4+f) || !in_signed(cfg.scale[j],4+f) ||
            (cfg.feature_min[j] && !in_signed(*cfg.feature_min[j],4+f)) ||
            (cfg.feature_max[j] && !in_signed(*cfg.feature_max[j],4+f)))
            throw std::invalid_argument("measurement model input outside encoded format");
    }
    for (const auto& row:cfg.beta) for (const auto value:row)
        if (!in_signed(value,10+r)) throw std::invalid_argument("beta outside encoded format");
    if (!in_signed(cfg.min_amplitude,4+f) || !in_signed(cfg.max_amplitude,4+f) || !in_signed(cfg.max_cv,4+f))
        throw std::invalid_argument("quality threshold outside encoded format");
    for (const auto& c:channels) {
        if(c.beats.size()>cfg.beats_per_result || c.rejected>static_cast<std::uint64_t>(integer_math::limit))
            throw std::invalid_argument("measurement window outside supported bounds");
        for(const auto& beat:c.beats) for(const auto value:beat)
            if(!in_signed(value,4+f)) throw std::invalid_argument("beat outside encoded format");
    }
    constexpr std::uint16_t low_sqi=1,insufficient=16,unconfigured=32,numeric=64,divzero=128,config_error=1024;
    const auto one=std::int64_t{1}<<f;
    const auto n_required=static_cast<std::int64_t>(cfg.beats_per_result);
    measurement_output out;
    std::vector<std::int64_t> quality(channels.size(),0);
    for (std::size_t k=0;k<channels.size();++k) {
        const auto& c=channels[k]; const auto n=static_cast<std::int64_t>(c.beats.size());
        if (n<n_required) {out.reasons|=insufficient; continue;}
        std::int64_t period_sum=0;
        for (const auto& beat:c.beats) period_sum+=beat[0]; // Bounded exact sum, as MATLAB.
        const auto avg=q.divide(period_sum,n);
        std::int64_t variance=0;
        bool amplitude_ok=true;
        for (const auto& beat:c.beats) {
            const auto d=beat[0]-avg; variance=q.add(variance,q.mul(d,d));
            amplitude_ok=amplitude_ok && beat[4]>=cfg.min_amplitude && beat[4]<=cfg.max_amplitude;
        }
        const auto deviation=q.sqrt_nearest(q.divide(variance,n));
        const auto cv=q.clip(q.divide(q.mul(deviation,one),avg),4+f,true);
        const auto regularity=std::max(std::int64_t{0},one-q.divide(q.mul(cv,one),cfg.max_cv));
        const auto clean=q.divide(n_required*one,n_required+static_cast<std::int64_t>(c.rejected));
        quality[k]=q.divide(q.mul(q.mul(amplitude_ok?255:0,regularity),clean),one*one);
    }
    const auto raw_sqi=*std::min_element(quality.begin(),quality.end());
    const auto byte=[](std::int64_t x) {return static_cast<std::uint8_t>(std::clamp(x,std::int64_t{0},std::int64_t{255}));};
    out.sqi=byte(raw_sqi);
    for(const auto value:quality) out.channel_sqi.push_back(byte(value));
    if(raw_sqi<cfg.sqi_threshold) out.reasons|=low_sqi;
    const auto& primary=channels[cfg.primary_channel].beats;
    out.has_features=primary.size()>=cfg.beats_per_result;
    if(out.has_features) for(std::size_t j=0;j<5;++j) {
        std::int64_t sum=0; for(const auto& beat:primary) sum+=beat[j];
        out.features[j]=q.clip(q.divide(sum,n_required),4+f,true);
    }
    const bool model_ok=cfg.configured && cfg.calibrated && (!cfg.demo_only || cfg.allow_demo);
    if(!model_ok) out.reasons|=unconfigured;
    std::array<std::int64_t,2> prediction{};
    if(model_ok && out.has_features) {
        bool bounded=true;
        for(std::size_t j=0;j<5;++j)
            bounded=bounded && (!cfg.feature_min[j] || out.features[j]>=*cfg.feature_min[j]) &&
                (!cfg.feature_max[j] || out.features[j]<=*cfg.feature_max[j]);
        if(!bounded) out.reasons|=config_error;
        else {
            beat_features z{};
            for(std::size_t j=0;j<5;++j)
                z[j]=q.clip(q.divide(q.mul(out.features[j]-cfg.center[j],std::int64_t{1}<<r),cfg.scale[j]),6+r,true);
            for(std::size_t output=0;output<2;++output) {
                auto acc=cfg.beta[0][output];
                for(std::size_t j=0;j<5;++j) {
                    const auto product=q.mul(z[j],cfg.beta[j+1][output]);
                    const auto term=q.rescale(product,2*r,r);
                    acc=q.clip(q.add(acc,term),20+r,true);
                }
                prediction[output]=acc;
            }
            if(prediction[0]<cfg.bp_min[0] || prediction[0]>cfg.bp_max[0] || prediction[1]<cfg.bp_min[1] ||
                prediction[1]>cfg.bp_max[1] || prediction[0]<=prediction[1]) out.reasons|=config_error;
        }
    }
    std::array<std::uint16_t,2> codes{};
    for(std::size_t j=0;j<2;++j) codes[j]=static_cast<std::uint16_t>(q.clip(q.rescale(prediction[j],r,7),16,false));
    if(q.status.failed()) out.reasons|=numeric;
    if(q.status.divzero>0) out.reasons|=divzero;
    out.valid=out.reasons==0;
    if(out.valid) {out.pressure_raw=prediction;out.pressure_codes=codes;}
    return out;
}
} // namespace bppe
