#include <arm_neon.h>
#include <macros_neon.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <divstepsx_neon.h>

#define TIMES 1000

// measure time
static inline uint64_t rdtsc()
{
    uint64_t val;
    __asm__ __volatile__("mrs %0, PMCCNTR_EL0" : "=r"(val));
    return val;
}

void vec_rand(int16x8_t *res, int len)
{
    for (int i = 0; i < len; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            res[i][j] = rand() % 4591;
        }
    }
}

int cmpfunc(const void *a, const void *b)
{
    return (*(int *)a - *(int *)b);
}

int main(){
    int t[14][TIMES], tmp, a[14];
    int16x8_t f[192], g[192], uvqr[192*4];
    for(int z = 0;z<TIMES;z++){
        vec_rand(f, 192);
        vec_rand(g, 192);

        tmp = rdtsc();
        a[0] = div7(1, f, g, uvqr);
        t[0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[1] = div8(1, f, g, uvqr);
        t[1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[2] = div15(1, f, g, uvqr);
        t[2][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[3] = div16(1, f, g, uvqr);
        t[3][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[4] = div31(1, f, g, uvqr);
        t[4][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[5] = div32(1, f, g, uvqr);
        t[5][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[6] = div62(1, f, g, uvqr);
        t[6][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[7] = div63(1, f, g, uvqr);
        t[7][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[8] = div64(1, f, g, uvqr);
        t[8][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[9] = div124(1, f, g, uvqr);
        t[9][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[10] = div127(1, f, g, uvqr);
        t[10][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[11] = div251(1, f, g, uvqr);
        t[11][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[12] = div254(1, f, g, uvqr);
        t[12][z] = rdtsc()-tmp;

        tmp = rdtsc();
        a[13] = div1521(1, f, g, uvqr);
        t[13][z] = rdtsc()-tmp;
    }

    for(int i = 0;i<14;i++) a[0] += a[i];
    printf("a0: %d\n", a[0]);

    for(int i = 0;i<14;i++){
        qsort(t[i], TIMES, sizeof(int), cmpfunc);
    }
    printf("\n| divsteps |    tiks   |");
    printf("\n| div7     |%10d |", t[0][TIMES >> 1]);
    printf("\n| div8     |%10d |", t[1][TIMES >> 1]);
    printf("\n| div15    |%10d |", t[2][TIMES >> 1]);
    printf("\n| div16    |%10d |", t[3][TIMES >> 1]);
    printf("\n| div31    |%10d |", t[4][TIMES >> 1]);
    printf("\n| div32    |%10d |", t[5][TIMES >> 1]);
    printf("\n| div62    |%10d |", t[6][TIMES >> 1]);
    printf("\n| div63    |%10d |", t[7][TIMES >> 1]);
    printf("\n| div64    |%10d |", t[8][TIMES >> 1]);
    printf("\n| div124   |%10d |", t[9][TIMES >> 1]);
    printf("\n| div127   |%10d |", t[10][TIMES >> 1]);
    printf("\n| div251   |%10d |", t[11][TIMES >> 1]);
    printf("\n| div254   |%10d |", t[12][TIMES >> 1]);
    printf("\n| div1521  |%10d |\n", t[13][TIMES >> 1]);
    
    return 0;
}