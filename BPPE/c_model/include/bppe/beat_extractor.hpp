#pragma once

#include "bppe/integer_math.hpp"
#include <array>
#include <vector>

namespace bppe {

struct beat_config {
    int signal_f, time_f, feature_f;
    std::int64_t tick_period_ns, min_period, max_period, max_period_ticks;
    std::size_t cycle_capacity, beats_per_result;
};
using beat_features = std::array<std::int64_t,5>;
struct beat_state {
    std::int64_t previous_y=0, previous_t=0;
    bool tracking=false;
    std::vector<std::int64_t> cycle_t, cycle_y, beat_times;
    std::vector<beat_features> beats;
    std::uint64_t rejected_beats=0;
};
struct beat_output {
    bool emitted=false;
    std::int64_t crossing_time=0;
    beat_features features{};
};

// Downstream of accepted-sample preprocessing. Whole-cycle storage preserves
// the existing MATLAB algorithm. No frame checks, SQI, regression or bus.
class beat_extractor {
public:
    explicit beat_extractor(beat_config config) : config_(config) {
        const bool format=(config.signal_f==0 && config.time_f==0 && config.feature_f==8) ||
            (config.signal_f==8 && config.time_f==8 && config.feature_f==16) ||
            (config.signal_f==10 && config.time_f==10 && config.feature_f==18);
        if (!format || config.tick_period_ns<1 || config.tick_period_ns>1000000000 ||
            config.min_period<0 || config.max_period<config.min_period || config.max_period_ticks<1 ||
            config.max_period_ticks>=(std::int64_t{1}<<47) || config.beats_per_result<1 ||
            config.beats_per_result>64 || config.cycle_capacity<2 || config.cycle_capacity>65536)
            throw std::invalid_argument("unsupported beat reference configuration");
    }
    const beat_state& state() const noexcept { return state_; }
    void clear_history() { state_={}; } // Arithmetic fault lifetime belongs to caller.
    void clear_window() {
        state_.beats.clear(); state_.beat_times.clear(); state_.rejected_beats=0;
    } // Preserve the causal filter/beat cycle and caller-owned arithmetic faults.
    // The channel initializes previous_t on its first ADC sample, before warmup.
    void initialize_time(std::int64_t t) { validate_time(t); state_.previous_t=t; }

    beat_output step(std::int64_t y,std::int64_t dc,std::int64_t t,bool warmup,integer_math& q) {
        validate_time(t);
        const auto top=std::int64_t{1}<<(25+config_.signal_f);
        if (y < -top || y>=top || dc < -top || dc>=top)
            throw std::invalid_argument("beat input outside preprocessed signal format");
        beat_output out;
        if (warmup) { state_.previous_y=y; state_.previous_t=t; return out; }
        if (state_.previous_y<=0 && y>0) {
            const auto offset=q.divide(q.mul(-state_.previous_y,t-state_.previous_t),y-state_.previous_y);
            const auto tc=q.clip(state_.previous_t+offset,48,true);
            if (state_.tracking) {
                state_.cycle_t.push_back(tc); state_.cycle_y.push_back(0);
                const auto period=tc-state_.cycle_t.front();
                const auto peak_it=std::max_element(state_.cycle_y.begin(),state_.cycle_y.end());
                const auto peak=*peak_it;
                const auto ip=static_cast<std::size_t>(peak_it-state_.cycle_y.begin());
                const auto minimum=*std::min_element(state_.cycle_y.begin(),state_.cycle_y.end());
                const auto amplitude=q.clip(peak-minimum,26+config_.signal_f,true);
                auto sec_n=q.mul(period,config_.tick_period_ns);
                sec_n=q.rescale(sec_n,config_.time_f,config_.feature_f);
                const auto period_s=q.clip(q.divide(sec_n,1000000000),4+config_.feature_f,true);
                if (period>0 && period_s>=config_.min_period && period_s<=config_.max_period && peak>0 && dc>0) {
                    const auto scale=std::int64_t{1}<<config_.feature_f;
                    const auto rise=q.divide(q.mul(state_.cycle_t[ip]-state_.cycle_t.front(),scale),period);
                    std::vector<std::int64_t> norm;
                    for (const auto value:state_.cycle_y) norm.push_back(q.divide(q.mul(std::max(value,std::int64_t{0}),scale),peak));
                    std::int64_t width_sum=0,area_sum=0;
                    for (std::size_t j=0;j+1<state_.cycle_t.size();++j) {
                        const auto dt=state_.cycle_t[j+1]-state_.cycle_t[j];
                        const std::int64_t mask=(2*state_.cycle_y[j]>=peak?1:0)+(2*state_.cycle_y[j+1]>=peak?1:0);
                        width_sum=q.add(width_sum,q.mul(dt,mask));
                        area_sum=q.add(area_sum,q.mul(dt,norm[j]+norm[j+1]));
                    }
                    const auto width=q.divide(q.mul(width_sum,scale),2*period);
                    const auto area=q.divide(area_sum,2*period);
                    const auto ratio=q.divide(q.mul(amplitude,scale),dc);
                    out={true,tc,{period_s,rise,width,area,ratio}};
                    for (auto& value:out.features) value=q.clip(value,4+config_.feature_f,true);
                    state_.beats.push_back(out.features); state_.beat_times.push_back(tc);
                    if (state_.beats.size()>config_.beats_per_result) {
                        state_.beats.erase(state_.beats.begin()); state_.beat_times.erase(state_.beat_times.begin());
                    }
                } else ++state_.rejected_beats;
            }
            state_.tracking=true; state_.cycle_t={tc}; state_.cycle_y={0};
        }
        if (state_.tracking) {
            state_.cycle_t.push_back(t); state_.cycle_y.push_back(y);
            // MATLAB appends first, then rejects strictly beyond either bound.
            if (t-state_.cycle_t.front()>config_.max_period_ticks || state_.cycle_t.size()>config_.cycle_capacity) {
                state_.tracking=false; state_.cycle_t.clear(); state_.cycle_y.clear(); ++state_.rejected_beats;
            }
        }
        state_.previous_y=y; state_.previous_t=t;
        return out;
    }
private:
    static void validate_time(std::int64_t t) {
        const auto top=std::int64_t{1}<<47;
        if (t < -top || t>=top) throw std::invalid_argument("beat time outside signed 48-bit format");
    }
    beat_config config_;
    beat_state state_;
};
} // namespace bppe
