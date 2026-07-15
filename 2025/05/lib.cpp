#include <cstdint>
#include <print>
#include <set>
#include <string>
#include <vector>

uint64_t first(std::vector<std::string> data) {
    std::set<std::pair<uint64_t, uint64_t>> ranges = {};
    uint64_t result = 0;

    for (auto line : data) {
        if (line == "") continue;
        auto pos = line.find("-");
        switch (pos) {
            case std::string::npos: {
                uint64_t i = std::stoull(line);
                for (auto [p, q] : ranges)
                    if (p <= i and i <= q) {
                        result++;
                        goto escape;
                    }
            }

            default: {
                uint64_t p = std::stoull(line.substr(0, pos));
                uint64_t q = std::stoull(line.substr(pos + 1));
                ranges.insert({p, q});
            }
        }

    escape:
    }

    return result;
}

uint64_t second(std::vector<std::string> data) {
    std::set<std::pair<uint64_t, uint64_t>> ranges = {};
    uint64_t result = 0;

    for (auto line : data) {
        if (line == "") break;
        auto pos = line.find("-");

        uint64_t p = std::stoull(line.substr(0, pos));
        uint64_t q = std::stoull(line.substr(pos + 1));

        std::set<std::pair<uint64_t, uint64_t>> remove = {};
        std::pair<uint64_t, uint64_t> interval = {p, q};

        for (auto [a, b] : ranges) {
            auto [x, y] = interval;

            bool overlaps = (a <= y) and (x <= b);
            if (overlaps) {
                interval.first = std::min(a, x);
                interval.second = std::max(b, y);
                remove.insert({a, b});
            }
        }

        for (auto r : remove) ranges.erase(r);
        ranges.insert(interval);
    }

    for (auto [p, q] : ranges) result += q - p + 1;
    return result;
}
