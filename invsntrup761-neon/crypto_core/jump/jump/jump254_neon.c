#include "jump_neon.h"
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>

int jump254(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    int16x8_t buf[192], fg[64], NTT_uvqr[256];
    delta = jump127(delta, f, g, buf);
    polymul_128x128_rader_in(NTT_uvqr, NTT_uvqr+32, buf, buf+16);
    polymul_128x128_rader_in(NTT_uvqr+64, NTT_uvqr+96, buf+32, buf+48);
    matrixmul_128x128_uvqr_fg_NTT_fgx1(fg, NTT_uvqr, f+16, g+16);
    for (int i = 0; i < 16; i++){
        fg[i] = (vaddq_s16(fg[i], buf[i + 64]));
        fg[i + 32] = (vaddq_s16(fg[i + 32], buf[i + 80]));
    }

    delta = jump127(delta, fg, fg + 32, buf + 96);
    polymul_128x128_rader_in(NTT_uvqr+128, NTT_uvqr+160, buf+96, buf+112);
    polymul_128x128_rader_in(NTT_uvqr+192, NTT_uvqr+224, buf+128, buf+144);
    matrixmul_128x128_uvqr_fg_NTT_fgx1(uvqr+384, NTT_uvqr+128, fg+16, fg+48);
    for (int i = 0; i < 16; i++){
        uvqr[i+384] = barrett_fake(vaddq_s16(uvqr[i+384], buf[i+160]));
        uvqr[i+416] = barrett_fake(vaddq_s16(uvqr[i+416], buf[i+176]));
    }

    // Merge uvqr
    matrixmul_128x128_uvqr_NTT(uvqr, NTT_uvqr);
    return (delta);
}


int jump251(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    int16x8_t buf[129], fg[64], NTT_uvqr[256];
    delta = jump127(delta, f, g, buf);
    polymul_128x128_rader_in(NTT_uvqr, NTT_uvqr+32, buf, buf+16);
    polymul_128x128_rader_in(NTT_uvqr+64, NTT_uvqr+96, buf+32, buf+48);
    matrixmul_128x128_uvqr_fg_NTT_fgx1(fg, NTT_uvqr, f+16, g+16);
    for (int i = 0; i < 16; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i + 64]));
        fg[i + 32] = barrett_fake(vaddq_s16(fg[i + 32], buf[i + 80]));
    }
    
    delta = jump124(delta, fg, fg + 32, buf + 96);
    polymul_128x128_rader_in(NTT_uvqr+128, NTT_uvqr+160, buf+96, buf+112);
    uvqr[192][0] = buf[128][0];

    // Merge uvqr
    matrixmul_128x128_uvqr_NTTx(uvqr, NTT_uvqr);
    return (delta);
}
