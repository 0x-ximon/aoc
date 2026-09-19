#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

int8_t directions[8][2] = {
    {-1, 1}, {-1, 0}, {-1, -1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1},
};

uint64_t first(const char* data[], size_t length) {
    uint64_t result = 0;

    size_t m = length;
    size_t n = strlen(data[0]);

    for (size_t i = 0; i < m; i++) {
        for (size_t j = 0; j < n; j++) {
            uint8_t count = 0;
            char c = data[i][j];

            if (c != '@') continue;

            for (size_t k = 0; k < 8; k++) {
                int8_t dx = directions[k][0];
                int8_t dy = directions[k][1];

                int64_t x = i + dx;
                int64_t y = j + dy;

                bool cond = (x >= 0 && y >= 0) && (x < m && y < n);
                if (!cond) continue;

                char d = data[x][y];
                if (d == '@') count++;
            }

            if (count < 4) result++;
        }
    }

    return result;
}

uint64_t second(const char* data[], size_t length) {
    uint64_t result = 0;

    size_t m = length;
    size_t n = strlen(data[0]);

    size_t size = m * (n + 1);
    char** buffer = malloc(size);

    if (buffer == NULL) goto cleanup;
    for (int i = 0; i < m; i++) {
        buffer[i] = malloc(n + 1);
        if (buffer[i] != NULL) strcpy(buffer[i], data[i]);
    }

    while (true) {
        int64_t removed = 0;

        for (size_t i = 0; i < m; i++) {
            for (size_t j = 0; j < n; j++) {
                uint8_t count = 0;
                char c = buffer[i][j];

                if (c != '@') continue;

                for (size_t k = 0; k < 8; k++) {
                    int8_t dx = directions[k][0];
                    int8_t dy = directions[k][1];

                    int64_t x = i + dx;
                    int64_t y = j + dy;

                    bool cond = (x >= 0 && y >= 0) && (x < m && y < n);
                    if (!cond) continue;

                    char d = buffer[x][y];
                    if (d == '@') count++;
                }

                if (count < 4) {
                    buffer[i][j] = '.';
                    removed++;
                    result++;
                }
            }
        }

        if (removed == 0) break;
    }

cleanup:
    for (int i = 0; i < m; i++) free(buffer[i]);
    free(buffer);
    return result;
}
