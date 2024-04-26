#include "divstepsx_neon.h"
#include "macros_neon.h"
#include <arm_neon.h>

#include <stdio.h>

int div251(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr)
{
    int16_t f0, g0;
    int16x8_t f0vec, g0vec, maskvec;
    int16x8_t f[32], g[32], u[32], v[32], q[32], r[32];
    int16x8_t minusdelta_v, delta_v, mask, temp, gx, ux, vx, qx, rx;
    int i, j;

    minusdelta_v = vdupq_n_s16((int16_t)-delta);
    delta_v = vdupq_n_s16((int16_t)delta);

    for (i = 0; i < 32; i++)
    {
        f[i] = barrett_fake(fi[i]);
        g[i] = barrett_fake(gi[i]);
    }

    for (i = 0; i < 32; i++)
    {
        u[i] = v[i] = q[i] = r[i] = v0;
    }
    u[0] = r[0] = v01;

    for (i = 251; i > 0; i--)
    {
        //  get mask value and store in temp, mask is use for checking if f and g needs to exchange
        temp = vandq_s16(vmvnq_s16(vreinterpretq_s16_u16(vceqq_s16(g[0], v0))), vshrq_n_s16(minusdelta_v, 15));
        // maskvec = -1(g0!=0 and delta>0),  0(else)
        maskvec = vdupq_laneq_s16(temp, 0);
        // temp = -delta(mask=0), delta(mask=-1) negate delta with result of maskvec
        temp = veorq_s16(vmulq_s16(minusdelta_v, maskvec), vandq_s16(vmvnq_s16(maskvec), minusdelta_v));
        // delta+1
        minusdelta_v = vsubq_s16(temp, v01);

        // Exchange f,g with result of maskvec
        gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f[0], g[0]);
        f[0] = vbslq_s16(vreinterpretq_u16_s16(maskvec), g[0], f[0]);

        // g = g*f[0] - f*g[0]
        g0vec = vdupq_laneq_s16(gx, 0);
        f0vec = vdupq_laneq_s16(f[0], 0);
        g[0] = vsubq_s16(montproduct(gx, f0vec), montproduct(f[0], g0vec));
        for (j = 1; j < 32; j++)
        {
            gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f[j], g[j]);
            f[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), g[j], f[j]);
            g[j] = vsubq_s16(montproduct(gx, f0vec), montproduct(f[j], g0vec));
        }

        // g = g/x
        gx = g[0];
        for (j = 0; j < 31; j++)
        {
            g[j] = vextq_s16(g[j], g[j + 1], 1);
        }
        g[31] = vextq_s16(g[31], gx, 1);

        // r = r*f[0] - v*g[0]
        for (j = 0; j < 32; j++)
        {
            rx = vbslq_s16(vreinterpretq_u16_s16(maskvec), v[j], r[j]);
            v[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), r[j], v[j]);
            r[j] = vsubq_s16(montproduct(rx, f0vec), montproduct(v[j], g0vec));
        }

        // v = vx
        vx = v[31];
        for (j = 31; j > 0; j--)
        {
            v[j] = vextq_s16(v[j - 1], v[j], 7);
        }
        v[0] = vextq_s16(vx, v[0], 7);

        // q = q*f[0] - u*g[0]
        for (j = 0; j < 32; j++)
        {
            qx = vbslq_s16(vreinterpretq_u16_s16(maskvec), u[j], q[j]);
            u[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), q[j], u[j]);
            q[j] = vsubq_s16(montproduct(qx, f0vec), montproduct(u[j], g0vec));
        }

        // u = ux
        ux = u[31];
        for (j = 31; j > 0; j--)
        {
            u[j] = vextq_s16(u[j - 1], u[j], 7);
        }
        u[0] = vextq_s16(ux, u[0], 7);
    }

    for (i = 0; i < 32; i++)
    {
        uvqr[i] = barrett_fake(u[i]);
        uvqr[i + 16] = barrett_fake(v[i]);
        uvqr[i + 32] = barrett_fake(q[i]);
        uvqr[i + 48] = barrett_fake(r[i]);
        uvqr[i + 64] = barrett_fake(f[i]);
        uvqr[i + 80] = barrett_fake(g[i]);
    }
    
    return (-(int16_t)vgetq_lane_s16(minusdelta_v, 0));
}

