#include "bppe/causal_preprocessor.hpp"

#include <iostream>
#include <stdexcept>

namespace {
void require(bool value,const char* message) {
    if (!value) throw std::runtime_error(message);
}
} // namespace

int main() {
    try {
        const bppe::preprocess_config half{0,8,0,128,128};
        bppe::integer_math math;
        bppe::causal_preprocessor filter(half);
        require(!filter.state().initialized,"initial state");
        auto out=filter.step(8,0,math);
        require(out.state.dc==8 && out.state.filtered==0 && out.sample_time==0,"first sample initializes DC");
        out=filter.step(12,10,math);
        require(out.state.dc==10 && out.state.filtered==1,"staged positive update");
        out=filter.step(4,20,math);
        require(out.state.dc==7 && out.state.filtered==-1,"staged negative update");
        require(!math.status.failed(),"unexpected filter fault");

        const auto maximum_time=(std::int64_t{1}<<47)-1;
        out=filter.step(4,maximum_time+1,math);
        require(out.sample_time==maximum_time && math.status.saturations==1,"time saturation");
        filter.clear_history();
        require(!filter.state().initialized && math.status.saturations==1,"partial clear retains numeric fault");
        out=filter.step(123,0,math);
        require(out.state.dc==123 && out.state.filtered==0 && math.status.failed(),"fault remains latched");
        math={}; filter.clear_history();
        out=filter.step(123,0,math);
        require(!math.status.failed() && out.state.dc==123,"explicit numeric/history reset");

        bppe::causal_preprocessor zero({8,18,8,0,0});
        zero.step(1000,0,math);
        out=zero.step(2000,10,math);
        require(out.state.dc==256000 && out.state.filtered==0,"zero quantized coefficients");
        bppe::causal_preprocessor a(half),b(half);
        a.step(100,0,math); b.step(900,0,math);
        a.step(200,10,math); out=b.step(900,10,math);
        require(out.state.dc==900 && out.state.filtered==0,"independent channel histories");

        const auto before=filter.state();
        const auto counters=math.status;
        bool rejected=false;
        try { filter.step(std::uint32_t{1}<<24,0,math); }
        catch (const std::invalid_argument&) { rejected=true; }
        require(rejected && filter.state().dc==before.dc && filter.state().filtered==before.filtered &&
            math.status.saturations==counters.saturations && math.status.precision==counters.precision,
            "out-of-domain ADC rejected before state mutation");
        rejected=false;
        try { bppe::causal_preprocessor invalid({8,8,8,1,1}); }
        catch (const std::invalid_argument&) { rejected=true; }
        require(rejected,"unsupported format rejected");
        std::cout << "CAUSAL_PREPROCESSOR_PROPERTIES_PASSED\n";
    } catch (const std::exception& error) {
        std::cerr << error.what() << '\n'; return 1;
    }
}
