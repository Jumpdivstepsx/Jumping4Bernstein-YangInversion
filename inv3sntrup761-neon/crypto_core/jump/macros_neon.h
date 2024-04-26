#ifndef _MACROS_NEON_H_
#define _MACROS_NEON_H_

#include <arm_neon.h>

#define v0_8x16 vdupq_n_s8(0)
#define v1_8x16 vdupq_n_s8(1)
#define v6_8x16 vdupq_n_s8(6)
#define v01_8x16 vsetq_lane_s8(1, v0_8x16, 0)

#define uv0 vdupq_n_u8(0)
#define uv1 vdupq_n_u8(1)
#define uv128 vdupq_n_u8(128)
#define uv01 vsetq_lane_s8(1, uv0, 0)

#define v1_8x8 vdup_n_s8(1)
#define minus1  vdup_n_s8(-1)

static int8x16_t mod3 = { 0,1,2,0, 1,2,0,1, 2,0,1,2, 0,1,2,0 };
static uint8x16_t umod3 = { 0,1,2,0, 1,2,0,1, 2,0,1,2, 0,1,2,0 };
static int8x16_t mod3_2 = { 0,1,-1,0, 1,-1,0,1, -1,0,1,-1, 0,1,-1,0 };

static uint8x16_t lm = {0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0};
static uint8x16_t sm = {0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0};

// reduce value: 0 - 15
static inline int8x16_t reduce_15( int8x16_t a ) { 
    return vqtbl1q_s8(mod3, (uint8x16_t)a);
}

// reduce value: 0 - 15 to (-1 0 1)
static inline int8x16_t reduce_15_2( int8x16_t a ) { 
    return vqtbl1q_s8(mod3_2, (uint8x16_t)a);
}

static inline uint8x16_t bitMulV(uint8x16_t* sign, uint8x16_t av){
    return vandq_u8(av, sign[1]);
}

static inline uint8x16_t bitMulS(uint8x16_t cv, uint8x16_t* sign, uint8x16_t as){
    return vandq_u8(cv, veorq_u8(as, sign[0]));
}

/* return -1 if x<0; otherwise return 0 */
static inline int int16_negative_mask(int16_t x){
    uint16_t u = x;
    u >>= 15;
    return -(int) u;
}

static inline int int16_nonzero_mask(int16_t x)
{
    uint16_t u = x;
    uint32_t v = u;
    v = -v;
    v >>= 31;
    return -v;
}

#endif