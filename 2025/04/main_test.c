#include <stddef.h>
#include <stdio.h>

#include "lib.c"

void assert(int expected, int actual) {
    if (expected == actual)
        printf("Assertion Passed.\n");
    else
        printf("Assertion Failed; expected: %d, actual: %d\n", expected, actual);
}

int main() {
    size_t m = 10;
    size_t n = 10;

    const char* data[10] = {
        "..@@.@@@@.", "@@@.@.@.@@", "@@@@@.@.@@", "@.@@@@..@.", "@@.@@@@.@@",
        ".@@@@@@@.@", ".@.@.@.@@@", "@.@@@.@@@@", ".@@@@@@@@.", "@.@.@@@.@.",
    };

    uint64_t first_expected = 13;
    uint64_t first_actual = first(data, n);
    assert(first_expected, first_actual);

    uint64_t second_expected = 43;
    uint64_t second_actual = second(data, n);
    assert(second_expected, second_actual);
}
