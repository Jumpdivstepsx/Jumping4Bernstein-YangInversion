#ifndef _RDTSC_H_
#define _RDTSC_H_

#include <stdint.h>

#ifdef _MAC_

#include "m1cycles.h"

static inline uint64_t rdtsc()
{
    return _rdtsc();
}

#else

static inline uint64_t rdtsc()
{
    uint64_t val;

    __asm__ __volatile__("mrs %0, PMCCNTR_EL0" : "=r"(val));
    return val;
}

#endif // end of _MAC_
#endif // end of _RDTSC_H_