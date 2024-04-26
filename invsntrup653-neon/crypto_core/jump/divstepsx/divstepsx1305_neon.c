#include "divstepsx_neon.h"
#include "macros_neon.h"
#include <arm_neon.h>

// 672 = 8 * 84
int div1305(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr, int* res)
{
    int16_t f0, g0;
    int16x8_t f0vec, g0vec, maskvec;
    int16x8_t f[84], g[84], u[84], v[84], q[84], r[84];
    int16x8_t minusdelta_v, delta_v, mask, temp, gx, ux, vx, qx, rx;
    int i, j;

    minusdelta_v = vdupq_n_s16((int16_t)-delta);
    delta_v = vdupq_n_s16((int16_t)delta);

    for (i = 0; i < 84; i++)
    {
        f[i] = barrett_fake(fi[i]);
        g[i] = barrett_fake(gi[i]);
    }

    for (i = 0; i < 84; i++)
    {
        u[i] = v[i] = q[i] = r[i] = v0_16;
    }
    u[0] = r[0] = v01_16;

    for (i = 1305; i > 0; i--) // top input should be 0 !!
    {
        // g[0] = center_adjust( g[0] );
        // get mask value and store in temp, mask is use for checking if f and g needs to swap
        temp = vandq_s16(vmvnq_s16(vreinterpretq_s16_u16(vceqq_s16(g[0], v0_16))), vshrq_n_s16(minusdelta_v, 15));
        // maskvec = -1(g0!=0 and delta>0),  0(else)
        maskvec = vdupq_laneq_s16(temp, 0);
        // temp = -delta(mask=0), delta(mask=-1) negate delta with result of maskvec
        temp = veorq_s16(vmulq_s16(minusdelta_v, maskvec), vandq_s16(vmvnq_s16(maskvec), minusdelta_v));
        // delta+1
        minusdelta_v = vsubq_s16(temp, v01_16);

        // swap f,g with result of maskvec
        gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f[0], g[0]);
        f[0] = vbslq_s16(vreinterpretq_u16_s16(maskvec), g[0], f[0]);

        // g = g*f[0] - f*g[0]
        g0vec = vdupq_laneq_s16(gx, 0);
        f0vec = vdupq_laneq_s16(f[0], 0);
        g[0] = vsubq_s16(montproduct(gx, f0vec), montproduct(f[0], g0vec));
        for (j = 1; j < 84; j++)
        {
            gx = vbslq_s16(vreinterpretq_u16_s16(maskvec), f[j], g[j]);
            f[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), g[j], f[j]);
            g[j] = vsubq_s16(montproduct(gx, f0vec), montproduct(f[j], g0vec));
        }

        // g = g/x
        gx = g[0];
        for (j = 0; j < 83; j++)
        {
            g[j] = vextq_s16(g[j], g[j + 1], 1);
        }
        g[83] = vextq_s16(g[83], gx, 1);

        // r = r*f[0] - v*g[0]
        for (j = 0; j < 84; j++)
        {
            rx = vbslq_s16(vreinterpretq_u16_s16(maskvec), v[j], r[j]);
            v[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), r[j], v[j]);
            r[j] = vsubq_s16(montproduct(rx, f0vec), montproduct(v[j], g0vec));
        }

        // v = vx
        for (j = 83; j > 0; j--)
        {
            v[j] = vextq_s16(v[j - 1], v[j], 7);
        }
        v[0] = vextq_s16(v0_16, v[0], 7);

        // q = q*f[0] - u*g[0]
        for (j = 0; j < 84; j++)
        {
            qx = vbslq_s16(vreinterpretq_u16_s16(maskvec), u[j], q[j]);
            u[j] = vbslq_s16(vreinterpretq_u16_s16(maskvec), q[j], u[j]);
            q[j] = vsubq_s16(montproduct(qx, f0vec), montproduct(u[j], g0vec));
        }

        // u = ux
        for (j = 83; j > 0; j--)
        {
            u[j] = vextq_s16(u[j - 1], u[j], 7);
        }
        u[0] = vextq_s16(v0_16, u[0], 7);
    }

    for (i = 0; i < 84; i++)
    {
        uvqr[i] = barrett_fake(v[i]);
    }
    res[0] = f[0][0];
    return (-(int16_t)vgetq_lane_s16(minusdelta_v, 0));
}