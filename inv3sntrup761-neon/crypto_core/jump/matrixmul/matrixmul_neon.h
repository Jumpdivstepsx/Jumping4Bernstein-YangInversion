#ifndef _MATREIXMUL_NEON_H_
#define _MATREIXMUL_NEON_H_

#include <arm_neon.h>
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"
#include "string.h"

static inline
void matrixmul_128x128(int8x16_t* res, int8x16_t* uvqr, int8x16_t* abcd){
    int8x16_t tmp[4][16] = {0};
    polymul_128_karatsuba_withoutCompress(tmp[0], uvqr, abcd);
    polymul_128_karatsuba_withoutCompress(tmp[1], uvqr+8, abcd+16);
    polymul_128_karatsuba_withoutCompress(tmp[2], uvqr, abcd+8);
    polymul_128_karatsuba_withoutCompress(tmp[3], uvqr+8, abcd+24);
    for (int i=0; i<16; i++){
        res[i] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+16] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }

    polymul_128_karatsuba_withoutCompress(tmp[0], uvqr+16, abcd);
    polymul_128_karatsuba_withoutCompress(tmp[1], uvqr+24, abcd+16);
    polymul_128_karatsuba_withoutCompress(tmp[2], uvqr+16, abcd+8);
    polymul_128_karatsuba_withoutCompress(tmp[3], uvqr+24, abcd+24);
    for (int i=0; i<16; i++){
        res[i+32] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+48] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }
}

static inline
void matrixmul_128x128x(int8x16_t* res, int8x16_t* uvqr, int8x16_t* abcd){
    int8x16_t tmp[4][16] = {0};
    polymul_128_karatsuba_withoutCompress(tmp[0], uvqr, abcd+8); 
    polymul_128_karatsuba_withoutCompress(tmp[1], uvqr+8, abcd+24);
    polymul_128_karatsuba_withoutCompress(tmp[2], uvqr+16, abcd+8);
    polymul_128_karatsuba_withoutCompress(tmp[3], uvqr+24, abcd+24);
    for (int i=0; i<16; i++){
        res[i+16] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+48] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }
}

static inline
void matrixmul_128x128y(int8x16_t* res, int8x16_t* uvqr, int8x16_t* abcd){
    int8x16_t tmp[4][16] = {0};
    polymul_128_karatsuba_withoutCompress(tmp[0], uvqr, abcd);
    polymul_128_karatsuba_withoutCompress(tmp[1], uvqr+8, abcd+16);
    polymul_128_karatsuba_withoutCompress(tmp[2], uvqr, abcd+8);
    polymul_128_karatsuba_withoutCompress(tmp[3], uvqr+8, abcd+24);
    for (int i=0; i<16; i++){
        res[i] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+16] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }
}

static inline
void matrixmul_256x256x(int8x16_t* res, int8x16_t* uvqr, int8x16_t* abcd){
    int8x16_t tmp[4][32] = {0};
    poly256x256(tmp[0], uvqr, abcd+16);
    poly256x256(tmp[1], uvqr+16, abcd+48);
    poly256x256(tmp[2], uvqr+32, abcd+16);
    poly256x256(tmp[3], uvqr+48, abcd+48);
    for (int i=0; i<32; i++){
        res[i+32] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+96] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }
}

static inline
void matrixmul_256x256y(int8x16_t* res, int8x16_t* uvqr, int8x16_t* abcd){
    int8x16_t tmp[4][32] = {0};
    poly256x256(tmp[0], uvqr, abcd);
    poly256x256(tmp[1], uvqr+16, abcd+32);
    poly256x256(tmp[2], uvqr, abcd+16);
    poly256x256(tmp[3], uvqr+16, abcd+48);
    for (int i=0; i<32; i++){
        res[i] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+32] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }
}

static inline
void matrixmul_256x256(int8x16_t* res, int8x16_t* uvqr, int8x16_t* abcd){
    int8x16_t tmp[4][32] = {0};
    poly256x256(tmp[0], uvqr, abcd);
    poly256x256(tmp[1], uvqr+16, abcd+32);
    poly256x256(tmp[2], uvqr, abcd+16);
    poly256x256(tmp[3], uvqr+16, abcd+48);
    for (int i=0; i<32; i++){
        res[i] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+32] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }

    poly256x256(tmp[0], uvqr+32, abcd);
    poly256x256(tmp[1], uvqr+48, abcd+32);
    poly256x256(tmp[2], uvqr+32, abcd+16);
    poly256x256(tmp[3], uvqr+48, abcd+48);
    for (int i=0; i<32; i++){
        res[i+64] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+96] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }
}

