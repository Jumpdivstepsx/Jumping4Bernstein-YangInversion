#include <arm_neon.h>
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"


void matrixmul_768x768_uvqr_fg64_NTT_fgx2(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    // out[0-15] = f, out[16-31] = g
    int16x8_t NTT_f[96], NTT_g[96], NTT_res[2][96];
    int16x8_t ff[96] = {0}, gg[96] = {0};
    for (int i=0; i<64; i++){
        ff[i] = f[i];
        gg[i] = g[i];
    }
    polymul_768x768_rader_in(NTT_f, NTT_g, ff, gg);

    polymul_768x768_rader_16x16_x2(NTT_res[0], NTT_uvqr   , NTT_f);
    polymul_768x768_rader_16x16_x2(NTT_res[1], NTT_uvqr+96, NTT_g);
    for (int i = 0; i < 96; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_768x768_rader_out_x2(out, NTT_res[0]);

    polymul_768x768_rader_16x16_x2(NTT_res[0], NTT_uvqr+192, NTT_f);
    polymul_768x768_rader_16x16_x2(NTT_res[1], NTT_uvqr+288, NTT_g);
    for (int i = 0; i < 96; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_768x768_rader_out_x2(out+96, NTT_res[0]);
}

void matrixmul_768x768_uvqr_NTT_vr(int16x8_t* out, int16x8_t *NTT_uvqr, int16x8_t *b, int16x8_t *d)
{
    int16x8_t NTT_res[2][96];
    polymul_768x768_rader_16x16(NTT_res[0], NTT_uvqr   , b);
    polymul_768x768_rader_16x16(NTT_res[1], NTT_uvqr+96, d);
    for (int i = 0; i < 96; i++) out[i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    
    polymul_768x768_rader_16x16(NTT_res[0], NTT_uvqr+192, b);
    polymul_768x768_rader_16x16(NTT_res[1], NTT_uvqr+288, d);
    for (int i = 0; i < 96; i++) out[i+96] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
}

void matrixmul_768x768_uvqr_NTT_uv(int16x8_t *out, int16x8_t *uv, int16x8_t *abcd)
{
    int16x8_t NTT_res[2][96];
    polymul_768x768_rader_16x16(NTT_res[0], uv   , abcd);
    polymul_768x768_rader_16x16(NTT_res[1], uv+96, abcd+192);
    for (int i = 0; i < 96; i++) out[i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));

    polymul_768x768_rader_16x16(NTT_res[0], uv   , abcd+96 );
    polymul_768x768_rader_16x16(NTT_res[1], uv+96, abcd+288);
    for (int i = 0; i < 96; i++) out[i+96] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
}

void matrixmul_768x768_uvqr_NTT(int16x8_t *out, int16x8_t *NTT_uvqr)
{
    int16x8_t NTT_res[2][96];
    polymul_768x768_rader_16x16(NTT_res[0], NTT_uvqr+384, NTT_uvqr);
    polymul_768x768_rader_16x16(NTT_res[1], NTT_uvqr+480, NTT_uvqr+192);
    for (int i = 0; i < 96; i++) out[i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));

    polymul_768x768_rader_16x16(NTT_res[0], NTT_uvqr+384, NTT_uvqr+96);
    polymul_768x768_rader_16x16(NTT_res[1], NTT_uvqr+480, NTT_uvqr+288);
    for (int i = 0; i < 96; i++) out[i+96] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    
    polymul_768x768_rader_16x16(NTT_res[0], NTT_uvqr+576, NTT_uvqr);
    polymul_768x768_rader_16x16(NTT_res[1], NTT_uvqr+672, NTT_uvqr+192);
    for (int i = 0; i < 96; i++) out[i+192] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    
    polymul_768x768_rader_16x16(NTT_res[0], NTT_uvqr+576, NTT_uvqr+96);
    polymul_768x768_rader_16x16(NTT_res[1], NTT_uvqr+672, NTT_uvqr+288);
    for (int i = 0; i < 96; i++) out[i+288] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
}