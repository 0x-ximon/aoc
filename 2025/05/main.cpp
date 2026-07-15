#include <fstream>
#include <print>
#include <string>
#include <vector>

#include "lib.cpp"

int main() {
    std::fstream f("input.txt");
    if (!f.is_open()) {
        std::print("Could not open file");
        return 0;
    }

    std::string buffer;
    std::vector<std::string> data;
    while (std::getline(f, buffer)) data.push_back(buffer);

    uint64_t first_answer = first(data);
    std::println("First Answer: {}", first_answer);

    uint64_t second_answer = second(data);
    std::println("Second Answer: {}", second_answer);
}
