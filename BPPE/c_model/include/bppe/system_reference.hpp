#pragma once
#include "bppe/frame_validator.hpp"
#include "bppe/causal_preprocessor.hpp"
#include "bppe/measurement.hpp"
#include <utility>

namespace bppe {
struct system_config {
    frame_config frame;
    preprocess_config preprocess;
    beat_config beat;
    measurement_config measurement;
    std::int64_t warmup_ticks=0,timeout_ticks=1,initial_deadline_ticks=1;
    faults initial_faults{};
};
struct system_result {
    std::uint16_t sequence=0;
    std::uint32_t tag=0,timestamp=0;
    measurement_output measurement;
};
struct system_step {
    bool accepted=false,published=false;
    std::uint16_t reasons=0;
    std::optional<system_result> candidate;
};

// Atomic running-session M1 reference, not a cycle/bus/lifecycle model.
// Call ack separately before/after step; no simultaneous-event priority is
// represented. Configuration is immutable; reset means coordinated runtime
// initialization into a ready running session, like the numerical RTL boundary.
class system_reference {
public:
    explicit system_reference(system_config config) : config_(std::move(config)),adapter_(config_.frame) {
        if(config_.preprocess.signal_f!=config_.beat.signal_f ||
            config_.preprocess.time_f!=config_.beat.time_f ||
            config_.beat.feature_f!=config_.measurement.feature_f ||
            config_.beat.beats_per_result!=config_.measurement.beats_per_result ||
            config_.beat.cycle_capacity!=304 || config_.warmup_ticks<0 ||
            config_.timeout_ticks<1 || config_.initial_deadline_ticks<0 ||
            config_.warmup_ticks>integer_math::limit || config_.timeout_ticks>integer_math::limit ||
            config_.initial_deadline_ticks>integer_math::limit ||
            config_.initial_faults.saturations>static_cast<std::uint64_t>(integer_math::limit) ||
            config_.initial_faults.divzero>static_cast<std::uint64_t>(integer_math::limit) ||
            config_.initial_faults.precision>static_cast<std::uint64_t>(integer_math::limit))
            throw std::invalid_argument("unsupported system profile/timing/initial faults");
        // Reuse encoded model validation with disposable arithmetic; host seed
        // faults are supplied explicitly and must not be recomputed here.
        integer_math validate;
        measure_window(std::vector<channel_window>(config_.frame.channels),config_.measurement,validate);
        for(std::uint32_t c=0;c<config_.frame.channels;++c) {
            filters_.emplace_back(config_.preprocess);beats_.emplace_back(config_.beat);
        }
        reset();
    }
    void reset() {
        adapter_.reset();clear_dsp_history();math_.status=config_.initial_faults;
        deadline_=config_.initial_deadline_ticks;pending_=false;snapshot_.reset();counter_=0;flags_=0;
    }
    void ack() noexcept {pending_=false;} // Snapshot and sticky faults retained.
    bool pending() const noexcept {return pending_;}
    const std::optional<system_result>& snapshot() const noexcept {return snapshot_;}
    std::uint16_t result_counter() const noexcept {return counter_;}
    std::uint16_t fault_flags() const noexcept {return flags_;}
    std::int64_t deadline_ticks() const noexcept {return deadline_;}
    const frame_state& acquisition_state() const noexcept {return adapter_.state();}
    const faults& numeric_faults() const noexcept {return math_.status;}
    const beat_state& channel_state(std::size_t c) const {return beats_.at(c).state();}
    const preprocess_state& filter_state(std::size_t c) const {return filters_.at(c).state();}

    system_step step(const input_frame& input,std::uint32_t tag) {
        auto next_adapter=adapter_;
        const auto decision=next_adapter.step(input);
        // Stay inside the existing export's exact-integer host domain; this
        // guard is not a physical session-duration or product timing policy.
        if(decision.accepted && next_adapter.state().elapsed_ticks>integer_math::limit-config_.timeout_ticks)
            throw std::overflow_error("system deadline outside audited exact host domain");
        adapter_=next_adapter;
        system_step out;out.accepted=decision.accepted;
        if(!decision.accepted) {
            out.reasons=decision.reason;flags_=static_cast<std::uint16_t>(flags_|out.reasons);
            if(decision.history_reset) {clear_dsp_history();deadline_=config_.initial_deadline_ticks;}
            // MATLAB returns immediately on frame rejection: numeric faults
            // persist, but are not appended to this frame's rejection reason.
            return out;
        }
        bool enough=true;
        for(std::uint32_t c=0;c<config_.frame.channels;++c) {
            const bool initial=!filters_[c].state().initialized;
            const auto p=filters_[c].step(input.adc[c],decision.channel_ticks[c],math_);
            if(initial)beats_[c].initialize_time(p.sample_time);
            beats_[c].step(p.state.filtered,p.state.dc,p.sample_time,
                decision.channel_ticks[c]<config_.warmup_ticks,math_);
            enough=enough && beats_[c].state().beats.size()>=config_.measurement.beats_per_result;
        }
        const auto elapsed=adapter_.state().elapsed_ticks;
        if(enough || elapsed>=deadline_) {
            std::vector<channel_window> windows;
            for(const auto& beat:beats_)windows.push_back({beat.state().beats,beat.state().rejected_beats});
            counter_=static_cast<std::uint16_t>(counter_+1U);
            std::int64_t latest_skew=0;
            for(std::uint32_t c=0;c<config_.frame.channels;++c)
                latest_skew=std::max(latest_skew,decision.channel_ticks[c]-elapsed);
            system_result candidate;
            candidate.sequence=counter_;candidate.tag=tag;
            candidate.timestamp=static_cast<std::uint32_t>(static_cast<std::uint64_t>(input.timestamp[0])+
                static_cast<std::uint64_t>(latest_skew));
            candidate.measurement=measure_window(windows,config_.measurement,math_);
            out.candidate=candidate;
            if(pending_)out.reasons=512;
            else {snapshot_=candidate;pending_=true;out.published=true;}
            // Keep current causal cycles while clearing completed observations.
            for(auto& beat:beats_)beat.clear_window();
            deadline_=elapsed+config_.timeout_ticks;
        }
        if(math_.status.failed())out.reasons=static_cast<std::uint16_t>(out.reasons|64U);
        if(math_.status.divzero>0)out.reasons=static_cast<std::uint16_t>(out.reasons|128U);
        flags_=static_cast<std::uint16_t>(flags_|out.reasons);
        return out;
    }
private:
    void clear_dsp_history() {
        for(auto& filter:filters_)filter.clear_history();
        for(auto& beat:beats_)beat.clear_history();
    }
    system_config config_;
    frame_validator adapter_;
    std::vector<causal_preprocessor> filters_;
    std::vector<beat_extractor> beats_;
    integer_math math_;
    std::int64_t deadline_=0;
    bool pending_=false;
    std::optional<system_result> snapshot_;
    std::uint16_t counter_=0,flags_=0;
};
} // namespace bppe
