#include <print>
#include <string>
#include <vector>

#include "lib.cpp"

void assert(int expected, int actual) {
    if (expected == actual)
        std::println("Assertion Passed.");
    else
        std::println("Assertion Failed; expected: {}, actual: {}", expected, actual);
}

int main() {
    std::vector<std::string> data = {
        "3-5", "10-14", "16-20", "12-18", "", "1", "5", "8", "11", "17", "32",
    };

    uint64_t first_expected = 3;
    uint64_t first_result = first(data);
    assert(first_expected, first_result);

    uint64_t second_expected = 14;
    uint64_t second_result = second(data);
    assert(second_expected, second_result);
}
