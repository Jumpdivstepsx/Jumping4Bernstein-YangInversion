#include <arm_neon.h>
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"


void matrixmul_672x672_uvqr_fg_NTT_fgx4(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    // out[0-15] = f, out[16-31] = g
    int16x8x4_t NTT_res[2][84];
    int16x8_t NTT_f[168], NTT_g[168];
    int16x8_t ff[84] = {0}, gg[84] = {0};
    for (int i=0; i<56; i++){
        ff[i] = f[i];
        gg[i] = g[i];
    }
    polymul_672x672_GoodThomas_in(NTT_f, ff);
    polymul_672x672_GoodThomas_in(NTT_g, gg);

    polymul_672x672_GoodThomas_mul(NTT_res[0], NTT_uvqr   , NTT_f);
    polymul_672x672_GoodThomas_mul(NTT_res[1], NTT_uvqr+168, NTT_g);
    for (int i = 0; i < 84; i++){
        for(int j = 0;j<4;j++){
            NTT_res[0][i].val[j] = barrett_fake(vaddq_s16(NTT_res[0][i].val[j], NTT_res[1][i].val[j]));
        }
    }    
    polymul_672x672_GoodThomas_out(out, NTT_res[0]);
    for (int i = 83; i>0; i--) out[i] = vextq_s16(out[i-1], out[i], 4); 
    out[0] = vextq_s16(v0_16, out[0], 4);
    
    polymul_672x672_GoodThomas_mul(NTT_res[0], NTT_uvqr+336, NTT_f);
    polymul_672x672_GoodThomas_mul(NTT_res[1], NTT_uvqr+504, NTT_g);
    for (int i = 0; i < 84; i++){
        for(int j = 0;j<4;j++){
            NTT_res[0][i].val[j] = barrett_fake(vaddq_s16(NTT_res[0][i].val[j], NTT_res[1][i].val[j]));
        }
    }
    polymul_672x672_GoodThomas_out(out+84, NTT_res[0]);
    for (int i = 83; i>0; i--) out[i+84] = vextq_s16(out[i+83], out[i+84], 4);
    out[84] = vextq_s16(v0_16, out[84], 4);
}

void matrixmul_672x672_uvqr_NTT_vr(int16x8x4_t* out, int16x8_t *NTT_uvqr, int16x8_t *b, int16x8_t *d)
{
    int16x8x4_t NTT_res[2][84];
    polymul_672x672_GoodThomas_mul(NTT_res[0], NTT_uvqr   , b);
    polymul_672x672_GoodThomas_mul(NTT_res[1], NTT_uvqr+168, d);
    for (int i = 0; i < 84; i++){
        for(int j = 0;j<4;j++){
            out[i].val[j] = barrett_fake(vaddq_s16(NTT_res[0][i].val[j], NTT_res[1][i].val[j]));
        }
    } 
    
    polymul_672x672_GoodThomas_mul(NTT_res[0], NTT_uvqr+336, b);
    polymul_672x672_GoodThomas_mul(NTT_res[1], NTT_uvqr+504, d);
    for (int i = 0; i < 84; i++){
        for(int j = 0;j<4;j++){
            out[i+84].val[j] = barrett_fake(vaddq_s16(NTT_res[0][i].val[j], NTT_res[1][i].val[j]));
        }
    }
}

void matrixmul_672x672_uvqr_NTT_uv(int16x8x4_t* out, int16x8_t *NTT_uv, int16x8_t *NTT_uvqr)
{
    int16x8x4_t NTT_res[2][84];
    polymul_672x672_GoodThomas_mul(NTT_res[0], NTT_uv, NTT_uvqr);
    polymul_672x672_GoodThomas_mul(NTT_res[1], NTT_uv+168, NTT_uvqr+336);
    for (int i = 0; i < 84; i++){
        for(int j = 0;j<4;j++){
            out[i].val[j] = barrett_fake(vaddq_s16(NTT_res[0][i].val[j], NTT_res[1][i].val[j]));
        }
    }
    polymul_672x672_GoodThomas_mul(NTT_res[0], NTT_uv, NTT_uvqr+168);
    polymul_672x672_GoodThomas_mul(NTT_res[1], NTT_uv+168, NTT_uvqr+504);
    for (int i = 0; i < 84; i++){
        for(int j = 0;j<4;j++){
            out[i+84].val[j] = barrett_fake(vaddq_s16(NTT_res[0][i].val[j], NTT_res[1][i].val[j]));
        }
    } 
}