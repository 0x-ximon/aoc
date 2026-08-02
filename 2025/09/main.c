#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lib.c"

int main() {
    FILE* f = fopen("input.txt", "r");
    if (f == NULL) {
        printf("Could not open file\n");
        return 1;
    }

    if (fseek(f, 0, SEEK_END) != 0) {
        printf("Could not find end of file\n");
        fclose(f);
        return 1;
    }

    long size = ftell(f);
    if (size < 0) {
        printf("Could getting file size\n");
        fclose(f);
        return 1;
    }

    if (fseek(f, 0, SEEK_SET) != 0) {
        printf("Could not reset cursor\n");
        fclose(f);
        return 1;
    }

    char* buffer = malloc(size + 1);
    if (buffer == NULL) {
        printf("Could not allocate buffer\n");
        fclose(f);
        return 1;
    }

    size_t n = fread(buffer, 1, size, f);
    buffer[n] = '\0';

    const char** data = malloc(size + 1);
    if (data == NULL) {
        printf("Could not allocate data\n");
        free(buffer);
        fclose(f);
        return 1;
    }

    size_t length = 0;
    char* line = strtok(buffer, "\n");
    while (line != NULL) {
        data[length++] = line;
        line = strtok(NULL, "\n");
    }

    uint64_t first_answer = first(data, length);
    printf("First Answer: %lu\n", first_answer);

    uint64_t second_answer = second(data, length);
    printf("Second Answer: %lu\n", second_answer);

    free(data);
    free(buffer);
    fclose(f);
    return 0;
}
