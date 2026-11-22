#pragma once

#include <array>
#include <cstdint>
#include <stdexcept>

namespace bppe {

struct frame_config {
    std::uint32_t channels, min_delta, max_delta, max_abs_skew;
};
// Normalized complete frame; structural/NaN validation belongs to the caller.
// config_error represents the existing host configuration-mismatch decision.
struct input_frame {
    std::array<std::uint32_t,3> adc{}, timestamp{};
    std::uint16_t sequence=0;
    std::uint8_t gain=0, optical=0, valid=0, saturated=0;
    bool gain_transition=false, config_error=false;
};
struct frame_state {
    bool have_frame=false;
    std::array<std::uint32_t,3> last_timestamp{};
    std::uint16_t last_sequence=0, faults=0;
    std::uint8_t last_gain=0, last_optical=0;
    std::int64_t elapsed_ticks=0;
};
struct frame_decision {
    bool accepted=false, history_reset=false;
    std::uint16_t reason=0, faults=0;
    // Only accepted frames carry channel samples; inactive entries stay zero.
    std::array<std::int64_t,3> channel_ticks{};
};

// Running-session transaction reference. No bus, queue, CDC, publication or
// cycle timing. Tick bounds are encoded by bppe_frame_tick_bounds in MATLAB.
class frame_validator {
public:
    static constexpr std::uint16_t low_sqi=1, sample_gap=2, adc_saturated=4,
        timestamp_error=8, config_error=1024;
    explicit frame_validator(frame_config config) : config_(config) {
        if (config.channels<1 || config.channels>3 || config.min_delta<1 ||
            config.min_delta>config.max_delta || config.max_delta>=0x80000000U ||
            config.max_abs_skew>0x80000000U)
            throw std::invalid_argument("unsupported frame tick/channel configuration");
    }
    const frame_state& state() const noexcept { return state_; }
    void reset() noexcept { state_={}; } // Retain static configuration.

    frame_decision step(const input_frame& input) {
        // C++ containers are wider than the RTL ports. Reject malformed host
        // calls before changing state; these exceptions are not wire faults.
        for (const auto value:input.adc)
            if (value>0xffffffU) throw std::invalid_argument("ADC outside 24-bit port");
        if (input.valid>7 || input.saturated>7)
            throw std::invalid_argument("channel mask outside three-bit port");

        const auto mask=static_cast<std::uint8_t>((1U<<config_.channels)-1U);
        std::array<std::int64_t,3> skew{};
        std::array<std::uint32_t,3> delta{};
        bool bad_skew=false,bad_delta=false;
        for (std::uint32_t c=0;c<config_.channels;++c) {
            const auto wrapped=static_cast<std::uint32_t>(input.timestamp[c]-input.timestamp[0]);
            // Avoid implementation-defined unsigned-to-signed narrowing.
            skew[c]=wrapped<0x80000000U?static_cast<std::int64_t>(wrapped):
                static_cast<std::int64_t>(wrapped)-4294967296LL;
            const auto magnitude=skew[c]<0?-skew[c]:skew[c];
            bad_skew=bad_skew || magnitude>config_.max_abs_skew;
            delta[c]=static_cast<std::uint32_t>(input.timestamp[c]-state_.last_timestamp[c]);
            bad_delta=bad_delta || delta[c]==0 || delta[c]>=0x80000000U ||
                delta[c]<config_.min_delta || delta[c]>config_.max_delta;
        }
        std::uint16_t reason=0;
        if (input.config_error) reason=config_error;
        else if ((input.valid&mask)!=mask) reason=sample_gap;
        else if ((input.saturated&mask)!=0) reason=adc_saturated;
        else if (bad_skew) reason=timestamp_error;
        else if (input.gain_transition || (state_.have_frame &&
            (input.gain!=state_.last_gain || input.optical!=state_.last_optical))) reason=low_sqi;
        else if (state_.have_frame && static_cast<std::uint16_t>(input.sequence-state_.last_sequence)!=1)
            reason=sample_gap;
        else if (state_.have_frame && bad_delta) reason=timestamp_error;

        frame_decision out;
        out.reason=reason;
        if (reason!=0) {
            const auto faults=static_cast<std::uint16_t>(state_.faults|reason);
            out.history_reset=reason!=config_error;
            if (out.history_reset) state_={};
            state_.faults=faults; out.faults=faults;
            return out;
        }
        // Same deliberately bounded exact-host domain as the current RTL
        // adapter. This is not a newly selected product session-duration limit.
        if (state_.elapsed_ticks>9007194959773695LL)
            throw std::overflow_error("elapsed ticks outside audited exact host domain");
        if (state_.have_frame) state_.elapsed_ticks+=delta[0];
        state_.have_frame=true;
        state_.last_timestamp=input.timestamp; state_.last_sequence=input.sequence;
        state_.last_gain=input.gain; state_.last_optical=input.optical;
        out.accepted=true; out.faults=state_.faults;
        for (std::uint32_t c=0;c<config_.channels;++c)
            out.channel_ticks[c]=state_.elapsed_ticks+skew[c];
        return out;
    }
private:
    frame_config config_;
    frame_state state_;
};
} // namespace bppe
