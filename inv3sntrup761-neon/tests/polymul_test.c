#include <arm_neon.h>
#include <macros_neon.h>
#include <polymul_neon.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TIMES 1000

static inline uint64_t rdtsc(){
    uint64_t val;
    __asm__ __volatile__("mrs %0, PMCCNTR_EL0" : "=r"(val));
    return val;
}

int cmpfunc(const void *a, const void *b){
    return (*(int *)a - *(int *)b);
}

void rand_v3(int8x16_t *res, int len){
    int tmp;
    for (int i = 0; i < len; i++)
    {
        for (int j=0; j<16; j++){
            tmp = rand()%3;
            if (tmp == 0){
                res[i][j] = 0;
            }else if (tmp == 1){
                res[i][j] = 1;
            }else{
                res[i][j] = 2;
            }
        }
    }
}

void bruteforce128(int8x16_t* c, int8x16_t* a, int8x16_t* b){
    for (int i = 0; i < 128; i++){
        for (int j = 0; j < 128; j++){
            c[(i+j)/16][(i+j)%16] = (c[(i+j)/16][(i+j)%16] + a[i/16][i%16] * b[j/16][j%16]) % 3;
            if(c[(i+j)/16][(i+j)%16] == 2)c[(i+j)/16][(i+j)%16] = -1;
            if(c[(i+j)/16][(i+j)%16] == -2)c[(i+j)/16][(i+j)%16] = 1;
        }
    }
}

int main(){
    int8x16_t a[8] = {0}, b[8] = {0};
    uint8x16_t as, av, bs, bv;    
    int tmp, t1[TIMES] = {0}, t2[TIMES] = {0}, t3[TIMES] = {0};

    for (int z=0; z<TIMES; z++){
        //Test poly128x128
        rand_v3(a, 8);
        rand_v3(b, 8);
        
        int8x16_t c[16] = {0};
        tmp = rdtsc();        
        bruteforce128(c, a, b);
        t1[z] = rdtsc() - tmp;

        //withoutCompress
        int8x16_t c1[16];
        tmp = rdtsc();
        polymul_128_karatsuba_withoutCompress(c1, a, b);
        t2[z] = rdtsc() - tmp;

        //int8 to bit
        Tcompress_2(&as, &av, a);
        Tcompress_2(&bs, &bv, b);
        int8x16_t c2[16] = {0};
        uint8x16_t cs[2] = {0}, cv[2] = {0};

        tmp = rdtsc();        
        polymul_128_karatsuba_32((uint64x2_t *)cs, (uint64x2_t *)cv, (uint64x2_t)as, (uint64x2_t)av, (uint64x2_t)bs, (uint64x2_t)bv);
        t3[z] = rdtsc() - tmp;

        //bit to int8
        Tdecompress(c2, cs, cv);
        Tdecompress(c2+8, cs+1, cv+1);
    }

    printf("Success!\n");

    qsort(t1, TIMES, sizeof(int), cmpfunc);
    qsort(t2, TIMES, sizeof(int), cmpfunc);
    qsort(t3, TIMES, sizeof(int), cmpfunc);

    printf("\nbruteforece_p128      : %8d\n", t1[TIMES >> 1]);
    printf("\nbitNcompress_p128     : %8d\n", t2[TIMES >> 1]);
    printf("\nbitcompress_p128      : %8d\n\n", t3[TIMES >> 1]);

    return 0;
}