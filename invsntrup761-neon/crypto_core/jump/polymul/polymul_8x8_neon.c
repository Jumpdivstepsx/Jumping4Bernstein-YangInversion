#include "macros_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>

int16x8x2_t polymul_8x8_ext(const int16x8_t a, const int16x8_t b)
{   
    // faster in cortex-a72
    int16x4x2_t *ssa = (int16x4x2_t *) &a;
    int16x4x2_t *ssb = (int16x4x2_t *) &b;

    int16x4_t a0 = ssa->val[0];
    int16x4_t a1 = ssa->val[1];
    int16x4_t b0 = ssb->val[0];
    int16x4_t b1 = ssb->val[1];
    
    //Low part
    int32x4_t c0_0 = vmull_lane_s16(a0, b0, 0);
    int32x4_t c0_1 = vmull_lane_s16(a0, b0, 1);
    int32x4_t c0_2 = vmull_lane_s16(a0, b0, 2);
    int32x4_t c0_3 = vmull_lane_s16(a0, b0, 3);
    
    //Mid part
    int32x4_t c1_0 = vmull_lane_s16(a1, b0, 0);
    int32x4_t c1_1 = vmull_lane_s16(a1, b0, 1);
    int32x4_t c1_2 = vmull_lane_s16(a1, b0, 2);
    int32x4_t c1_3 = vmull_lane_s16(a1, b0, 3);
    
    c1_0 = vmlal_lane_s16(c1_0, a0, b1, 0);
    c1_1 = vmlal_lane_s16(c1_1, a0, b1, 1);
    c1_2 = vmlal_lane_s16(c1_2, a0, b1, 2);
    c1_3 = vmlal_lane_s16(c1_3, a0, b1, 3);
    
    //High part
    int32x4_t c2_0 = vmull_lane_s16(a1, b1, 0);
    int32x4_t c2_1 = vmull_lane_s16(a1, b1, 1);
    int32x4_t c2_2 = vmull_lane_s16(a1, b1, 2);
    int32x4_t c2_3 = vmull_lane_s16(a1, b1, 3);

    int32x4_t c0 = c0_0;
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_1, 3));
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_2, 2));
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_3, 1));

    int32x4_t c1 = c1_0;
    c1 = vaddq_s32(c1, vextq_s32(c0_1, c1_1, 3));
    c1 = vaddq_s32(c1, vextq_s32(c0_2, c1_2, 2));
    c1 = vaddq_s32(c1, vextq_s32(c0_3, c1_3, 1));

    int32x4_t c2 = c2_0;
    c2 = vaddq_s32(c2, vextq_s32(c1_1, c2_1, 3));
    c2 = vaddq_s32(c2, vextq_s32(c1_2, c2_2, 2));
    c2 = vaddq_s32(c2, vextq_s32(c1_3, c2_3, 1));

    int32x4_t c3 = vextq_s32(c2_1, v0_32x4, 3);
    c3 = vaddq_s32(c3, vextq_s32(c2_2, v0_32x4, 2));
    c3 = vaddq_s32(c3, vextq_s32(c2_3, v0_32x4, 1));

    int16x8x2_t c;
    c.val[0] = barrett_fake_32x4(c0, c1);
    c.val[1] = barrett_fake_32x4(c2, c3);
    return c;
}

