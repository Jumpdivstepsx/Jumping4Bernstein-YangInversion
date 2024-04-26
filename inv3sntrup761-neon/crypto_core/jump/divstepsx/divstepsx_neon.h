#ifndef _DVSTEPSX_NEON_H_
#define _DVSTEPSX_NEON_H_

#include <arm_neon.h>
#include "macros_neon.h"
#include "divstepsx_neon.h"
#include "polymul_neon.h"

static inline void compressShiftLeft_128(uint64x2_t *in){
    in[0][1] = (uint64_t)vorr_u64(vshl_n_u64((uint64x1_t)in[0][1], 1), (vshr_n_u64((uint64x1_t)in[0][0], 63)));
    in[0][0] = (uint64_t) vshl_n_u64((uint64x1_t)in[0][0], 1);
}

static inline void compressShiftRight_128(uint64x2_t *in){
    in[0][0] = (in[0][0]>>1)|(in[0][1]<<63);
    in[0][1] = (in[0][1]>>1);
}

static inline void Swapfg_128(uint8x16_t swap, uint8x16_t* av, uint8x16_t* as, uint8x16_t* sign, uint8x16_t* bv, uint8x16_t* bs){
    uint8x16_t tmp, tv, ts;
    tmp = vandq_u8(swap, veorq_u8(as[0], bs[0]));
    as[0] = veorq_u8(as[0], tmp);
    bs[0] = veorq_u8(bs[0], tmp);
    tmp = vandq_u8(swap, veorq_u8(av[0], bv[0]));
    av[0] = veorq_u8(av[0], tmp);
    bv[0] = veorq_u8(bv[0], tmp);

    tv = bitMulV(sign, av[0]);
    ts = bitMulS(tv, sign, as[0]);
    tmp = bv[0];
    bv[0] = vorrq_u8(veorq_u8(veorq_u8(bv[0], bs[0]), ts), veorq_u8(veorq_u8(tv, bs[0]), ts));
    bs[0] = vandq_u8(veorq_u8(tmp, ts), veorq_u8(bs[0], tv));
}

static inline void Swapvr_128(uint8x16_t swap, uint8x16_t* av, uint8x16_t* as, uint8x16_t* sign, uint8x16_t* bv, uint8x16_t* bs){
    uint8x16_t tmp, tv, ts;
    tmp = vandq_u8(swap, veorq_u8(as[0], bs[0]));
    as[0] = veorq_u8(as[0], tmp);
    bs[0] = veorq_u8(bs[0], tmp);
    tmp = vandq_u8(swap, veorq_u8(av[0], bv[0]));
    av[0] = veorq_u8(av[0], tmp);
    bv[0] = veorq_u8(bv[0], tmp);

    tv = bitMulV(sign, av[0]);
    ts = bitMulS(tv, sign, as[0]);
    tmp = bv[0];
    bv[0] = vorrq_u8(veorq_u8(veorq_u8(bv[0], bs[0]), ts), veorq_u8(veorq_u8(tv, bs[0]), ts));
    bs[0] = vandq_u8(veorq_u8(tmp, ts), veorq_u8(bs[0], tv));
}

