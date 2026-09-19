#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lib.c"

int main() {
    int result = EXIT_FAILURE;

    FILE* f = NULL;
    const char** data = NULL;
    char* buffer = NULL;
    char* line = NULL;

    f = fopen("input.txt", "r");
    if (f == NULL) {
        printf("Could not open file\n");
        goto cleanup;
    }

    if (fseek(f, 0, SEEK_END) != 0) {
        printf("Could not find end of file\n");
        goto cleanup;
    }

    long size = ftell(f);
    if (size < 0) {
        printf("Could getting file size\n");
        goto cleanup;
    }

    if (fseek(f, 0, SEEK_SET) != 0) {
        printf("Could not reset cursor\n");
        goto cleanup;
    }

    buffer = malloc(size + 1);
    if (buffer == NULL) {
        printf("Could not allocate buffer\n");
        goto cleanup;
    }

    size_t n = fread(buffer, 1, size, f);
    buffer[n] = '\0';

    data = malloc(size + 1);
    if (data == NULL) {
        printf("Could not allocate data\n");
        goto cleanup;
    }

    size_t length = 0;
    line = strtok(buffer, "\n");
    while (line != NULL) {
        data[length++] = line;
        line = strtok(NULL, "\n");
    }

    uint64_t first_answer = first(data, length);
    printf("First Answer: %lu\n", first_answer);

    uint64_t second_answer = second(data, length);
    printf("Second Answer: %lu\n", second_answer);

    result = EXIT_SUCCESS;

cleanup:
    free(line);
    free(buffer);
    free(data);
    fclose(f);

    return result;
}
