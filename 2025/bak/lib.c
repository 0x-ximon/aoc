#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define min(a, b) a < b ? a : b
#define max(a, b) a > b ? a : b

typedef struct {
    int64_t x;
    int64_t y;
} Point;

typedef struct {
    int64_t* items;
    int64_t len;
    int64_t cap;
} Set;

void append(Set*, int64_t);
int compare(const void*, const void*);

uint64_t first(const char* data[], size_t length) {
    uint64_t result = 0;

    for (size_t i = 0; i < length; i++) {
        for (size_t j = i + 1; j < length; j++) {
            Point p, q;

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

                p.x = atoi(x);
                p.y = atoi(y);
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

                q.x = atoi(x);
                q.y = atoi(y);
            }

            uint64_t width = labs(q.x - p.x) + 1;
            uint64_t height = labs(q.y - p.y) + 1;
            uint64_t area = width * height;
            result = max(area, result);
        }
    }

    return result;
}

uint64_t second(const char* data[], size_t length) {
    Point* polygon = NULL;
    uint64_t result = 0;

    int64_t xs[length] = {};
    Set xset = {.cap = length, .len = 0, .items = xs};

    int64_t ys[length] = {};
    Set yset = {.cap = length, .len = 0, .items = ys};

    polygon = malloc(sizeof(Point) * length);
    if (polygon == NULL) {
        printf("Could not allocate polygon.\n");
        goto cleanup;
    }

    // Construct polygon
    for (size_t i = 0; i < length; i++) {
        char buffer[strlen(data[i]) + 1];
        strcpy(buffer, data[i]);

        char* x = strtok(buffer, ",");
        if (x == NULL) {
            printf("Could not split x: %s\n", x);
            goto cleanup;
        }

        char* y = strtok(NULL, ",");
        if (y == NULL) {
            printf("Could not split y: %s\n", y);
            goto cleanup;
        }

        polygon[i].x = atoi(x);
        polygon[i].y = atoi(y);

        append(&xset, polygon[i].x);
        append(&yset, polygon[i].y);
    }

    // Compression
    qsort(xset.items, xset.len - 1, sizeof(int64_t), compare);
    qsort(yset.items, yset.len - 1, sizeof(int64_t), compare);

    // Classify

    // Summation

    // Query

cleanup:
    free(polygon);
    return result;
}

/*//////////////////////////////////////////////////////////////
                           UTILITIES
//////////////////////////////////////////////////////////////*/

// Unique append
void append(Set* set, int64_t value) {
    // Set is filled
    int64_t n = set->len;
    int64_t c = set->cap;
    if (n == c) return;

    for (int i = 0; i < n; i++)
        if (set->items[i] == value) return;

    set->items[n] = value;
    set->len++;
}

int compare(const void* a, const void* b) {
    int64_t x = *(const int64_t*)a;
    int64_t y = *(const int64_t*)b;

    if (x < y) return -1;
    if (x > y) return 1;
    return 0;
}