static inline 
int div128(int8x16_t *uvqr, uint8x16_t* fv, uint8x16_t* fs, uint8x16_t* gv, uint8x16_t* gs, int16_t minusdelta)
{
    uint8_t stmp;
    uint8x16_t sign[2] = {0}, swap;
    uint8x16_t vs = {0}, vv = {0}, rs = {0}, rv = {0}, us = {0}, uv = {0}, qs = {0}, qv = {0};
    rv[0] = 1;
    uv[0] = 1;

    //div
    for (int z=0; z<127; z++){
        //sign = -(g[0]*f[0])
        //[0] = sign; [1] = value
        stmp = (gv[0][0]&1) & (fv[0][0]&1);
        sign[1] = vdupq_n_u8(0-stmp);
        sign[0] = vdupq_n_u8(0-(stmp&((fs[0][0]&1) ^ (fv[0][0]&1) ^ (gs[0][0]&1))));

        //swap = -1 if delta>0(sign of minusdelta == 1) and g0!=0
        swap = vdupq_n_s8(0-((minusdelta>>15) & (gv[0][0]&1)));

        //delta ^= swap&(delta^-delta);
        //delta += 1;
        minusdelta ^= (((int16x8_t)swap)[0]) & (minusdelta^-minusdelta);
        minusdelta -= 1;

        //swap f,g and v,r and u,q if swap = -1
        Swapfg_128(swap, fv, fs, sign, gv, gs);
        compressShiftRight_128((uint64x2_t*) gs);
        compressShiftRight_128((uint64x2_t*) gv);

        Swapvr_128(swap, &vv, &vs, sign, &rv, &rs);
        compressShiftLeft_128((uint64x2_t*) (&vs));
        compressShiftLeft_128((uint64x2_t*) (&vv));
        
        Swapvr_128(swap, &uv, &us, sign, &qv, &qs);
        compressShiftLeft_128((uint64x2_t*) (&us));
        compressShiftLeft_128((uint64x2_t*) (&uv));
    } 
    stmp = (gv[0][0]&1) & (fv[0][0]&1);
    sign[1] = vdupq_n_u8(0-stmp);
    sign[0] = vdupq_n_u8(0-(stmp&((fs[0][0]&1) ^ (fv[0][0]&1) ^ (gs[0][0]&1))));

    //swap = -1 if delta>0(sign of minusdelta == 1) and g0!=0
    swap = vdupq_n_s8(0-((minusdelta>>15) & (gv[0][0]&1)));

    //delta ^= swap&(delta^-delta);
    //delta += 1;
    minusdelta ^= (((int16x8_t)swap)[0]) & (minusdelta^-minusdelta);
    minusdelta -= 1;

    //swap f,g and v,r and u,q if swap = -1
    Swapfg_128(swap, fv, fs, sign, gv, gs);
    compressShiftRight_128((uint64x2_t*) gs);
    compressShiftRight_128((uint64x2_t*) gv);
    Swapvr_128(swap, &vv, &vs, sign, &rv, &rs);    
    Swapvr_128(swap, &uv, &us, sign, &qv, &qs);
    //Decompress
    itransposeCompress_2(uvqr, (uint64x2_t*)&us, (uint64x2_t*)&uv);
    itransposeCompress_2(uvqr+8, (uint64x2_t*)&vs, (uint64x2_t*)&vv);
    itransposeCompress_2(uvqr+16, (uint64x2_t*)&qs, (uint64x2_t*)&qv);
    itransposeCompress_2(uvqr+24, (uint64x2_t*)&rs, (uint64x2_t*)&rv);
    
    return minusdelta;
}

static inline 
int div127(int8x16_t *uvqr, uint8x16_t* fv, uint8x16_t* fs, uint8x16_t* gv, uint8x16_t* gs, int16_t minusdelta)
{
    uint8_t stmp;
    uint8x16_t sign[2] = {0}, swap;
    uint8x16_t vs = {0}, vv = {0}, rs = {0}, rv = {0}, us = {0}, uv = {0}, qs = {0}, qv = {0};
    rv[0] = 1;
    uv[0] = 1;

    //div
    for (int z=0; z<127; z++){
        //sign = -(g[0]*f[0])
        //[0] = sign; [1] = value
        stmp = (gv[0][0]&1) & (fv[0][0]&1);
        sign[1] = vdupq_n_u8(0-stmp);
        sign[0] = vdupq_n_u8(0-(stmp&((fs[0][0]&1) ^ (fv[0][0]&1) ^ (gs[0][0]&1))));

        //swap = -1 if delta>0(sign of minusdelta == 1) and g0!=0
        swap = vdupq_n_s8(0-((minusdelta>>15) & (gv[0][0]&1)));

        //delta ^= swap&(delta^-delta);
        //delta += 1;
        minusdelta ^= (((int16x8_t)swap)[0]) & (minusdelta^-minusdelta);
        minusdelta -= 1;

        //swap f,g and v,r and u,q if swap = -1
        Swapfg_128(swap, fv, fs, sign, gv, gs);
        compressShiftRight_128((uint64x2_t*) gs);
        compressShiftRight_128((uint64x2_t*) gv);

        Swapvr_128(swap, &vv, &vs, sign, &rv, &rs);
        compressShiftLeft_128((uint64x2_t*) (&vs));
        compressShiftLeft_128((uint64x2_t*) (&vv));
        
        Swapvr_128(swap, &uv, &us, sign, &qv, &qs);
        compressShiftLeft_128((uint64x2_t*) (&us));
        compressShiftLeft_128((uint64x2_t*) (&uv));
    }
    //Decompress
    itransposeCompress_2(uvqr, (uint64x2_t*)&us, (uint64x2_t*)&uv);
    itransposeCompress_2(uvqr+8, (uint64x2_t*)&vs, (uint64x2_t*)&vv);
    itransposeCompress_2(uvqr+16, (uint64x2_t*)&qs, (uint64x2_t*)&qv);
    itransposeCompress_2(uvqr+24, (uint64x2_t*)&rs, (uint64x2_t*)&rv);
    
    return minusdelta;
}


