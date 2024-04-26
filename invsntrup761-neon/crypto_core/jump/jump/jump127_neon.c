#include "jump_neon.h"
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>

#include <stdio.h>

int jump127(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[96], fg[32], NTT_uvqr[128];

    delta = jump63(delta, f, g, buf);
    polymul_64x64_rader_in(NTT_uvqr, NTT_uvqr+16, buf, buf+8);
    polymul_64x64_rader_in(NTT_uvqr+32, NTT_uvqr+48, buf+16, buf+24);
    matrixmul_64x64_uvqr_fg_NTT_fgx1(fg, NTT_uvqr, f+8, g+8);

    for (int i = 0; i < 8; i++)
    {
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+32]));
        fg[i+16] = barrett_fake(vaddq_s16(fg[i+16], buf[i+40]));
    }

    delta = jump64(delta, fg, fg + 16, buf + 48);
    polymul_64x64_rader_in(NTT_uvqr+64, NTT_uvqr+80, buf+48, buf+56);
    polymul_64x64_rader_in(NTT_uvqr+96, NTT_uvqr+112, buf+64, buf+72);
    matrixmul_64x64_uvqr_fg_NTT_fx1(uvqr+64, NTT_uvqr+64, fg+8, fg+24);

    for (int i = 0; i < 8; i++)
    {
        uvqr[i + 64] = barrett_fake(vaddq_s16(uvqr[i + 64], buf[i + 80]));
        uvqr[i + 80] = barrett_fake(vaddq_s16(uvqr[i + 80], buf[i + 88]));
    }

    matrixmul_64x64_uvqr_NTT_uvx1(uvqr, NTT_uvqr);
    
    return (delta);
}

int jump124(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[81], fg[32], NTT_uvqr[128];

    delta = jump62(delta, f, g, buf);
    polymul_64x64_rader_in(NTT_uvqr, NTT_uvqr+16, buf, buf+8);
    polymul_64x64_rader_in(NTT_uvqr+32, NTT_uvqr+48, buf+16, buf+24);
    matrixmul_64x64_uvqr_fg_NTT_fgx2(fg, NTT_uvqr, f+8, g+8);
    for (int i = 0; i < 8; i++)
    {
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+32]));
        fg[i+16] = barrett_fake(vaddq_s16(fg[i+16], buf[i+40]));
    }

    delta = jump62x(delta, fg, fg + 16, buf + 48);
    polymul_64x64_rader_in(NTT_uvqr+64, NTT_uvqr+80, buf+48, buf+56);
    uvqr[32][0] = buf[80][0];

    matrixmul_64x64_uvqr_NTTx(uvqr, NTT_uvqr);
    return (delta);
}