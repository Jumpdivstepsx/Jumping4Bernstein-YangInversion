#include "jump_neon.h"
#include "macros_neon.h"
#include "polymul_neon.h"
#include "matrixmul_neon.h"
#include <arm_neon.h>
#include <stdio.h>

int jump762(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    int16x8_t abuf[448] = {0}, bbuf[448] = {0}, cbuf[448] = {0}, fg[192];
    int16x8_t NTT_uvqr[768];

    // jump
    delta = jump254(delta, f, g, abuf);
    polymul_768x768_rader_in(NTT_uvqr, NTT_uvqr+96, abuf, abuf+96);
    polymul_768x768_rader_in(NTT_uvqr+192, NTT_uvqr+288, abuf+192, abuf+288);
    matrixmul_768x768_uvqr_fg64_NTT_fgx2(fg, NTT_uvqr, f+32, g+32);
    for (int i = 0; i < 32; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], abuf[i+384]));
        fg[i+96] = barrett_fake(vaddq_s16(fg[i+96], abuf[i+416]));
    }

    // jump
    delta = jump254(delta, fg, fg+96, bbuf);
    polymul_768x768_rader_in(NTT_uvqr+384, NTT_uvqr+480, bbuf, bbuf+96);
    polymul_768x768_rader_in(NTT_uvqr+576, NTT_uvqr+672, bbuf+192, bbuf+288);
    matrixmul_768x768_uvqr_fg64_NTT_fgx2(fg, NTT_uvqr+384, fg+32, fg+128);
    for (int i = 0; i < 32; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], bbuf[i + 384]));
        fg[i+96] = barrett_fake(vaddq_s16(fg[i+96], bbuf[i + 416]));
    }
    matrixmul_768x768_uvqr_NTT_vr(NTT_uvqr, NTT_uvqr+384, NTT_uvqr+96, NTT_uvqr+288);

    // jump
    delta = jump254(delta, fg, fg+96, cbuf);
    polymul_768x768_rader_in(NTT_uvqr+384, NTT_uvqr+480, cbuf, cbuf+96);
    polymul_768x768_rader_in(NTT_uvqr+576, NTT_uvqr+672, cbuf+192, cbuf+288);
    matrixmul_768x768_uvqr_fg64_NTT_fgx2(uvqr+192, NTT_uvqr+384, fg+32, fg+128);
    for (int i = 0; i < 32; i++){ 
        uvqr[i + 192] = barrett_fake(vaddq_s16(uvqr[i + 192], cbuf[i + 384]));
        uvqr[i + 288] = barrett_fake(vaddq_s16(uvqr[i + 288], cbuf[i + 416]));
    }

    // return b, d
    matrixmul_768x768_uvqr_NTT_vr(uvqr, NTT_uvqr+384, NTT_uvqr, NTT_uvqr+96);
    return (delta);
}


int jump759(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0)
{
    int16x8_t abuf[448] = {0}, bbuf[448] = {0}, cbuf[193] = {0}, fg[192];
    int16x8_t NTT_uvqr[768];

    // jump
    delta = jump254(delta, f, g, abuf);
    polymul_768x768_rader_in(NTT_uvqr, NTT_uvqr+96, abuf, abuf+96);
    polymul_768x768_rader_in(NTT_uvqr+192, NTT_uvqr+288, abuf+192, abuf+288);
    matrixmul_768x768_uvqr_fg64_NTT_fgx2(fg, NTT_uvqr, f+32, g+32);
    for (int i = 0; i < 32; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], abuf[i+384]));
        fg[i+96] = barrett_fake(vaddq_s16(fg[i+96], abuf[i+416]));
    }   

    // jump
    delta = jump254(delta, fg, fg+96, bbuf);
    polymul_768x768_rader_in(NTT_uvqr+384, NTT_uvqr+480, bbuf, bbuf+96);
    polymul_768x768_rader_in(NTT_uvqr+576, NTT_uvqr+672, bbuf+192, bbuf+288);
    matrixmul_768x768_uvqr_fg64_NTT_fgx2(fg, NTT_uvqr+384, fg+32, fg+128);
    for (int i = 0; i < 32; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], bbuf[i + 384]));
        fg[i+96] = barrett_fake(vaddq_s16(fg[i+96], bbuf[i + 416]));
    }
    matrixmul_768x768_uvqr_NTT(abuf, NTT_uvqr);
    
    // jump
    delta = jump251(delta, fg, fg+96, cbuf);
    polymul_768x768_rader_in(NTT_uvqr+384, NTT_uvqr+480, cbuf, cbuf+96);
    f0[0] = cbuf[192][0];
    
    matrixmul_768x768_uvqr_NTT_uv(uvqr, NTT_uvqr+384, abuf);
    return (delta);
}