static inline int div124(int8x16_t *uvqr, uint8x16_t* fv, uint8x16_t* fs, uint8x16_t* gv, uint8x16_t* gs, int16_t minusdelta)
{
    uint8_t stmp;
    uint8x16_t sign[2] = {0}, swap;
    uint8x16_t vs = {0}, vv = {0}, rs = {0}, rv = {0}, us = {0}, uv = {0}, qs = {0}, qv = {0};
    rv[0] = 1;
    uv[0] = 1;

    //div
    for (int z=0; z<124; z++){
        //sign = -(g[0]*f[0])
        //[0] = sign; [1] = value
        
        stmp = (gv[0][0]&1) & (fv[0][0]&1);
        sign[1] = vdupq_n_u8(0-stmp);
        sign[0] = vdupq_n_u8(0-(stmp&((fs[0][0]&1) ^ (fv[0][0]&1) ^ (gs[0][0]&1))));

        //swap = -1 if delta>0(sign of minusdelta == 1) and g0!=0
        //swap = int16_negative_mask(-delta) & int16_nonzero_mask(g[0]);
        swap = vdupq_n_s8(0-((minusdelta>>15) & (gv[0][0]&1)));

        //delta ^= swap&(delta^-delta);
        //delta += 1;
        minusdelta ^= (((int16x8_t)swap)[0]) & (minusdelta^-minusdelta);
        minusdelta -= 1;

        //swap f,g and v,r and u,q if swap = -1
        Swapfg_128(swap, fv, fs, sign, gv, gs);
        compressShiftRight_128((uint64x2_t*) gs);
        compressShiftRight_128((uint64x2_t*) gv);

        Swapvr_128(swap, &vv, &vs, sign, &rv, &rs);
        compressShiftLeft_128((uint64x2_t*) (&vs));
        compressShiftLeft_128((uint64x2_t*) (&vv));
        
        Swapvr_128(swap, &uv, &us, sign, &qv, &qs);
        compressShiftLeft_128((uint64x2_t*) (&us));
        compressShiftLeft_128((uint64x2_t*) (&uv));
    }    
    //Decompress
    itransposeCompress_2(uvqr, (uint64x2_t*)&us, (uint64x2_t*)&uv);
    itransposeCompress_2(uvqr+8, (uint64x2_t*)&vs, (uint64x2_t*)&vv);
    itransposeCompress_2(uvqr+16, (uint64x2_t*)&qs, (uint64x2_t*)&qv);
    itransposeCompress_2(uvqr+24, (uint64x2_t*)&rs, (uint64x2_t*)&rv);
    
    return minusdelta;
}

static inline 
int div128x(int8x16_t *uvqr, uint8x16_t* fv, uint8x16_t* fs, uint8x16_t* gv, uint8x16_t* gs, int16_t minusdelta)
{
    uint8_t stmp;
    uint8x16_t sign[2] = {0}, swap;
    uint8x16_t vs = {0}, vv = {0}, rs = {0}, rv = {0}, us = {0}, uv = {0}, qs = {0}, qv = {0};
    rv[0] = 1;
    uv[0] = 1;

    //div
    for (int z=0; z<113; z++){
        //sign = -(g[0]*f[0])
        //[0] = sign; [1] = value
        stmp = (gv[0][0]&1) & (fv[0][0]&1);
        sign[1] = vdupq_n_u8(0-stmp);
        sign[0] = vdupq_n_u8(0-(stmp&((fs[0][0]&1) ^ (fv[0][0]&1) ^ (gs[0][0]&1))));

        //swap = -1 if delta>0(sign of minusdelta == 1) and g0!=0
        //swap = int16_negative_mask(-delta) & int16_nonzero_mask(g[0]);
        swap = vdupq_n_s8(0-((minusdelta>>15) & (gv[0][0]&1)));

        //delta ^= swap&(delta^-delta);
        //delta += 1;
        minusdelta ^= (((int16x8_t)swap)[0]) & (minusdelta^-minusdelta);
        minusdelta -= 1;

        //swap f,g and v,r and u,q if swap = -1
        Swapfg_128(swap, fv, fs, sign, gv, gs);
        compressShiftRight_128((uint64x2_t*) gs);
        compressShiftRight_128((uint64x2_t*) gv);

        Swapvr_128(swap, &vv, &vs, sign, &rv, &rs);
        compressShiftLeft_128((uint64x2_t*) (&vs));
        compressShiftLeft_128((uint64x2_t*) (&vv));
        
        Swapvr_128(swap, &uv, &us, sign, &qv, &qs);
        compressShiftLeft_128((uint64x2_t*) (&us));
        compressShiftLeft_128((uint64x2_t*) (&uv));
    }    
    //Decompress
    itransposeCompress_2(uvqr, (uint64x2_t*)&us, (uint64x2_t*)&uv);
    itransposeCompress_2(uvqr+8, (uint64x2_t*)&vs, (uint64x2_t*)&vv);
    itransposeCompress_2(uvqr+16, (uint64x2_t*)&qs, (uint64x2_t*)&qv);
    itransposeCompress_2(uvqr+24, (uint64x2_t*)&rs, (uint64x2_t*)&rv);
    
    return minusdelta;
}
#endif