#include "divstepsx_neon.h"
#include "macros_neon.h"
#include <arm_neon.h>
#include <stdio.h>

int div7(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr)
{
    int16_t f0, g0;
    int16x8_t f0vec, g0vec, maskvec;
    int16x8_t f, g, u = {0}, v = {0}, q = {0}, r = {0};
    int16x8_t minusdelta_v, delta_v, mask, temp, gx, qx, rx;
    int i, j;

    minusdelta_v = vdupq_n_s16((int16_t)-delta);
    delta_v = vdupq_n_s16((int16_t)delta);
    f = barrett_fake(fi[0]);
    g = barrett_fake(gi[0]);    
    u = r = v01;
    for (i = 7; i > 0; i--)
    {
        g = barrett_fake(g);
        // g[0] = center_adjust( g[0] );
        //  get mask value and store in temp, mask is use for checking if f and g needs to exchange
        temp = vandq_s16(vmvnq_s16(vreinterpretq_s16_u16(vceqq_s16(g, v0))), vshrq_n_s16(minusdelta_v, 15));
        // maskvec = -1(g0!=0 and delta>0),  0(else)
        maskvec = vdupq_laneq_s16(temp, 0);
        // temp = -delta(mask=0), delta(mask=-1) negate delta with result of maskvec
        temp = veorq_s16(vmulq_s16(minusdelta_v, maskvec), vandq_s16(vmvnq_s16(maskvec), minusdelta_v));
        // delta+1
        minusdelta_v = vsubq_s16(temp, v01);

        // Exchange f,g with result of maskvec
        gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f, g);
        f = vbslq_s16(vreinterpretq_u16_s16(maskvec), g, f);

        // g = g*f[0] - f*g[0]
        g0vec = vdupq_laneq_s16(gx, 0);
        f0vec = vdupq_laneq_s16(f, 0);
        g = vsubq_s16(montproduct(gx, f0vec), montproduct(f, g0vec));        

        // g = g/x
        g = vextq_s16(g, v0, 1);

        // r = r*f[0] - v*g[0]
        rx = vbslq_s16(vreinterpretq_u16_s16(maskvec), v, r);
        v = vbslq_s16(vreinterpretq_u16_s16(maskvec), r, v);
        r = vsubq_s16(montproduct(rx, f0vec), montproduct(v, g0vec));

        // q = q*f[0] - u*g[0]
        qx = vbslq_s16(vreinterpretq_u16_s16(maskvec), u, q);
        u = vbslq_s16(vreinterpretq_u16_s16(maskvec), q, u);
        q = vsubq_s16(montproduct(qx, f0vec), montproduct(u, g0vec));

        v = vextq_s16(v0, v, 7);
        u = vextq_s16(v0, u, 7);
    }    

    uvqr[0] = barrett_fake(u);
    uvqr[1] = barrett_fake(v);
    uvqr[2] = barrett_fake(q);
    uvqr[3] = barrett_fake(r);
    uvqr[4] = barrett_fake(f);
    uvqr[5] = barrett_fake(g);

    return (-(int16_t)vgetq_lane_s16(minusdelta_v, 0));
}

