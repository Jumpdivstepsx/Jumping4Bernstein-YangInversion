#include "jump_neon.h"
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>
#include <stdio.h>

int jump660(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    //392 = 84*4 + 28*2
    int16x8_t abuf[392] = {0}, bbuf[392] = {0}, cbuf[392] = {0}, fg[168];
    int16x8_t NTT_uvqr[1344];
    int16x8x4_t NTT_vr[168];

    delta = jump220(delta, f, g, abuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr, abuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+168, abuf+84);
    polymul_672x672_GoodThomas_in(NTT_uvqr+336, abuf+168);
    polymul_672x672_GoodThomas_in(NTT_uvqr+504, abuf+252);
    matrixmul_672x672_uvqr_fg_NTT_fgx4(fg, NTT_uvqr, f+28, g+28);
    for (int i = 0; i < 28; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], abuf[i+336]));
        fg[i+84] = barrett_fake(vaddq_s16(fg[i+84], abuf[i+364]));
    }

    delta = jump220(delta, fg, fg+84, bbuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+672, bbuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+840, bbuf+84);
    polymul_672x672_GoodThomas_in(NTT_uvqr+1008, bbuf+168);
    polymul_672x672_GoodThomas_in(NTT_uvqr+1176, bbuf+252);
    matrixmul_672x672_uvqr_fg_NTT_fgx4(fg, NTT_uvqr+672, fg+28, fg+112);
    for (int i = 0; i < 28; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], bbuf[i + 336]));
        fg[i+84] = barrett_fake(vaddq_s16(fg[i+84], bbuf[i + 364]));
    }
    matrixmul_672x672_uvqr_NTT_vr(NTT_vr, NTT_uvqr+672, NTT_uvqr+168, NTT_uvqr+504);

    delta = jump220(delta, fg, fg+84, cbuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+672, cbuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+840, cbuf+84);
    polymul_672x672_GoodThomas_in(NTT_uvqr+1008, cbuf+168);
    polymul_672x672_GoodThomas_in(NTT_uvqr+1176, cbuf+252);
    matrixmul_672x672_uvqr_fg_NTT_fgx4(uvqr+336, NTT_uvqr+672, fg+28, fg+112);
    for (int i = 0; i < 28; i++){ 
        uvqr[i+336] = barrett_fake(vaddq_s16(uvqr[i+336], cbuf[i + 336]));
        uvqr[i+420] = barrett_fake(vaddq_s16(uvqr[i+420], cbuf[i + 364]));
    }    
    polymul_672_Toom_modring(NTT_uvqr, NTT_vr);
    polymul_672_Toom_modring(NTT_uvqr+168, NTT_vr+84);
    matrixmul_672x672_uvqr_NTT_vr(NTT_vr, NTT_uvqr+672, NTT_uvqr, NTT_uvqr+168);
    polymul_672_Toom_modring(uvqr, NTT_vr);
    polymul_672_Toom_modring(uvqr+168, NTT_vr+84);
    return (delta);
}


int jump645(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0)
{
    int16x8_t abuf[392] = {0}, bbuf[392] = {0}, cbuf[392] = {0}, fg[168];
    int16x8_t NTT_uvqr[1680];
    int16x8x4_t NTT[168];

    delta = jump220(delta, f, g, abuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr, abuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+168, abuf+84);
    polymul_672x672_GoodThomas_in(NTT_uvqr+336, abuf+168);
    polymul_672x672_GoodThomas_in(NTT_uvqr+504, abuf+252);
    matrixmul_672x672_uvqr_fg_NTT_fgx4(fg, NTT_uvqr, f+28, g+28);
    for (int i = 0; i < 28; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], abuf[i+336]));
        fg[i+84] = barrett_fake(vaddq_s16(fg[i+84], abuf[i+364]));
    }

    delta = jump220(delta, fg, fg+84, bbuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+672, bbuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+840, bbuf+84);
    polymul_672x672_GoodThomas_in(NTT_uvqr+1008, bbuf+168);
    polymul_672x672_GoodThomas_in(NTT_uvqr+1176, bbuf+252);
    matrixmul_672x672_uvqr_fg_NTT_fgx4(fg, NTT_uvqr+672, fg+28, fg+112);
    for (int i = 0; i < 28; i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], bbuf[i + 336]));
        fg[i+84] = barrett_fake(vaddq_s16(fg[i+84], bbuf[i + 364]));
    }

    delta = jump205(delta, fg, fg+84, cbuf, f0);
    polymul_672x672_GoodThomas_in(NTT_uvqr+1344, cbuf);
    polymul_672x672_GoodThomas_in(NTT_uvqr+1512, cbuf+84);
    matrixmul_672x672_uvqr_NTT_uv(NTT, NTT_uvqr+1344, NTT_uvqr+672);
    polymul_672_Toom_modring(NTT_uvqr+1344, NTT);
    polymul_672_Toom_modring(NTT_uvqr+1512, NTT+84);
    matrixmul_672x672_uvqr_NTT_uv(NTT, NTT_uvqr+1344, NTT_uvqr);
    polymul_672_Toom_modring(uvqr, NTT);
    polymul_672_Toom_modring(uvqr+168, NTT+84);

    return (delta);
}