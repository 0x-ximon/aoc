#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

uint64_t first(const char* data[], size_t length) {
    uint64_t result = 0;

    for (size_t i = 0; i < length; i++) {
        for (size_t j = i + 1; j < length; j++) {
            int64_t x1, y1, x2, y2;

            {
                char buffer[strlen(data[i]) + 1];
                strcpy(buffer, data[i]);

                char* x = strtok(buffer, ",");
                if (x == NULL) {
                    printf("Could not split x: %s\n", x);
                    return 0;
                }

                char* y = strtok(NULL, ",");
                if (y == NULL) {
                    printf("Could not split y: %s\n", y);
                    return 0;
                }

                x1 = atoi(x);
                y1 = atoi(y);
            }

            {
                char buffer[strlen(data[j]) + 1];
                strcpy(buffer, data[j]);

                char* x = strtok(buffer, ",");
                if (x == NULL) {
                    printf("Could not split x: %s\n", x);
                    return 0;
                }

                char* y = strtok(NULL, ",");
                if (y == NULL) {
                    printf("Could not split y: %s\n", y);
                    return 0;
                }

                x2 = atoi(x);
                y2 = atoi(y);
            }

            uint64_t width = labs(x2 - x1) + 1;
            uint64_t height = labs(y2 - y1) + 1;
            uint64_t area = width * height;
            result = result > area ? result : area;
        }
    }

    return result;
}

uint64_t second(const char* data[], size_t length) { return 0; }