int16x8x2_t polymul_8x8_mont(int16x8_t a, int16x8_t b)
{
    int16x8_t m0, m1, m2, m3;

    int16x8_t b7 = vdupq_laneq_s16(b, 7);
    int16x8_t b6 = vdupq_laneq_s16(b, 6);
    int16x8_t b5 = vdupq_laneq_s16(b, 5);

    m0 = montproduct(a, b7);

    m2 = vextq_s16(v0, m0, 7);
    m3 = vextq_s16(m0, v0, 7);
    m2 = vaddq_s16(m2, montproduct(a, b6));

    m0 = vextq_s16(v0, m2, 7);
    m1 = vextq_s16(m2, m3, 7);
    m0 = vaddq_s16(m0, montproduct(a, b5));

    int16x8_t b4 = vdupq_laneq_s16(b, 4);
    int16x8_t b3 = vdupq_laneq_s16(b, 3);
    int16x8_t b2 = vdupq_laneq_s16(b, 2);

    m2 = vextq_s16(v0, m0, 7);
    m3 = vextq_s16(m0, m1, 7);
    m2 = vaddq_s16(m2, montproduct(a, b4));

    m0 = vextq_s16(v0, m2, 7);
    m1 = vextq_s16(m2, m3, 7);
    m0 = vaddq_s16(m0, montproduct(a, b3));

    m2 = vextq_s16(v0, m0, 7);
    m3 = vextq_s16(m0, m1, 7);
    m2 = vaddq_s16(m2, montproduct(a, b2));

    int16x8_t b1 = vdupq_laneq_s16(b, 1);
    int16x8_t b0 = vdupq_laneq_s16(b, 0);

    m0 = vextq_s16(v0, m2, 7);
    m1 = vextq_s16(m2, m3, 7);
    m0 = vaddq_s16(m0, montproduct(a, b1));

    m2 = vextq_s16(v0, m0, 7);
    m3 = vextq_s16(m0, m1, 7);
    m2 = vaddq_s16(m2, montproduct(a, b0));

    int16x8x2_t rr;
    rr.val[1] = montproduct(m3, v4158_16);
    rr.val[0] = montproduct(m2, v4158_16);
    return rr;
}

int16x8x2_t polymul_8x8_karatsuba(int16x8_t a, int16x8_t b)
{
    int16x4_t a0, a1, b0, b1;
    int32x4_t c0, c1, c2, c3;

    a0 = vget_low_s16(a);
    a1 = vget_high_s16(a);
    b0 = vget_low_s16(b);
    b1 = vget_high_s16(b);

    int16x4_t a0_add_a1 = vadd_s16(a0, a1);
    int16x4_t b0_add_b1 = vadd_s16(b0, b1);

    int32x4_t c0_0 = vmull_lane_s16(a0, b0, 0);
    int32x4_t c0_1 = vmull_lane_s16(a0, b0, 1);
    int32x4_t c0_2 = vmull_lane_s16(a0, b0, 2);
    int32x4_t c0_3 = vmull_lane_s16(a0, b0, 3);

    int32x4_t c2_0 = vmull_lane_s16(a1, b1, 0);
    int32x4_t c2_1 = vmull_lane_s16(a1, b1, 1);
    int32x4_t c2_2 = vmull_lane_s16(a1, b1, 2);
    int32x4_t c2_3 = vmull_lane_s16(a1, b1, 3);

    int32x4_t c1_0 = vmull_lane_s16(a0_add_a1, b0_add_b1, 0);
    int32x4_t c1_1 = vmull_lane_s16(a0_add_a1, b0_add_b1, 1);
    int32x4_t c1_2 = vmull_lane_s16(a0_add_a1, b0_add_b1, 2);
    int32x4_t c1_3 = vmull_lane_s16(a0_add_a1, b0_add_b1, 3);

    c0 = c0_0;
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_1, 3));
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_2, 2));
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_3, 1));

    c1_0 = vsubq_s32(c1_0, vaddq_s32(c0_0, c2_0));
    c1_1 = vsubq_s32(c1_1, vaddq_s32(c0_1, c2_1));
    c1_2 = vsubq_s32(c1_2, vaddq_s32(c0_2, c2_2));
    c1_3 = vsubq_s32(c1_3, vaddq_s32(c0_3, c2_3));

    c1 = c1_0;
    c1 = vaddq_s32(c1, vextq_s32(c0_1, c1_1, 3));
    c1 = vaddq_s32(c1, vextq_s32(c0_2, c1_2, 2));
    c1 = vaddq_s32(c1, vextq_s32(c0_3, c1_3, 1));

    c2 = c2_0;
    c2 = vaddq_s32(c2, vextq_s32(c1_1, c2_1, 3));
    c2 = vaddq_s32(c2, vextq_s32(c1_2, c2_2, 2));
    c2 = vaddq_s32(c2, vextq_s32(c1_3, c2_3, 1));

    c3 = vextq_s32(c2_1, v0_32x4, 3);
    c3 = vaddq_s32(c3, vextq_s32(c2_2, v0_32x4, 2));
    c3 = vaddq_s32(c3, vextq_s32(c2_3, v0_32x4, 1));

    int16x8x2_t c;

    c.val[0] = barrett_fake_32x4(c0, c1);
    c.val[1] = barrett_fake_32x4(c2, c3);
    return c;
}