int div8(int delta, int16x8_t* fi, int16x8_t* gi, int16x8_t *uvqr)
{
    int16_t f0, g0;
    int16x8_t f0vec, g0vec, maskvec;
    int16x8_t f, g, u, v = {0}, q = {0}, r;
    int16x8_t minusdelta_v, delta_v, mask, temp, gx, qx, rx;
    int i, j;

    minusdelta_v = vdupq_n_s16((int16_t)-delta);
    delta_v = vdupq_n_s16((int16_t)delta);
    f = barrett_fake(fi[0]);
    g = barrett_fake(gi[0]);
    u = r = v01;
    for (i = 7; i > 0; i--)
    {
        g = barrett_fake(g);
        // g[0] = center_adjust( g[0] );
        //  get mask value and store in temp, mask is use for checking if f and g needs to exchange
        temp = vandq_s16(vmvnq_s16(vreinterpretq_s16_u16(vceqq_s16(g, v0))), vshrq_n_s16(minusdelta_v, 15));
        // maskvec = -1(g0!=0 and delta>0),  0(else)
        maskvec = vdupq_laneq_s16(temp, 0);
        // temp = -delta(mask=0), delta(mask=-1) negate delta with result of maskvec
        temp = veorq_s16(vmulq_s16(minusdelta_v, maskvec), vandq_s16(vmvnq_s16(maskvec), minusdelta_v));
        // delta+1
        minusdelta_v = vsubq_s16(temp, v01);

        // Exchange f,g with result of maskvec
        gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f, g);
        f = vbslq_s16(vreinterpretq_u16_s16(maskvec), g, f);

        // g = g*f[0] - f*g[0]
        g0vec = vdupq_laneq_s16(gx, 0);
        f0vec = vdupq_laneq_s16(f, 0);
        g = vsubq_s16(montproduct(gx, f0vec), montproduct(f, g0vec));

        // g = g/x
        g = vextq_s16(g, v0, 1);

        // r = r*f[0] - v*g[0]
        rx = vbslq_s16(vreinterpretq_u16_s16(maskvec), v, r);
        v = vbslq_s16(vreinterpretq_u16_s16(maskvec), r, v);
        r = vsubq_s16(montproduct(rx, f0vec), montproduct(v, g0vec));

        // q = q*f[0] - u*g[0]
        qx = vbslq_s16(vreinterpretq_u16_s16(maskvec), u, q);
        u = vbslq_s16(vreinterpretq_u16_s16(maskvec), q, u);
        q = vsubq_s16(montproduct(qx, f0vec), montproduct(u, g0vec));

        v = vextq_s16(v0, v, 7);
        u = vextq_s16(v0, u, 7);
    }

    g = barrett_fake(g);
    // g[0] = center_adjust( g[0] );
    //  get mask value and store in temp, mask is use for checking if f and g needs to exchange
    temp = vandq_s16(vmvnq_s16(vreinterpretq_s16_u16(vceqq_s16(g, v0))), vshrq_n_s16(minusdelta_v, 15));
    // maskvec = -1(g0!=0 and delta>0),  0(else)
    maskvec = vdupq_laneq_s16(temp, 0);
    // temp = -delta(mask=0), delta(mask=-1) negate delta with result of maskvec
    temp = veorq_s16(vmulq_s16(minusdelta_v, maskvec), vandq_s16(vmvnq_s16(maskvec), minusdelta_v));
    // delta+1
    minusdelta_v = vsubq_s16(temp, v01);

    // Exchange f,g with result of maskvec
    gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f, g);
    f = vbslq_s16(vreinterpretq_u16_s16(maskvec), g, f);

    // g = g*f[0] - f*g[0]
    g0vec = vdupq_laneq_s16(gx, 0);
    f0vec = vdupq_laneq_s16(f, 0);
    g = vsubq_s16(montproduct(gx, f0vec), montproduct(f, g0vec));        

    // g = g/x
    g = vextq_s16(g, v0, 1);

    // r = r*f[0] - v*g[0]
    rx = vbslq_s16(vreinterpretq_u16_s16(maskvec), v, r);
    v = vbslq_s16(vreinterpretq_u16_s16(maskvec), r, v);
    r = vsubq_s16(montproduct(rx, f0vec), montproduct(v, g0vec));

    // q = q*f[0] - u*g[0]
    qx = vbslq_s16(vreinterpretq_u16_s16(maskvec), u, q);
    u = vbslq_s16(vreinterpretq_u16_s16(maskvec), q, u);
    q = vsubq_s16(montproduct(qx, f0vec), montproduct(u, g0vec));    

    uvqr[0] = barrett_fake(u);
    uvqr[1] = barrett_fake(v);
    uvqr[2] = barrett_fake(q);
    uvqr[3] = barrett_fake(r);
    uvqr[4] = barrett_fake(f);
    uvqr[5] = barrett_fake(g);

    return (-(int16_t)vgetq_lane_s16(minusdelta_v, 0));
}

