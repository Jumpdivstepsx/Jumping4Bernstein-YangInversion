#include <arm_neon.h>
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"
#include <stdio.h>


void matrixmul_16x16_uvqr_fg(int16x8_t *out, int16x8_t *uvqr, int16x8_t *f, int16x8_t *g)
{
    // out[0-8] = f, out[8-16] = g
    int16x8_t tmp[4];
    convert16x16(out, uvqr, f);
    convert16x16(tmp, uvqr + 2, g);
    for (int i = 0; i < 4; i++)
    {
        out[i] = barrett_fake(vaddq_s16(out[i], tmp[i]));
    }
    convert16x16(out + 4, uvqr + 4, f);
    convert16x16(tmp, uvqr + 6, g);
    for (int i = 0; i < 4; i++)
    {
        out[i + 4] = barrett_fake(vaddq_s16(out[i + 4], tmp[i]));
    }
}