static inline 
void matrixmul_512x512x(int8x16_t* res, int8x16_t* uvqr, int8x16_t* abcd){
    int8x16_t tmp[4][48] = {0};
    poly512x512(tmp[0], uvqr, abcd+32);
    poly512x512(tmp[1], uvqr+32, abcd+96);
    poly512x512(tmp[2], uvqr+64, abcd+32);
    poly512x512(tmp[3], uvqr+96, abcd+96);
    for (int i=0; i<48; i++){
        res[i] = reduce_15((uint8x16_t)(tmp[0][i] + tmp[1][i]));
        res[i+48] = reduce_15((uint8x16_t)(tmp[2][i] + tmp[3][i]));
    }
}

static inline
void matrixmul_512x768x(int8x16_t* res, int8x16_t* uvqr, int8x16_t* vr){
    int8x16_t tmp[2][48] = {0};
    poly512x768(tmp[0], uvqr, vr);
    poly512x768(tmp[1], uvqr+32, vr+48);
    for (int i=0; i<48; i++){
        res[i] = (tmp[0][i] + tmp[1][i]);
    }
}

static inline
void matrix_merge(int8x16_t* v, int8x16_t* uvqr){
    int8x16_t uvqr1[32*12] = {0}, uvqr2[32*12] = {0}, uvqr3[96] = {0};
    //128x128
    matrixmul_128x128x(uvqr1, uvqr+32, uvqr);
    for (int i=1; i<5; i++){
        matrixmul_128x128(uvqr1+64*i, uvqr+64*i+32, uvqr+64*i);
    }
    matrixmul_128x128y(uvqr1+320, uvqr+352, uvqr+320); 
    matrixmul_256x256x(uvqr2, uvqr1+64, uvqr1);
    matrixmul_256x256(uvqr2+128, uvqr1+192, uvqr1+128);
    matrixmul_256x256y(uvqr2+256, uvqr1+320, uvqr1+256);
    matrixmul_512x512x(uvqr3, uvqr2+128, uvqr2);
    matrixmul_512x768x(v, uvqr2+256, uvqr3);
}

static inline 
void matrixmul_fg(int8x16_t* uvqr, int8x16_t *fIn, int8x16_t *gIn, int n){
    int8x16_t tmpa[16], tmpb[16], tmpc[16], tmpd[16];
    memset(fIn, 0, 8*sizeof(int8x16_t));
    memset(gIn, 0, 8*sizeof(int8x16_t));
    for (int i=1; i<n; i++){
        polymul_128_karatsuba_withoutCompress(tmpa, uvqr, fIn+i*8);
        polymul_128_karatsuba_withoutCompress(tmpb, uvqr+8, gIn+i*8);
        polymul_128_karatsuba_withoutCompress(tmpc, uvqr+16, fIn+i*8);
        polymul_128_karatsuba_withoutCompress(tmpd, uvqr+24, gIn+i*8);
        for (int j=0; j<8; j++){
            fIn[(i-1)*8+j] = reduce_15((uint8x16_t)(tmpa[j] + tmpb[j] + fIn[(i-1)*8+j]));
            fIn[(i)*8+j] = (tmpa[j+8] + tmpb[j+8]);//
            gIn[(i-1)*8+j] = reduce_15((uint8x16_t)(tmpc[j] + tmpd[j] + gIn[(i-1)*8+j]));
            gIn[(i)*8+j] = (tmpc[j+8] + tmpd[j+8]);//
        }
    }
    for(int i = 8*n-1;i>8*n-9;i--){
        fIn[i] = reduce_15((uint8x16_t)vextq_s8(fIn[i-1], fIn[i], 15));
        gIn[i] = reduce_15((uint8x16_t)vextq_s8(gIn[i-1], gIn[i], 15));
    }
    for(int i = 8*n-9;i>0;i--){
        fIn[i] = vextq_s8(fIn[i-1], fIn[i], 15);
        gIn[i] = vextq_s8(gIn[i-1], gIn[i], 15);
    }
    fIn[0] = vextq_s8(v0_8x16, fIn[0], 15);
    gIn[0] = vextq_s8(v0_8x16, gIn[0], 15);
}

#endif