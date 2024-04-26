#include <arm_neon.h>
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"
#include <string.h>

void matrixmul_128x128_uvqr_fg_NTT(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    int16x8_t NTT_f[32], NTT_g[32], NTT_res[2][32];
    polymul_128x128_rader_in(NTT_f, NTT_g, f, g);

    polymul_128x128_rader_16x16(NTT_res[0], NTT_uvqr, NTT_f);
    polymul_128x128_rader_16x16(NTT_res[1], NTT_uvqr+32, NTT_g); 
    for (int i = 0; i < 32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out(out, NTT_res[0]);

    polymul_128x128_rader_16x16(NTT_res[0], NTT_uvqr+64, NTT_f);
    polymul_128x128_rader_16x16(NTT_res[1], NTT_uvqr+96, NTT_g);
    for (int i = 0; i < 32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out(out+32, NTT_res[0]);
}

void matrixmul_128x128_uvqr_fg_NTT_fgx1(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    int16x8_t NTT_f[32], NTT_g[32], NTT_res[2][32];
    polymul_128x128_rader_in(NTT_f, NTT_g, f, g);
    polymul_128x128_rader_16x16_x1(NTT_res[0], NTT_uvqr, NTT_f);
    polymul_128x128_rader_16x16_x1(NTT_res[1], NTT_uvqr+32, NTT_g); 
    for(int i=0; i<32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    
    polymul_128x128_rader_out_x1(out, NTT_res[0]);
    polymul_128x128_rader_16x16_x1(NTT_res[0], NTT_uvqr+64, NTT_f);
    polymul_128x128_rader_16x16_x1(NTT_res[1], NTT_uvqr+96, NTT_g);
    for(int i=0; i<32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out_x1(out+32, NTT_res[0]);
}

void matrixmul_128x128_uvqr_fg_NTT_fgx4(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    int16x8_t NTT_f[32], NTT_g[32], NTT_res[2][32];
    
    polymul_128x128_rader_in(NTT_f, NTT_g, f, g);
    polymul_128x128_rader_16x16_x4(NTT_res[0], NTT_uvqr, NTT_f);
    polymul_128x128_rader_16x16_x4(NTT_res[1], NTT_uvqr+32, NTT_g); 
    for(int i=0; i<32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    
    polymul_128x128_rader_out_x4(out, NTT_res[0]);
    polymul_128x128_rader_16x16_x4(NTT_res[0], NTT_uvqr+64, NTT_f);
    polymul_128x128_rader_16x16_x4(NTT_res[1], NTT_uvqr+96, NTT_g);
    for(int i=0; i<32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out_x4(out+32, NTT_res[0]);
}


void matrixmul_128x128_uvqr_NTT(int16x8_t *out, int16x8_t *NTT_uvqr)
{
    int16x8_t NTT_res[2][32];
    polymul_128x128_rader_16x16(NTT_res[0], NTT_uvqr+128, NTT_uvqr);
    polymul_128x128_rader_16x16(NTT_res[1], NTT_uvqr+160, NTT_uvqr+64);
    for (int i = 0; i < 32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out(out, NTT_res[0]);

    polymul_128x128_rader_16x16(NTT_res[0], NTT_uvqr+128, NTT_uvqr+32);
    polymul_128x128_rader_16x16(NTT_res[1], NTT_uvqr+160, NTT_uvqr+96);
    for (int i = 0; i < 32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out(out+96, NTT_res[0]);

    polymul_128x128_rader_16x16(NTT_res[0], NTT_uvqr+192, NTT_uvqr);
    polymul_128x128_rader_16x16(NTT_res[1], NTT_uvqr+224, NTT_uvqr+64);
    for (int i = 0; i < 32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out(out+192, NTT_res[0]);

    polymul_128x128_rader_16x16(NTT_res[0], NTT_uvqr+192, NTT_uvqr+32);
    polymul_128x128_rader_16x16(NTT_res[1], NTT_uvqr+224, NTT_uvqr+96);
    for (int i = 0; i < 32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out(out+288, NTT_res[0]);
}

void matrixmul_128x128_uvqr_NTTx(int16x8_t *out, int16x8_t *NTT_uvqr)
{
    int16x8_t NTT_res[2][32];
    polymul_128x128_rader_16x16(NTT_res[0], NTT_uvqr+128, NTT_uvqr);
    polymul_128x128_rader_16x16(NTT_res[1], NTT_uvqr+160, NTT_uvqr+64);
    for (int i = 0; i < 32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out(out, NTT_res[0]);

    polymul_128x128_rader_16x16(NTT_res[0], NTT_uvqr+128, NTT_uvqr+32);
    polymul_128x128_rader_16x16(NTT_res[1], NTT_uvqr+160, NTT_uvqr+96);
    for (int i = 0; i < 32; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_128x128_rader_out(out+96, NTT_res[0]);
}