int div8x(int delta, int16x8_t* fi, int16x8_t* gi, int16x8_t *uvqr, int* res)
{
    int16_t f0, g0;
    int16x8_t f0vec, g0vec, maskvec;
    int16x8_t f, g, u = {0}, v = {0}, q = {0}, r = {0};
    int16x8_t minusdelta_v, delta_v, mask, temp, gx, qx, rx;
    int i, j;

    minusdelta_v = vdupq_n_s16((int16_t)-delta);
    delta_v = vdupq_n_s16((int16_t)delta);
    f = barrett_fake(fi[0]);
    g = barrett_fake(gi[0]);    
    u = r = v01;
    for (i = 7; i > 0; i--)
    {
        g = barrett_fake(g);
        // g[0] = center_adjust( g[0] );
        //  get mask value and store in temp, mask is use for checking if f and g needs to exchange
        temp = vandq_s16(vmvnq_s16(vreinterpretq_s16_u16(vceqq_s16(g, v0))), vshrq_n_s16(minusdelta_v, 15));
        // maskvec = -1(g0!=0 and delta>0),  0(else)
        maskvec = vdupq_laneq_s16(temp, 0);
        // temp = -delta(mask=0), delta(mask=-1) negate delta with result of maskvec
        temp = veorq_s16(vmulq_s16(minusdelta_v, maskvec), vandq_s16(vmvnq_s16(maskvec), minusdelta_v));
        // delta+1
        minusdelta_v = vsubq_s16(temp, v01);

        // Exchange f,g with result of maskvec
        gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f, g);
        f = vbslq_s16(vreinterpretq_u16_s16(maskvec), g, f);

        // g = g*f[0] - f*g[0]
        g0vec = vdupq_laneq_s16(gx, 0);
        f0vec = vdupq_laneq_s16(f, 0);
        g = vsubq_s16(montproduct(gx, f0vec), montproduct(f, g0vec));        

        // g = g/x
        g = vextq_s16(g, v0, 1);

        // r = r*f[0] - v*g[0]
        rx = vbslq_s16(vreinterpretq_u16_s16(maskvec), v, r);
        v = vbslq_s16(vreinterpretq_u16_s16(maskvec), r, v);
        r = vsubq_s16(montproduct(rx, f0vec), montproduct(v, g0vec));

        // q = q*f[0] - u*g[0]
        qx = vbslq_s16(vreinterpretq_u16_s16(maskvec), u, q);
        u = vbslq_s16(vreinterpretq_u16_s16(maskvec), q, u);
        q = vsubq_s16(montproduct(qx, f0vec), montproduct(u, g0vec));

        v = vextq_s16(v0, v, 7);
        u = vextq_s16(v0, u, 7);
    }

    g = barrett_fake(g);
    // g[0] = center_adjust( g[0] );
    //  get mask value and store in temp, mask is use for checking if f and g needs to exchange
    temp = vandq_s16(vmvnq_s16(vreinterpretq_s16_u16(vceqq_s16(g, v0))), vshrq_n_s16(minusdelta_v, 15));
    // maskvec = -1(g0!=0 and delta>0),  0(else)
    maskvec = vdupq_laneq_s16(temp, 0);
    // temp = -delta(mask=0), delta(mask=-1) negate delta with result of maskvec
    temp = veorq_s16(vmulq_s16(minusdelta_v, maskvec), vandq_s16(vmvnq_s16(maskvec), minusdelta_v));
    // delta+1
    minusdelta_v = vsubq_s16(temp, v01);

    // Exchange f,g with result of maskvec
    gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f, g);
    f = vbslq_s16(vreinterpretq_u16_s16(maskvec), g, f);

    // g = g*f[0] - f*g[0]
    g0vec = vdupq_laneq_s16(gx, 0);
    f0vec = vdupq_laneq_s16(f, 0);
    g = vsubq_s16(montproduct(gx, f0vec), montproduct(f, g0vec));        

    // g = g/x
    g = vextq_s16(g, v0, 1);

    // r = r*f[0] - v*g[0]
    rx = vbslq_s16(vreinterpretq_u16_s16(maskvec), v, r);
    v = vbslq_s16(vreinterpretq_u16_s16(maskvec), r, v);
    r = vsubq_s16(montproduct(rx, f0vec), montproduct(v, g0vec));

    // q = q*f[0] - u*g[0]
    qx = vbslq_s16(vreinterpretq_u16_s16(maskvec), u, q);
    u = vbslq_s16(vreinterpretq_u16_s16(maskvec), q, u);
    q = vsubq_s16(montproduct(qx, f0vec), montproduct(u, g0vec));    

    uvqr[0] = barrett_fake(u);
    uvqr[1] = barrett_fake(v);
    res[0] = f[0];
    return (-(int16_t)vgetq_lane_s16(minusdelta_v, 0));
}