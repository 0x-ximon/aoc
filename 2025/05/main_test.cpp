#include <print>
#include <string>
#include <vector>

#include "lib.cpp"

void assert(int expected, int actual) {
    if (expected == actual)
        std::println("Assertion Passed.");

    else
        std::println("Assertion Failed; expected: {}, actual: {} ", expected, actual);
}

int main() {
    std::vector<std::string> data = {
        "3-5", "10-14", "16-20", "12-18", "", "1", "5", "8", "11", "17", "32",
    };

    auto first_expected = 3;
    auto first_result = first(data);
    assert(first_expected, first_result);
}
