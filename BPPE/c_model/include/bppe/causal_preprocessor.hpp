#pragma once

#include "bppe/integer_math.hpp"

namespace bppe {

struct preprocess_config {
    int signal_f;
    int coefficient_f;
    int time_f;
    std::int64_t dc_coefficient;
    std::int64_t lowpass_coefficient;

    bool operator==(const preprocess_config& other) const noexcept {
        return signal_f==other.signal_f && coefficient_f==other.coefficient_f &&
            time_f==other.time_f && dc_coefficient==other.dc_coefficient &&
            lowpass_coefficient==other.lowpass_coefficient;
    }
};

struct preprocess_state {
    bool initialized = false;
    std::int64_t dc = 0;
    std::int64_t filtered = 0;
};

struct preprocess_output {
    std::int64_t sample_time;
    preprocess_state state;
};

// Accepted ADC samples and elapsed ticks only: no frame/bus protocol or beats.
// Pass the same arithmetic instance across channels in the MATLAB call order.
class causal_preprocessor {
public:
    explicit causal_preprocessor(preprocess_config config) : config_(config) {
        const bool compact=config.signal_f==0 && config.coefficient_f==8 && config.time_f==0;
        const bool balanced=config.signal_f==8 && config.coefficient_f==18 && config.time_f==8;
        const bool wide=config.signal_f==10 && config.coefficient_f==18 && config.time_f==10;
        if (!compact && !balanced && !wide)
            throw std::invalid_argument("expected an existing compact/balanced/wide format");
        const auto denominator=std::int64_t{1}<<config.coefficient_f;
        if (config.dc_coefficient<0 || config.dc_coefficient>=denominator ||
            config.lowpass_coefficient<0 || config.lowpass_coefficient>=denominator)
            throw std::invalid_argument("filter coefficient code outside [0,1)");
    }

    const preprocess_state& state() const noexcept { return state_; }
    void clear_history() noexcept { state_={}; } // Caller-owned numeric faults persist.

    preprocess_output step(std::uint32_t adc, std::int64_t ticks, integer_math& math) {
        if (adc>((std::uint32_t{1}<<24)-1U))
            throw std::invalid_argument("preprocessor accepts already-validated 24-bit ADC samples");
        const int width=26+config_.signal_f;
        const auto time=math.clip(math.mul(ticks,std::int64_t{1}<<config_.time_f),48,true);
        const auto raw=math.mul(adc,std::int64_t{1}<<config_.signal_f);
        if (!state_.initialized) {
            state_.dc=raw;
            state_.initialized=true;
        }
        auto delta=math.clip(raw-state_.dc,width,true);
        auto increment=math.rescale(math.mul(config_.dc_coefficient,delta),config_.coefficient_f,0);
        state_.dc=math.clip(math.add(state_.dc,increment),width,true);
        const auto ac=math.clip(raw-state_.dc,width,true);
        delta=math.clip(ac-state_.filtered,width,true);
        increment=math.rescale(math.mul(config_.lowpass_coefficient,delta),config_.coefficient_f,0);
        state_.filtered=math.clip(math.add(state_.filtered,increment),width,true);
        return {time,state_};
    }

private:
    preprocess_config config_;
    preprocess_state state_;
};

} // namespace bppe
