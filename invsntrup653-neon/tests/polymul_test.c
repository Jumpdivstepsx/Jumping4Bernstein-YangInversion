#include <arm_neon.h>
#include <macros_neon.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <polymul_neon.h>
#define TIMES 1000

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
            res[i][j] = rand() % 4621;
        }
    }
}

void polymul_56x56_BruteForce(int *c, int16x8_t *a, int16x8_t *b)
{
    for (int i = 0; i < 56; i++)
    {
        for (int j = 0; j < 56; j++)
        {
            c[i + j] = (c[i + j] + a[i / 8][i % 8] * b[j / 8][j % 8])%4621;
        }
    }
    for (int i = 0; i < 112; i++)
    {
        c[i] = c[i] % 4621;
    }
}

void polymul_112x112_BruteForce(int *c, int16x8_t *a, int16x8_t *b)
{
    for (int i = 0; i < 112; i++)
    {
        for (int j = 0; j < 112; j++)
        {
            c[i + j] = (c[i + j] + a[i / 8][i % 8] * b[j / 8][j % 8])%4621;
        }
    }
    for (int i = 0; i < 224; i++)
    {
        c[i] = c[i] % 4621;
    }
}

void polymul_672x672_BruteForce(int* c, int16x8_t* a, int16x8_t* b){    
    int16_t t[1344] = {0};
    for(int i=0; i<672; i++){
        for(int j=0; j<672; j++){
            t[i+j] = (t[i+j] + a[i/8][i%8] * b[j/8][j%8])%4621;
        }
    }

    for(int i=0; i<672; i++){
        c[i] = (t[i] + t[i+672])%4621;
    }
}


int cmpfunc(const void *a, const void *b)
{
    return (*(int *)a - *(int *)b);
}

