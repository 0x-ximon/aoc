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
    size_t n = 8;
    const char* data[8] = {"7,1", "11,1", "11,7", "9,7", "9,5", "2,5", "2,3", "7,3"};

    uint64_t first_expected = 50;
    uint64_t first_result = first(data, n);
    assert(first_expected, first_result);

    uint64_t second_expected = 0;
    uint64_t second_result = second(data, n);
    assert(second_expected, second_result);
}
