#include <arm_neon.h>
#include <iostream>
#include <inttypes.h>

void new_line() {
    printf("\n");
}

int main()
{
    {
        int16x4_t a = {0, 0, 0, 0};
        int16x4_t b = {0, 0, 1, 1};
        int16x4_t ret = vceq_s16(a, b);
        for (int i = 0; i < 4; i++) {
            printf("%d, ", ret[i]);
        }
        new_line();
    }
    {
        int8x8_t a = {0, 0, 0, 0, 0, 0, 0, 0};
        int8x8_t b = {0, 0, 0, 0, 1, 1, 1, 1};
        int8x8_t ret = vceq_s8(a, b);
        for (int i = 0; i < 8; i++) {
            printf("%d, ", ret[i]);
        }
        new_line();
    }
    {
        int8x8_t a = {-1, -2, -1, 0, 0, 0, 0, 0};
        int8x8_t b = {1, 127, 1, 1, 1, 1, 1, 1};
        int8x8_t c = {0, 0, 0, 0, 0, 0, 0, 0};
        int8x8_t ret = vbsl_s8(a, b, c);
        for (int i = 0; i < 8; i++) {
            printf("%d, ", ret[i]);
        }
        new_line();
    }
}