int div254(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr)
{
    int16_t f0, g0;
    int16x8_t f0vec, g0vec, maskvec;
    int16x8_t f[32], g[32], u[32], v[32], q[32], r[32];
    int16x8_t minusdelta_v, delta_v, mask, temp, gx, ux, vx, qx, rx;
    int i, j;

    minusdelta_v = vdupq_n_s16((int16_t)-delta);
    delta_v = vdupq_n_s16((int16_t)delta);

    for (i = 0; i < 32; i++)
    {
        f[i] = barrett_fake(fi[i]);
        g[i] = barrett_fake(gi[i]);
    }

    for (i = 0; i < 32; i++)
    {
        u[i] = v[i] = q[i] = r[i] = v0;
    }
    u[0] = r[0] = v01;

    for (i = 254; i > 0; i--)
    {
        //  get mask value and store in temp, mask is use for checking if f and g needs to exchange
        temp = vandq_s16(vmvnq_s16(vreinterpretq_s16_u16(vceqq_s16(g[0], v0))), vshrq_n_s16(minusdelta_v, 15));
        // maskvec = -1(g0!=0 and delta>0),  0(else)
        maskvec = vdupq_laneq_s16(temp, 0);
        // temp = -delta(mask=0), delta(mask=-1) negate delta with result of maskvec
        temp = veorq_s16(vmulq_s16(minusdelta_v, maskvec), vandq_s16(vmvnq_s16(maskvec), minusdelta_v));
        // delta+1
        minusdelta_v = vsubq_s16(temp, v01);

        // Exchange f,g with result of maskvec
        gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f[0], g[0]);
        f[0] = vbslq_s16(vreinterpretq_u16_s16(maskvec), g[0], f[0]);

        // g = g*f[0] - f*g[0]
        g0vec = vdupq_laneq_s16(gx, 0);
        f0vec = vdupq_laneq_s16(f[0], 0);
        g[0] = vsubq_s16(montproduct(gx, f0vec), montproduct(f[0], g0vec));
        for (j = 1; j < 32; j++)
        {
            gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f[j], g[j]);
            f[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), g[j], f[j]);
            g[j] = vsubq_s16(montproduct(gx, f0vec), montproduct(f[j], g0vec));
        }

        // g = g/x
        gx = g[0];
        for (j = 0; j < 31; j++)
        {
            g[j] = vextq_s16(g[j], g[j + 1], 1);
        }
        g[31] = vextq_s16(g[31], gx, 1);

        // r = r*f[0] - v*g[0]
        for (j = 0; j < 32; j++)
        {
            rx = vbslq_s16(vreinterpretq_u16_s16(maskvec), v[j], r[j]);
            v[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), r[j], v[j]);
            r[j] = vsubq_s16(montproduct(rx, f0vec), montproduct(v[j], g0vec));
        }

        // v = vx
        vx = v[31];
        for (j = 31; j > 0; j--)
        {
            v[j] = vextq_s16(v[j - 1], v[j], 7);
        }
        v[0] = vextq_s16(vx, v[0], 7);

        // q = q*f[0] - u*g[0]
        for (j = 0; j < 32; j++)
        {
            qx = vbslq_s16(vreinterpretq_u16_s16(maskvec), u[j], q[j]);
            u[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), q[j], u[j]);
            q[j] = vsubq_s16(montproduct(qx, f0vec), montproduct(u[j], g0vec));
        }

        // u = ux
        ux = u[31];
        for (j = 31; j > 0; j--)
        {
            u[j] = vextq_s16(u[j - 1], u[j], 7);
        }
        u[0] = vextq_s16(ux, u[0], 7);
    }

    for (i = 0; i < 32; i++)
    {
        uvqr[i] = barrett_fake(u[i]);
        uvqr[i + 16] = barrett_fake(v[i]);
        uvqr[i + 32] = barrett_fake(q[i]);
        uvqr[i + 48] = barrett_fake(r[i]);
        uvqr[i + 64] = barrett_fake(f[i]);
        uvqr[i + 80] = barrett_fake(g[i]);
    }
    
    return (-(int16_t)vgetq_lane_s16(minusdelta_v, 0));
}