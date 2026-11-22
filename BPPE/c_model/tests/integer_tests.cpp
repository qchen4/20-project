#include "bppe/integer_math.hpp"

#include <array>
#include <cstdint>
#include <iostream>
#include <limits>
#include <random>
#include <stdexcept>

namespace {
using wide = __int128_t; // Test oracle only; production header is standard C++17.
std::uint64_t checks = 0;

void require(bool condition, const char* message) {
    ++checks;
    if (!condition) throw std::runtime_error(message);
}

wide abs_wide(wide value) { return value < 0 ? -value : value; }

void division_case(std::int64_t n, std::int64_t d) {
    bppe::integer_math math;
    const auto result = math.divide(n, d);
    if (d == 0) {
        require(result == 0 && math.status.divzero == 1 && math.status.precision == 0,
                "division-by-zero contract");
    } else if (abs_wide(n) > math.limit || abs_wide(d) > math.limit) {
        require(result == 0 && math.status.precision == 1, "division range guard");
    } else {
        // Rational distance, independent of the quotient/remainder implementation.
        const wide distance_twice = 2 * abs_wide(wide{n} - wide{result} * d);
        require(distance_twice <= abs_wide(d), "nearest division property");
        if (distance_twice == abs_wide(d)) {
            require(abs_wide(wide{result} * d) > abs_wide(n), "ties away from zero");
        }
        require(!math.status.failed(), "unexpected division fault");
    }
}

void arithmetic_case(std::int64_t a, std::int64_t b) {
    const wide ua = abs_wide(a), ub = abs_wide(b);
    bppe::integer_math add, mul;
    const bool add_fault = ua + ub > add.limit;
    const bool mul_fault = ua * (ub > 0 ? ub : 1) > mul.limit;
    require(add.add(a,b) == (add_fault ? 0 : static_cast<std::int64_t>(wide{a}+b)), "add value");
    require(add.status.precision == static_cast<std::uint64_t>(add_fault), "add guard");
    require(mul.mul(a,b) == (mul_fault ? 0 : static_cast<std::int64_t>(wide{a}*b)), "multiply value");
    require(mul.status.precision == static_cast<std::uint64_t>(mul_fault), "multiply guard");
}

void sqrt_case(std::int64_t n) {
    bppe::integer_math math;
    const auto result = math.sqrt_nearest(n);
    if (n < 0 || n > math.limit) {
        require(result == 0 && math.status.precision == 1, "sqrt range guard");
        return;
    }
    const wide square = wide{result} * result;
    // Integer form of (r-0.5)^2 <= n < (r+0.5)^2.
    require(result >= 0 && wide{n} <= square + result, "sqrt upper rounding boundary");
    require(result == 0 || wide{n} >= square - result + 1, "sqrt lower rounding boundary");
    require(!math.status.failed(), "unexpected sqrt fault");
}
} // namespace

int main() {
    try {
        constexpr auto limit = bppe::integer_math::limit;
        constexpr std::array<std::int64_t,17> edges = {
            std::numeric_limits<std::int64_t>::min(), -limit-1, -limit, -limit+1,
            -(std::int64_t{1}<<52), -257, -3, -1, 0, 1, 3, 257,
            std::int64_t{1}<<52, limit-1, limit, limit+1,
            std::numeric_limits<std::int64_t>::max()};
        for (const auto a : edges) for (const auto b : edges) {
            division_case(a,b); arithmetic_case(a,b);
        }
        for (std::int64_t n=-257; n<=257; ++n)
            for (std::int64_t d=-65; d<=65; ++d) division_case(n,d);
        for (std::int64_t n=-1; n<=10000; ++n) sqrt_case(n);
        std::mt19937_64 random(20261106);
        for (int i=0; i<10000; ++i) {
            const auto n = static_cast<std::int64_t>(random() % static_cast<std::uint64_t>(limit+1));
            const auto d = static_cast<std::int64_t>(random() % static_cast<std::uint64_t>(limit+1));
            division_case(n,d); division_case(-n,d); sqrt_case(n);
        }
        for (const int width : {1,8,16,34,52}) for (const bool sign : {false,true}) {
            const auto top = std::int64_t{1} << (sign ? width-1 : width);
            const auto lo = sign ? -top : 0;
            const auto hi = top-1;
            for (const auto n : edges) {
                bppe::integer_math math;
                const auto expected = n<lo ? lo : (n>hi ? hi : n);
                require(math.clip(n,width,sign)==expected,"clip value");
                require(math.status.saturations==static_cast<std::uint64_t>(n<lo || n>hi),"clip counter");
            }
        }
        bppe::integer_math math;
        require(math.rescale(-5,1,0)==-3,"rescale negative tie");
        require(math.rescale(limit,0,1)==0 && math.status.precision==1,"rescale overflow");
        math.divide(1,0); math.clip(128,8,true);
        require(math.status.failed() && math.status.divzero==1 && math.status.saturations==1,
                "faults accumulate independently");
        bool threw=false;
        try { math.clip(0,53,true); } catch (const std::invalid_argument&) { threw=true; }
        require(threw,"invalid width rejected");
        std::cout << "INTEGER_PROPERTIES_PASSED checks=" << checks << '\n';
    } catch (const std::exception& error) {
        std::cerr << error.what() << '\n'; return 1;
    }
}
