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
            res[i][j] = rand() % 4591;
        }
    }
}

int cmpfunc(const void *a, const void *b)
{
    return (*(int *)a - *(int *)b);
}

void BruteForce(int16x8_t* c, int16x8_t* a, int16x8_t* b, int l){
    int c1[768] = {0};
    for(int i = 0;i<l;i++){
        for(int j = 0;j<l;j++){
            c1[i+j] = (c1[i+j] + a[i/8][i%8]*b[j/8][j%8])%4591;
        }
    }
    for(int i = 0;i<2*l;i++){
        c[i/8][i%8] = c1[i];
    }
}

int p8x8(){
    int16x8x2_t c[4];
    int16x8_t a, b, x;
    int t[4][TIMES] = {0};
    int tmp, check = 0, time[4];
    for(int z = 0;z<TIMES;z++){
        vec_rand(&a, 1);
        vec_rand(&b, 1);

        tmp = rdtsc();
        BruteForce((int16x8_t*)c, &a, &b, 8);
        t[0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        c[1] = polymul_8x8_ext(a, b);
        t[1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        c[2] = polymul_8x8_mont(a, b);
        t[2][z] = rdtsc()-tmp;

        tmp = rdtsc();
        c[3] = polymul_8x8_karatsuba(a, b);
        t[3][z] = rdtsc()-tmp;

        for(int i = 0;i<16;i++){
            if(c[0].val[i/8][i%8] < 0) c[0].val[i/8][i%8] += 4591; 
            if(c[1].val[i/8][i%8] < 0) c[1].val[i/8][i%8] += 4591; 
            if(c[2].val[i/8][i%8] < 0) c[2].val[i/8][i%8] += 4591; 
            if(c[3].val[i/8][i%8] < 0) c[3].val[i/8][i%8] += 4591; 
            if(c[0].val[i/8][i%8] != c[1].val[i/8][i%8] || c[1].val[i/8][i%8] != c[2].val[i/8][i%8] || c[1].val[i/8][i%8] != c[3].val[i/8][i%8]) check = 1;
        }
    }

    for(int i = 0;i<4;i++){
        qsort(t[i], TIMES, sizeof(int), cmpfunc);
        time[i] = t[i][TIMES >> 1];
    }

    printf("\n|8x8         |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump  |");
    printf("\n|Bruteforce  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[0], time[0], 4*time[0], 8*time[0], 16*time[0]);
    printf("\n|Extend      |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[1], time[1], 4*time[1], 8*time[1], 16*time[1]);
    printf("\n|Montgomery  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[2], time[2], 4*time[2], 8*time[2], 16*time[2]);    
    printf("\n|Karatsuba   |       0 |%8d |       0 |%8d |%8d |%8d |%8d |\n", time[3], time[3], 4*time[3], 8*time[3], 16*time[3]);    
    return check;
}

int p16x16(){
    int16x8x4_t c[3];
    int16x8_t a[2], b[2];
    int t[3][3][TIMES] = {0};
    int tmp, check = 0, time[3];
    for(int z = 0;z<TIMES;z++){
        vec_rand(a, 2);
        vec_rand(b, 2);

        tmp = rdtsc();
        BruteForce((int16x8_t*)c, a, b, 16);
        t[0][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        c[1] = polymul_16x16_schoolbook(a, b);
        t[1][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        c[2] = polymul_16x16(a, b);
        t[2][1][z] = rdtsc()-tmp;

        for(int i = 0;i<32;i++){
            if(c[0].val[i/8][i%8] < 0) c[0].val[i/8][i%8] += 4591; 
            if(c[1].val[i/8][i%8] < 0) c[1].val[i/8][i%8] += 4591; 
            if(c[2].val[i/8][i%8] < 0) c[2].val[i/8][i%8] += 4591; 
            if(c[1].val[i/8][i%8] != c[2].val[i/8][i%8]) check = 1;
        }
    }
    qsort(t[0][1], TIMES, sizeof(int), cmpfunc);
    qsort(t[1][1], TIMES, sizeof(int), cmpfunc);
    qsort(t[2][1], TIMES, sizeof(int), cmpfunc);
    for(int i = 0;i<3;i++) time[i] = t[i][1][TIMES >> 1];
    printf("\n|16x16       |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump  |");
    printf("\n|Bruteforce  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[0], time[0], 4*time[0], 8*time[0], 16*time[0]);
    printf("\n|SchoolBook  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[1], time[1], 4*time[1], 8*time[1], 16*time[1]);
    printf("\n|Karatsuba   |       0 |%8d |       0 |%8d |%8d |%8d |%8d |\n", time[2], time[2], 4*time[2], 8*time[2], 16*time[2]);    
    return check;
}

int p32x32(){
    int t[4][3][TIMES] = {0}, tmp, check = 0, time[4][3] = {0};
    for(int z = 0;z<TIMES;z++){
        int16x8_t c[4][8] = {0}, a[4], b[4];
        int16x8x2_t h[7] = {0};
        int16x8_t aIn[7] = {0},  bIn[7] = {0};

        vec_rand(a, 4);
        vec_rand(b, 4);

        tmp = rdtsc();
        BruteForce(c[0], a, b, 32);
        t[0][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_32x32_schoolbook(c[1], a, b);
        t[1][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_32x32(c[2], a, b);
        t[2][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_32x32_Toom_InputTransform(aIn, a);
        polymul_32x32_Toom_InputTransform(bIn, b);
        t[3][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        for(int i = 0;i<7;i++) h[i] = polymul_8x8(aIn[i], bIn[i]);
        t[3][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_32x32_Toom_Output(c[3], h);
        t[3][2][z] = rdtsc()-tmp;

        for(int i = 0;i<64;i++){
            for(int j = 0;j<4;j++){
                if(c[j][i/8][i%8] < 0) c[j][i/8][i%8] += 4591; 
            }
            for(int j = 1;j<4;j++){
                if(c[0][i/8][i%8] != c[j][i/8][i%8]) check = 1;
            }
        }
    }
    for (int i = 0;i<4;i++){
        for(int j = 0;j<3;j++){
            qsort(t[i][j], TIMES, sizeof(int), cmpfunc);
            time[i][j] = t[i][j][TIMES >> 1];
        }
    }
    printf("\n|32x32       |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump  |");
    printf("\n|Bruteforce  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[0][1], time[0][1], 4*time[0][1], 8*time[0][1], 16*time[0][1]);
    printf("\n|SchoolBook  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[1][1], time[1][1], 4*time[1][1], 8*time[1][1], 16*time[1][1]);
    printf("\n|Karatsuba   |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[2][1], time[2][1], 4*time[2][1], 8*time[2][1], 16*time[2][1]);    
    printf("\n|Toom        |%8d |%8d |%8d |%8d |%8d |%8d |%8d |\n", time[3][0], time[3][1], time[3][2], time[3][0]+time[3][1]+time[3][2], 3*time[3][0]+4*time[3][1]+2*time[3][2], 4*time[3][0]+8*time[3][1]+4*time[3][2], 6*time[3][0]+16*time[3][1]+8*time[3][2]);    
    return check;
}

int p64x64(){    
    int t[6][3][TIMES] = {0}, tmp, check = 0, time[6][3];
    for(int z = 0;z<TIMES;z++){
        int16x8_t c[6][16] = {0}, a[8], b[8];
        int16x8x4_t h[7] = {0};
        int16x8_t aIn[32] = {0},  bIn[32] = {0}, NTT_a[16], NTT_b[16], NTT_c[16];
        int16x8_t atmp[32] = {0}, btmp[32] = {0}, cOut[64]= {0};

        vec_rand(a, 8);
        vec_rand(b, 8);

        tmp = rdtsc();
        BruteForce(c[0], a, b, 64);
        t[0][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_64x64_schoolbook(c[1], a, b);
        t[1][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_64x64_karatsuba(c[2], a, b);
        t[2][1][z] = rdtsc()-tmp;

        // Toom
        tmp = rdtsc();
        polymul_64x64_Toom_InputTransform(aIn, a);
        polymul_64x64_Toom_InputTransform(bIn, b);
        t[3][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        for(int i = 0;i<7;i++) h[i] = polymul_16x16(aIn+(i*2), bIn+(i*2));
        t[3][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_64x64_Toom_Output(c[3], h);
        t[3][2][z] = rdtsc()-tmp;

        // Rader
        tmp = rdtsc();
        polymul_64x64_rader_in(NTT_a, NTT_b, a, b);
        t[4][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_64x64_rader_8x8(NTT_c, NTT_a, NTT_b);
        t[4][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_64x64_rader_out(c[4], NTT_c);
        t[4][2][z] = rdtsc()-tmp;

        // Schonhage
        tmp = rdtsc();
        permutation_64(atmp, a);
        permutation_64(btmp, b);
        SchonhageIn_64(aIn, atmp);
        SchonhageIn_64(bIn, btmp);
        t[5][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        SchonhageMul_64(cOut, aIn, bIn);
        t[5][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        SchonhageOut_64(c[5], cOut);
        t[5][2][z] = rdtsc()-tmp;

        for(int i = 0;i<128;i++){
            for(int j = 0;j<6;j++){
                if(c[j][i/8][i%8] < 0) c[j][i/8][i%8] += 4591; 
                if(j>0){
                    if(c[0][i/8][i%8] != c[j][i/8][i%8]) check = 1;
                }
            }
        }
    }

    for(int i = 0;i<6;i++){
        for(int j = 0;j<3;j++){
            qsort(t[i][j], TIMES, sizeof(int), cmpfunc);
            time[i][j] = t[i][j][TIMES >> 1];
        }
    }
    
    printf("\n|64x64       |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump  |");
    printf("\n|Bruteforce  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[0][1], time[0][1], 4*time[0][1], 8*time[0][1], 16*time[0][1]);
    printf("\n|SchoolBook  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[1][1], time[1][1], 4*time[1][1], 8*time[1][1], 16*time[1][1]);
    printf("\n|Karatsuba   |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[2][1], time[2][1], 4*time[2][1], 8*time[2][1], 16*time[2][1]);    
    printf("\n|Toom        |%8d |%8d |%8d |%8d |%8d |%8d |%8d |", time[3][0], time[3][1], time[3][2], time[3][0]+time[3][1]+time[3][2], 3*time[3][0]+4*time[3][1]+2*time[3][2], 4*time[3][0]+8*time[3][1]+4*time[3][2], 6*time[3][0]+16*time[3][1]+8*time[3][2]);
    printf("\n|Rader       |%8d |%8d |%8d |%8d |%8d |%8d |%8d |", time[4][0], time[4][1], time[4][2], time[4][0]+time[4][1]+time[4][2], 3*time[4][0]+4*time[4][1]+2*time[4][2], 4*time[4][0]+8*time[4][1]+4*time[4][2], 6*time[4][0]+16*time[4][1]+8*time[4][2]);    
    printf("\n|Schonhage   |%8d |%8d |%8d |%8d |%8d |%8d |%8d |\n", time[5][0], time[5][1], time[5][2], time[5][0]+time[5][1]+time[5][2], 3*time[5][0]+4*time[5][1]+2*time[5][2], 4*time[5][0]+8*time[5][1]+4*time[5][2], 6*time[5][0]+16*time[5][1]+8*time[5][2]);    
    return check;
}

int p128x128(){
    int t[7][3][TIMES] = {0}, tmp, check = 0, time[7][3];
    for(int z = 0;z<TIMES;z++){
        int16x8_t c[7][32] = {0}, a[16], b[16];
        int16x8_t aIn[28] = {0},  bIn[28] = {0}, mab[8][8] = {0}, mc[9][16] = {0}, h[64] = {0};
        int16x8_t NTT_a[32] = {0}, NTT_b[32] = {0}, NTT_c[32] = {0};
        int16x8_t atmp[64] = {0}, btmp[64] = {0}, cOut[64] = {0};
        int16x8_t tmpa[56] = {0}, tmpb[56] = {0}, tmpc[64] = {0};
        int16x8_t aIn1[64] = {0},  bIn1[64] = {0};
        int16x8_t aIn2[64] = {0},  bIn2[64] = {0};

        vec_rand(a, 16);
        vec_rand(b, 16);

        tmp = rdtsc();
        BruteForce(c[0], a, b, 128);
        t[0][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_128x128_schoolbook(c[1], a, b);
        t[1][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_128x128_karatsuba(c[2], a, b);
        t[2][1][z] = rdtsc()-tmp;

        // Toom
        tmp = rdtsc();
        polymul_128x128_Toom_InputTransform(aIn, a);
        polymul_128x128_Toom_InputTransform(bIn, b);
        t[3][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        __asm_8x32x32(h, aIn, bIn, mc, mab);
        t[3][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_128x128_Toom_Out(c[3], h);
        t[3][2][z] = rdtsc()-tmp;

        // Rader
        tmp = rdtsc();
        polymul_128x128_rader_in(NTT_a, NTT_b, a, b);
        t[4][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_128x128_rader_16x16(NTT_c, NTT_a, NTT_b);
        t[4][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_128x128_rader_out(c[4], NTT_c);
        t[4][2][z] = rdtsc()-tmp;

        // Schonhage
        tmp = rdtsc();
        permutation_128(atmp, a);
        permutation_128(btmp, b);
        SchonhageIn_128(aIn2, atmp);
        SchonhageIn_128(bIn2, btmp);
        t[5][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        SchonhageMul_128(cOut, aIn2, bIn2);
        t[5][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        SchonhageOut_128(c[5], cOut);
        t[5][2][z] = rdtsc()-tmp;

        // Bruun
        tmp = rdtsc();
        Brunn_128_In(aIn1, a);
        Brunn_128_In(bIn1, b);
        t[6][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        __asm8_16x16(tmpc, aIn1, bIn1, tmpa);
        __asm8_16x16(tmpc+32, aIn1+16, bIn1+16, tmpb);
        t[6][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        Brunn_128_Out(c[6], tmpc);
        t[6][2][z] = rdtsc()-tmp;

        for(int i = 0;i<128;i++){
            for(int j = 0;j<7;j++){
                if(c[j][i/8][i%8] < 0) c[j][i/8][i%8] += 4591; 
                if(j>0){
                    if(c[0][i/8][i%8] != c[j][i/8][i%8]) check = 1;
                }
            }
        }
    }

    for(int i = 0;i<7;i++){
        for(int j = 0;j<3;j++){
            qsort(t[i][j], TIMES, sizeof(int), cmpfunc);
            time[i][j] = t[i][j][TIMES >> 1];
        }
    }
    
    printf("\n|128x128     |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump  |");
    printf("\n|Bruteforce  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[0][1], time[0][1], 4*time[0][1], 8*time[0][1], 16*time[0][1]);
    printf("\n|SchoolBook  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[1][1], time[1][1], 4*time[1][1], 8*time[1][1], 16*time[1][1]);
    printf("\n|Karatsuba   |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[2][1], time[2][1], 4*time[2][1], 8*time[2][1], 16*time[2][1]);    
    printf("\n|Toom        |%8d |%8d |%8d |%8d |%8d |%8d |%8d |", time[3][0], time[3][1], time[3][2], time[3][0]+time[3][1]+time[3][2], 3*time[3][0]+4*time[3][1]+2*time[3][2], 4*time[3][0]+8*time[3][1]+4*time[3][2], 6*time[3][0]+16*time[3][1]+8*time[3][2]);
    printf("\n|Rader       |%8d |%8d |%8d |%8d |%8d |%8d |%8d |", time[4][0], time[4][1], time[4][2], time[4][0]+time[4][1]+time[4][2], 3*time[4][0]+4*time[4][1]+2*time[4][2], 4*time[4][0]+8*time[4][1]+4*time[4][2], 6*time[4][0]+16*time[4][1]+8*time[4][2]);    
    printf("\n|Schonhage   |%8d |%8d |%8d |%8d |%8d |%8d |%8d |", time[5][0], time[5][1], time[5][2], time[5][0]+time[5][1]+time[5][2], 3*time[5][0]+4*time[5][1]+2*time[5][2], 4*time[5][0]+8*time[5][1]+4*time[5][2], 6*time[5][0]+16*time[5][1]+8*time[5][2]);    
    printf("\n|Bruun       |%8d |%8d |%8d |%8d |%8d |%8d |%8d |\n", time[6][0], time[6][1], time[6][2], time[6][0]+time[6][1]+time[6][2], 3*time[6][0]+4*time[6][1]+2*time[6][2], 4*time[6][0]+8*time[6][1]+4*time[6][2], 6*time[6][0]+16*time[6][1]+8*time[6][2]);    
    return check;
}

int p768(){
    int t[2][3][TIMES] = {0}, tmp, check = 0, time[2][3];
    for(int z = 0;z<TIMES;z++){
        int16x8_t c[2][96] = {0}, a[96] = {0}, b[96] = {0};
        int16x8_t NTT_a[96] = {0}, NTT_b[96] = {0}, NTT_c[96] = {0};
        vec_rand(a, 48);
        vec_rand(b, 48);

        tmp = rdtsc();
        BruteForce(c[0], a, b, 384);
        t[0][1][z] = rdtsc()-tmp;

        // Rader
        tmp = rdtsc();
        polymul_768x768_rader_in(NTT_a, NTT_b, a, b);
        t[1][0][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_768x768_rader_16x16(NTT_c, NTT_a, NTT_b);
        t[1][1][z] = rdtsc()-tmp;

        tmp = rdtsc();
        polymul_768x768_rader_out(c[1], NTT_c);
        t[1][2][z] = rdtsc()-tmp;

        for(int i = 0;i<768;i++){
            for(int j = 0;j<2;j++){
                if(c[j][i/8][i%8] < 0) c[j][i/8][i%8] += 4591; 
                if(j>0){
                    if(c[0][i/8][i%8] != c[j][i/8][i%8]) check = 1;
                }
            }
        }
    }

    for(int i = 0;i<2;i++){
        for(int j = 0;j<3;j++){
            qsort(t[i][j], TIMES, sizeof(int), cmpfunc);
            time[i][j] = t[i][j][TIMES >> 1];
        }
    }
    
    printf("\n|768         |    in   |   mul   |   out   |   pxp   |   MxV   |   MxM   |   jump  |");
    printf("\n|Bruteforce  |       0 |%8d |       0 |%8d |%8d |%8d |%8d |", time[0][1], time[0][1], 4*time[0][1], 8*time[0][1], 28*time[0][1]);
    printf("\n|Good        |%8d |%8d |%8d |%8d |%8d |%8d |%8d |\n", time[1][0], time[1][1], time[1][2], time[1][0]+time[1][1]+time[1][2], 3*time[1][0]+4*time[1][1]+2*time[1][2], 4*time[1][0]+8*time[1][1]+4*time[1][2], 9*time[1][0]+28*time[1][1]+10*time[1][2]);    
    return check;
}

int main()
{
    int16x8_t a[96] = {0}, b[96] = {0}, c[6][96] = {0};
    int tmp, check;

    check = p8x8();
    if(check) printf("\n-   8x8 wrong\n");
    check = p16x16();
    if(check) printf("\n- 16x16 wrong\n");
    check = p32x32();
    if(check) printf("\n- 32x32 wrong\n");
    check = p64x64();
    if(check) printf("\n- 64x64 wrong\n");
    check = p128x128();
    if(check) printf("\n- 128x128 wrong\n");
    check = p768();
    if(check) printf("\n- 768x768 wrong\n");

    return 0;
}