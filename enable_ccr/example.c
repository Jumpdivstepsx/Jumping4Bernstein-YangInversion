
#include "stdint.h"
#include "stdio.h"

// performance monitors cycle count register. likely to be banned in user space.
// see https://github.com/mupq/pqax/tree/main/enable_ccr
static inline uint64_t rdtsc()
{
    uint64_t val;
    __asm__ __volatile__("mrs %0, PMCCNTR_EL0" : "=r"(val));
    return val;
}

int main()
{
    uint64_t t0, t1;

    uint32_t r = 0;

    t0 = rdtsc();

    for (int32_t i = 0; i < 1536; i++)
        r ^= i;

    t1 = rdtsc();

    printf("r=%x\n", r);
    printf("time diff for 1536 xor operations: %lld\n\n", t1 - t0);

    return 0;
}