int main()
{
    int16x8_t a_56[7] = {0}, b_56[7] = {0}, c1_56[14] = {0};
    int16x8_t a_112[14] = {0}, b_112[14] = {0}, c1_112[28] = {0};
    int16x8_t a_672[84] = {0}, b_672[84] = {0}, c1_672[84] = {0}, NTT_a[96], NTT_b[96];
    int16x8x4_t NTT_c[84];

    int c_56[112] = {0}, c_112[224] = {0}, c_672[672];
    int tmp;
    int t[TIMES] = {0}, t1[3][TIMES] = {0}, t2[TIMES] = {0}, t3[3][TIMES] = {0}, t4[TIMES] = {0}, t5[3][TIMES] = {0};


    for (int z = 0; z < TIMES; z++)
    {
        vec_rand(a_56, 7);
        vec_rand(b_56, 7);
        vec_rand(a_112, 14);
        vec_rand(b_112, 14);
        vec_rand(a_672, 84);
        vec_rand(b_672, 84);

        for (int i = 0; i<14; i++)
        {
            c1_56[i] = v0_16;
            for (int j=0; j<8; j++)
            {
                c_56[i * 8 + j] = 0;
            }
        }
        for (int i = 0; i<28; i++)
        {
            c1_112[i] = v0_16;
            for (int j=0; j<8; j++)
            {
                c_112[i * 8 + j] = 0;
            }
        }
        for (int i=0; i<84; i++){
            c1_672[i] = v0_16;
            for (int j=0; j<8; j++){
                c_672[i*8+j] = 0;
            }
        }

        // ============================================================
        /* polymul_56x56 */  
        // ============================================================
        // BruteForce
        tmp = rdtsc();
        polymul_56x56_BruteForce(c_56, a_56, b_56);
        t[z] = rdtsc() - tmp;
        //Toom
        int16x8_t aIn_56[14], bIn_56[14];
        int16x8x4_t cIn_56[7];
        tmp = rdtsc();
        polymul_56x56_Toom_InputTransform(aIn_56, a_56);
        polymul_56x56_Toom_InputTransform(bIn_56, b_56);
        t1[0][z] = rdtsc() - tmp;

        tmp = rdtsc();
        polymul_56x56_Toom_Mul(cIn_56, aIn_56, bIn_56);
        t1[1][z] = rdtsc() - tmp;

        tmp = rdtsc();
        polymul_56x56_Toom_OutputTransform(c1_56, cIn_56);
        t1[2][z] = rdtsc() - tmp;

        // ============================================================
        /* polymul_112x112 */  
        // ============================================================
        // BruteForce
        tmp = rdtsc();
        polymul_112x112_BruteForce(c_112, a_112, b_112);
        t2[z] = rdtsc() - tmp;
        //Toom
        int16x8_t aIn_112[28],  bIn_112[28], cIn_112[64];
        tmp = rdtsc();
        polymul_112x112_Toom_InputTransform(aIn_112, a_112);
        polymul_112x112_Toom_InputTransform(bIn_112, b_112);
        t3[0][z] = rdtsc() - tmp;

        tmp = rdtsc();
        polymul_112x112_Toom_mul(cIn_112, aIn_112, bIn_112);
        t3[1][z] = rdtsc() - tmp;

        tmp = rdtsc();
        polymul_112x112_Toom_OutputTransform(c1_112, cIn_112);
        t3[2][z] = rdtsc() - tmp;
        
        // ============================================================
        /* polymul_672x672 = 672 */  
        // ============================================================
        // BruteForce
        tmp = rdtsc();
        polymul_672x672_BruteForce(c_672, a_672, b_672);
        t4[z] = rdtsc() - tmp;
        //GT-Toom
        tmp = rdtsc();
        polymul_672x672_GoodThomas_in(NTT_a, a_672);
        polymul_672x672_GoodThomas_in(NTT_b, b_672);
        t5[0][z] = rdtsc() - tmp;

        tmp = rdtsc();
        polymul_672x672_GoodThomas_mul(NTT_c, NTT_a, NTT_b);
        t5[1][z] = rdtsc() - tmp;

        tmp = rdtsc();
        polymul_672x672_GoodThomas_out(c1_672, NTT_c);
        t5[2][z] = rdtsc() - tmp;
    }
    
    // ============================================================
    /* polymul_56x56 */  
    // ============================================================
    qsort(t, TIMES, sizeof(int), cmpfunc);
    qsort(t1[0], TIMES, sizeof(int), cmpfunc);
    qsort(t1[1], TIMES, sizeof(int), cmpfunc);
    qsort(t1[2], TIMES, sizeof(int), cmpfunc);
    // ============================================================
    /* polymul_112x112 */  
    // ============================================================
    qsort(t2, TIMES, sizeof(int), cmpfunc);
    qsort(t3[0], TIMES, sizeof(int), cmpfunc);
    qsort(t3[1], TIMES, sizeof(int), cmpfunc);
    qsort(t3[2], TIMES, sizeof(int), cmpfunc);
    // ============================================================
    /* polymul_672x672 = 672 */  
    // ============================================================
    qsort(t4, TIMES, sizeof(int), cmpfunc);
    qsort(t5[0], TIMES, sizeof(int), cmpfunc);
    qsort(t5[1], TIMES, sizeof(int), cmpfunc);
    qsort(t5[2], TIMES, sizeof(int), cmpfunc);


    t[0] = t[TIMES >> 1];
    t1[0][0] = t1[0][TIMES >> 1];
    t1[1][0] = t1[1][TIMES >> 1];
    t1[2][0] = t1[2][TIMES >> 1];
    printf("\n|56x56           |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump    |");
    printf("\n|Bruteforce      |       0 |%8d |       0 |%8d |%8d |%8d |%10d |", t[0], t[0], 4*t[0], 8*t[0], 16*t[0]);
    printf("\n|Toom            |%8d |%8d |%8d |%8d |%8d |%8d |%10d |\n", t1[0][0], t1[1][0], t1[2][0], t1[0][0]+t1[1][0]+t1[2][0], 3*t1[0][0]+4*t1[1][0]+2*t1[2][0], 4*t1[0][0]+8*t1[1][0]+4*t1[2][0], 6*t1[0][0]+16*t1[1][0]+8*t1[2][0]);
    t2[0] = t2[TIMES >> 1];
    t3[0][0] = t3[0][TIMES >> 1];
    t3[1][0] = t3[1][TIMES >> 1];
    t3[2][0] = t3[2][TIMES >> 1];
    printf("\n|112x112         |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump    |");
    printf("\n|Bruteforce      |       0 |%8d |       0 |%8d |%8d |%8d |%10d |", t2[0], t2[0], 4*t2[0], 8*t2[0], 16*t2[0]);
    printf("\n|Toom            |%8d |%8d |%8d |%8d |%8d |%8d |%10d |\n", t3[0][0], t3[1][0], t3[2][0], t3[0][0]+t3[1][0]+t3[2][0], 3*t3[0][0]+4*t3[1][0]+2*t3[2][0], 4*t3[0][0]+8*t3[1][0]+4*t3[2][0], 6*t3[0][0]+16*t3[1][0]+8*t3[2][0]);

    t4[0] = t4[TIMES >> 1];
    t5[0][0] = t5[0][TIMES >> 1];
    t5[1][0] = t5[1][TIMES >> 1];
    t5[2][0] = t5[2][TIMES >> 1];
    printf("\n|672x672 = 672   |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump    |");
    printf("\n|Bruteforce      |       0 |%8d |       0 |%8d |%8d |%8d |%10d |", t4[0], t4[0], 4*t4[0], 8*t4[0], 16*t4[0]);
    printf("\n|GT-CT-Toom      |%8d |%8d |%8d |%8d |%8d |%8d |%10d |\n\n", t5[0][0], t5[1][0], t5[2][0], t5[0][0]+t5[1][0]+t5[2][0], 3*t5[0][0]+4*t5[1][0]+2*t5[2][0], 4*t5[0][0]+8*t5[1][0]+4*t5[2][0], 6*t5[0][0]+16*t5[1][0]+8*t5[2][0]);
    return 0;
}