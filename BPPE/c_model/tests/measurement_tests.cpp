#include "bppe/measurement.hpp"
#include <iostream>
int main() {
    try {
        auto check=[](bool b){if(!b) throw std::runtime_error("measurement property failure");};
        bppe::measurement_config c; c.feature_f=8;c.regression_f=8;
        c.min_amplitude=1;c.max_amplitude=51;c.max_cv=51;
        c.configured=true;c.calibrated=true;c.allow_demo=true;c.scale.fill(256);
        c.beta[0]={120*256,80*256};c.bp_min={40*256,20*256};c.bp_max={260*256,180*256};
        const bppe::beat_features beat{205,64,84,77,10};
        std::vector<bppe::channel_window> windows(1); windows[0].beats.assign(4,beat);
        bppe::integer_math q; const auto good=bppe::measure_window(windows,c,q);
        check(good.valid && good.reasons==0 && good.sqi==255 && good.features==beat);
        check(good.pressure_raw==std::array<std::int64_t,2>{30720,20480});
        check(good.pressure_codes==std::array<std::uint16_t,2>{15360,10240} && !q.status.failed());
        windows[0].rejected=12;
        const auto rejected=bppe::measure_window(windows,c,q);
        check(!rejected.valid && rejected.sqi==64 && rejected.reasons==1 && rejected.has_features);
        check(rejected.pressure_codes==std::array<std::uint16_t,2>{0,0});
        windows.push_back({});
        const auto partial=bppe::measure_window(windows,c,q);
        check(!partial.valid && partial.reasons==17 && partial.has_features && partial.channel_sqi[1]==0);
        windows.resize(1); windows[0].rejected=0; c.scale[0]=0;
        const auto zero=bppe::measure_window(windows,c,q);
        check(!zero.valid && (zero.reasons&192)==192 && q.status.divzero==1);
        bppe::beat_extractor extractor({0,0,8,1000000,90,384,1500,304,4});
        extractor.step(0,10000,0,false,q);extractor.step(100,10000,200,false,q);
        extractor.step(0,10000,400,false,q);extractor.step(-100,10000,600,false,q);
        extractor.step(0,10000,800,false,q);extractor.step(100,10000,1000,false,q);
        const auto cycle=extractor.state().cycle_t;
        check(extractor.state().beats.size()==1);
        extractor.clear_window();
        check(extractor.state().tracking && extractor.state().cycle_t==cycle && extractor.state().beats.empty() &&
            extractor.state().beat_times.empty() && extractor.state().rejected_beats==0 && q.status.divzero==1);
        std::cout<<"MEASUREMENT_PROPERTIES_PASSED\n";
    } catch(const std::exception& e) {std::cerr<<e.what()<<'\n';return 1;}
}
