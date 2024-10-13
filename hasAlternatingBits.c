#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

static inline int my_clz(uint32_t x) {
    int count = 0;
    for (int i = 31; i >= 0; --i) {
        if (x & (1U << i))
            break;
        count++;
    }
    return count;
}

bool hasAlternatingBits(uint32_t n) {
    int totalBits = 32 - my_clz(n);
    for (int i = 0; i < totalBits - 1; i++) {
        if (((n >> i) & 1) == ((n >> (i + 1)) & 1)) {
            return false;
        }
    }
    return true;
}

int main() {
    uint32_t n = 5;
    for(int i=0;i<5;i++)
        printf("%s\n", hasAlternatingBits(i)?"true":"false");
    return 0;
}
