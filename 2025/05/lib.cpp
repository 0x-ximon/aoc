#include <cstdint>
#include <print>
#include <set>
#include <string>
#include <vector>

int first(std::vector<std::string> data) {
    std::set<std::pair<uint64_t, uint64_t>> s = {};
    std::vector<uint64_t> v = {};
    int result = 0;

    for (auto line : data) {
        if (line == "") continue;
        auto pos = line.find("-");
        switch (pos) {
            case std::string::npos: {
                uint64_t i = std::stoull(line);
                for (auto [p, q] : s)
                    if (p <= i and i <= q) {
                        result++;
                        goto escape;
                    }
            }

            default: {
                uint64_t p = std::stoull(line.substr(0, pos));
                uint64_t q = std::stoull(line.substr(pos + 1));
                s.insert({p, q});
            }
        }

    escape:
    }

    return result;
}

int second(std::vector<std::string> data) { return 0; }
