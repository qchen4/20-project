#pragma once

#include <algorithm>
#include <cstdint>
#include <stdexcept>

namespace bppe {

struct faults {
    std::uint64_t saturations = 0;
    std::uint64_t divzero = 0;
    std::uint64_t precision = 0;
    bool failed() const noexcept { return saturations != 0 || divzero != 0 || precision != 0; }
};

// Scalar DSP arithmetic only. Preserve MATLAB's conservative exact-double
// bounds even when the C++ container could represent a larger result.
class integer_math {
public:
    static constexpr std::int64_t limit = (std::int64_t{1} << 53) - 1;
    faults status;

    static std::uint64_t magnitude(std::int64_t value) noexcept {
        return value < 0 ? static_cast<std::uint64_t>(-(value + 1)) + 1U
                         : static_cast<std::uint64_t>(value);
    }

    std::int64_t add(std::int64_t a, std::int64_t b) noexcept {
        const auto ua = magnitude(a), ub = magnitude(b);
        if (ub > bound || ua > bound - ub) {
            ++status.precision;
            return 0;
        }
        return a + b;
    }

    std::int64_t mul(std::int64_t a, std::int64_t b) noexcept {
        if (magnitude(a) > bound / std::max(magnitude(b), std::uint64_t{1})) {
            ++status.precision;
            return 0;
        }
        return a * b;
    }

    std::int64_t divide(std::int64_t n, std::int64_t d) noexcept {
        // MATLAB tests zero first, even when the numerator is out of range.
        if (d == 0) {
            ++status.divzero;
            return 0;
        }
        const auto a = magnitude(n), b = magnitude(d);
        if (a > bound || b > bound) {
            ++status.precision;
            return 0;
        }
        auto value = a / b;
        if (a % b >= (b + 1U) / 2U) ++value;
        const auto signed_value = static_cast<std::int64_t>(value);
        return (n < 0) != (d < 0) ? -signed_value : signed_value;
    }

    std::int64_t clip(std::int64_t raw, int width, bool is_signed) {
        if (width < 1 || width > 52) throw std::invalid_argument("width must be in [1,52]");
        const auto top = std::int64_t{1} << (is_signed ? width - 1 : width);
        const auto lo = is_signed ? -top : 0;
        const auto hi = top - 1;
        if (raw < lo || raw > hi) ++status.saturations;
        return std::min(std::max(raw, lo), hi);
    }

    std::int64_t rescale(std::int64_t raw, int from_f, int to_f) {
        if (from_f < 0 || from_f > 52 || to_f < 0 || to_f > 52)
            throw std::invalid_argument("fractional bits must be in [0,52]");
        if (to_f >= from_f) return mul(raw, std::int64_t{1} << (to_f - from_f));
        return divide(raw, std::int64_t{1} << (from_f - to_f));
    }

    std::int64_t sqrt_nearest(std::int64_t n) noexcept {
        if (n < 0 || n > limit) {
            ++status.precision;
            return 0;
        }
        std::int64_t lo = 0, hi = std::min(n, std::int64_t{94906265});
        while (lo < hi) {
            const auto mid = (lo + hi + 1) / 2;
            if (mid * mid <= n) lo = mid;
            else hi = mid - 1;
        }
        if (n - lo * lo >= lo + 1) ++lo;
        return lo;
    }

private:
    static constexpr auto bound = static_cast<std::uint64_t>(limit);
};

} // namespace bppe
