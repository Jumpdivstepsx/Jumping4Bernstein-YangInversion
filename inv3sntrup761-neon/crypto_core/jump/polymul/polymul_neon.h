#ifndef _POLYMUL_NEON_H_
#define _POLYMUL_NEON_H_

#include <arm_neon.h>
#include "macros_neon.h"
#include "polymul_neon.h"

extern void transposeCompress(uint8x16_t* a, int8_t* b);
extern void itransposeCompress(int8x16_t* a, uint8x16_t* b);
extern void transposeCompress_2(uint8x16_t* s, uint8x16_t* v, const int8x16_t* in, uint8x16_t* st, uint8x16_t* vt);
extern void itransposeCompress_2(int8x16_t* out, const uint64x2_t* s, const uint64x2_t* v);
extern void poly64x64(int8x16_t* cOut, int8x16_t* aIn, int8x16_t* bIn, uint8x16_t* mod3);

#define poly128x128 polymul_128_karatsuba_withoutCompress
#define poly256x256 polymul_256_karatsuba_withoutCompress

static inline
void polymul_128_karatsuba_withoutCompress(int8x16_t* res, int8x16_t* aIn, int8x16_t* bIn){
    int8x16_t tmpa[4], tmpb[4], tmp[8];

    //Mul 128x128 -> 3_64x64 -> 27_16x16
    poly64x64(res, aIn, bIn, &umod3);
    poly64x64(res+8, aIn+4, bIn+4, &umod3);

    for (int i=0; i<4; i++){
        tmpa[i] = reduce_15(aIn[i] + aIn[i+4]);
        tmpb[i] = reduce_15(bIn[i] + bIn[i+4]);
    }
    poly64x64(tmp, tmpa, tmpb, &umod3);    
    for (int i=0; i<4; i++){
        res[i+4] = (res[i+4] - res[i+8]);
        res[i+8] = reduce_15(tmp[i+4] - (res[i+4] + res[i+12])+ v6_8x16);
        res[i+4] = reduce_15(res[i+4] + (tmp[i] - res[i]) + v6_8x16);
    }
}

static inline
void polymul_256_karatsuba_withoutCompress(int8x16_t* res, int8x16_t* aIn, int8x16_t* bIn){
    int8x16_t tmpa[8], tmpb[8], tmp[16];

    //Mul 256x256 -> 3_128x128 -> 9_64x64 -> 81_16x16
    poly128x128(res, aIn, bIn);
    poly128x128(res+16, aIn+8, bIn+8);

    for (int i=0; i<8; i++){
        tmpa[i] = reduce_15(aIn[i] + aIn[i+8]);
        tmpb[i] = reduce_15(bIn[i] + bIn[i+8]);
    }
    poly128x128(tmp, tmpa, tmpb);
    for (int i=0; i<8; i++){
        res[i+8] = (res[i+8] - res[i+16]);
        res[i+16] = reduce_15(tmp[i+8] - (res[i+8] + res[i+24])+ v6_8x16);
        res[i+8] = reduce_15(res[i+8] + (tmp[i] - res[i]) + v6_8x16);
    }
}

static inline
void poly512x512(int8x16_t* ans, int8x16_t* aIn, int8x16_t* bIn){
    int8x16_t tmpa[16], tmpb[16], tmp[32] = {0}, res[64] = {0};

    //Mul 256x256 -> 3_128x128 -> 9_64x64 -> 81_16x16
    poly256x256(res, aIn, bIn);
    poly256x256(res+32, aIn+16, bIn+16);

    for (int i=0; i<16; i++){
        tmpa[i] = reduce_15(aIn[i] + aIn[i+16]);
        tmpb[i] = reduce_15(bIn[i] + bIn[i+16]);
    }
    poly256x256(tmp, tmpa, tmpb);
    for (int i=0; i<16; i++){
        res[i+16] = res[i+16] - res[i+32];
        res[i+32] = reduce_15(tmp[i+16] - (res[i+16] + res[i+48]) + v6_8x16);
        res[i+16] = reduce_15(res[i+16] + (tmp[i] - res[i]) + v6_8x16);
    }

    for (int i=0; i<48; i++){
        ans[i] = res[i];
    }
}

static inline
void poly512x768(int8x16_t* res, int8x16_t* aIn, int8x16_t* bIn){
    int8x16_t r[32];
    // 512x512
    poly512x512(res, aIn, bIn);
    // a_low_256 x b_high_256: (256x256 = 256)
    poly256x256(r, aIn, bIn+32);
    for(int i = 0;i<16;i++){
        res[i+32] = (res[i+32] + r[i]);
    }
}


static inline
void Tcompress_2(uint8x16_t* sign, uint8x16_t* low, const int8x16_t* inbytes){
    uint8x16_t t[8] = {0};
    int8_t* in;
    in = (int8_t*) inbytes;
    transposeCompress(t, in);
    for(int i = 7;i>=0;i--){
        low[0]  = vaddq_u8(vshlq_n_u8(low[0], 1), vqtbl1q_u8(lm, t[i]));
        sign[0] = vaddq_u8(vshlq_n_u8(sign[0], 1), vqtbl1q_u8(sm, t[i]));
    }
}

//-1
static inline
void Tdecompress(int8x16_t* outbytes, const uint8x16_t* sign, const uint8x16_t* low){
    uint8x16_t t[8] = {0}, stmp = sign[0], ltmp = low[0];
    int8_t out[128] = {0};
    
    for(int i = 0;i<8;i++){
        t[i] = vsubq_u8(vandq_u8(ltmp, uv1), vshlq_n_u8(vandq_u8(stmp, uv1), 1));
        ltmp = vshrq_n_u8(ltmp,1);
        stmp = vshrq_n_u8(stmp,1);
    }
    itransposeCompress(outbytes, t);
}

static inline
void polymul_128_karatsuba_32(uint64x2_t* cs, uint64x2_t* cv, uint64x2_t as, uint64x2_t av, uint64x2_t bs, uint64x2_t bv){
    int8x16_t aIn[8] = {0}, bIn[8] = {0}, res[16] = {0};
    int8x16_t tmpa[4] = {0}, tmpb[4] = {0}, tmp[8] = {0};  
    
    //2: bit to int8
    itransposeCompress_2(aIn, &as, &av);
    itransposeCompress_2(bIn, &bs, &bv);

    //Mul 128x128 -> 27_16x16
    poly64x64((int8x16_t*)res, aIn, bIn, &umod3);
    poly64x64((int8x16_t*)res+8, aIn+4, bIn+4, &umod3);

    for (int i=0; i<4; i++){
        tmpa[i] = reduce_15(aIn[i] + aIn[i+4]);
        tmpb[i] = reduce_15(bIn[i] + bIn[i+4]);
    }
    poly64x64(tmp, tmpa, tmpb, &umod3);

    for (int i=0; i<4; i++){
        res[i+4] = res[i+4] - res[i+8];
        res[i+8] = reduce_15(tmp[i+4] - (res[i+4] + res[i+12]) + v6_8x16);
        res[i+4] = reduce_15(res[i+4] + (tmp[i] - res[i]) + v6_8x16);
    }
    
    // 8b to 2b (256bytes -> 256bits)
    transposeCompress_2((uint8x16_t*)cs, (uint8x16_t*)cv, res, &sm, &lm);
    transposeCompress_2((uint8x16_t*)cs+1, (uint8x16_t*)cv+1, res+8, &sm, &lm);
}

#endif