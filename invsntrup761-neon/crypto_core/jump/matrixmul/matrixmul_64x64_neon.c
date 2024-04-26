#include <arm_neon.h>
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"

// --------------------------------------------------------------
// fg
// --------------------------------------------------------------

void matrixmul_64x64_uvqr_fg_NTT_fgx1(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    int16x8_t NTT_f[16], NTT_g[16], NTT_res[2][16];
    polymul_64x64_rader_in(NTT_f, NTT_g, f, g);

    polymul_64x64_rader_8x8_x1(NTT_res[0], NTT_uvqr, NTT_f);
    polymul_64x64_rader_8x8_x1(NTT_res[1], NTT_uvqr+16, NTT_g);
    for(int i=0; i<16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out_x1(out, NTT_res[0]);

    polymul_64x64_rader_8x8_x1(NTT_res[0], NTT_uvqr+32, NTT_f);
    polymul_64x64_rader_8x8_x1(NTT_res[1], NTT_uvqr+48, NTT_g);
    for(int i=0; i<16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out_x1(out+16, NTT_res[0]);
}

void matrixmul_64x64_uvqr_fg_NTT_fx1(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    int16x8_t NTT_f[16], NTT_g[16], NTT_res[2][16];
    polymul_64x64_rader_in(NTT_f, NTT_g, f, g);

    polymul_64x64_rader_8x8_x1(NTT_res[0], NTT_uvqr, NTT_f);
    polymul_64x64_rader_8x8_x1(NTT_res[1], NTT_uvqr+16, NTT_g);
    for(int i=0; i<16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out_x1(out, NTT_res[0]);

    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+32, NTT_f);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+48, NTT_g);
    for(int i=0; i<16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out+16, NTT_res[0]);
}

void matrixmul_64x64_uvqr_fg_NTT(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    int16x8_t NTT_f[16], NTT_g[16], NTT_res[2][16];
    polymul_64x64_rader_in(NTT_f, NTT_g, f, g);

    int16x8_t ff[16] = {0};
    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr, NTT_f);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+16, NTT_g);
    for(int i=0; i<16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out, NTT_res[0]);

    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+32, NTT_f);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+48, NTT_g);
    for(int i=0; i<16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out+16, NTT_res[0]);
}

void matrixmul_64x64_uvqr_fg_NTT_fgx2(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g)
{
    int16x8_t NTT_f[16], NTT_g[16], NTT_res[2][16];
    polymul_64x64_rader_in(NTT_f, NTT_g, f, g);

    polymul_64x64_rader_8x8_x2(NTT_res[0], NTT_uvqr, NTT_f);
    polymul_64x64_rader_8x8_x2(NTT_res[1], NTT_uvqr+16, NTT_g);
    for(int i=0; i<16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out_x2(out, NTT_res[0]);

    polymul_64x64_rader_8x8_x2(NTT_res[0], NTT_uvqr+32, NTT_f);
    polymul_64x64_rader_8x8_x2(NTT_res[1], NTT_uvqr+48, NTT_g);
    for(int i=0; i<16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out_x2(out+16, NTT_res[0]);
}


// --------------------------------------------------------------
// uvqr
// --------------------------------------------------------------

// jump124
void matrixmul_64x64_uvqr_NTT(int16x8_t *out, int16x8_t *NTT_uvqr)
{
    int16x8_t NTT_res[2][16];
    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+64, NTT_uvqr);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+80, NTT_uvqr+32);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out, NTT_res[0]);
    
    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+64, NTT_uvqr+16);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+80, NTT_uvqr+48);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out+16, NTT_res[0]);

    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+96, NTT_uvqr);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+112, NTT_uvqr+32);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out+32, NTT_res[0]);

    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+96, NTT_uvqr+16);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+112, NTT_uvqr+48);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out+48, NTT_res[0]);
}

void matrixmul_64x64_uvqr_NTTx(int16x8_t *out, int16x8_t *NTT_uvqr)
{
    int16x8_t NTT_res[2][16];
    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+64, NTT_uvqr);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+80, NTT_uvqr+32);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out, NTT_res[0]);
    
    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+64, NTT_uvqr+16);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+80, NTT_uvqr+48);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out+16, NTT_res[0]);    
}


// jump127
void matrixmul_64x64_uvqr_NTT_uvx1(int16x8_t *out, int16x8_t *NTT_uvqr)
{
    int16x8_t NTT_res[2][16];    
    polymul_64x64_rader_8x8_x1(NTT_res[0], NTT_uvqr+64, NTT_uvqr);
    polymul_64x64_rader_8x8_x1(NTT_res[1], NTT_uvqr+80, NTT_uvqr+32);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out_x1(out, NTT_res[0]);
    
    polymul_64x64_rader_8x8_x1(NTT_res[0], NTT_uvqr+64, NTT_uvqr+16);
    polymul_64x64_rader_8x8_x1(NTT_res[1], NTT_uvqr+80, NTT_uvqr+48);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out_x1(out+16, NTT_res[0]);
    
    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+96, NTT_uvqr);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+112, NTT_uvqr+32);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out+32, NTT_res[0]);

    polymul_64x64_rader_8x8(NTT_res[0], NTT_uvqr+96, NTT_uvqr+16);
    polymul_64x64_rader_8x8(NTT_res[1], NTT_uvqr+112, NTT_uvqr+48);
    for (int i = 0; i < 16; i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_64x64_rader_out(out+48, NTT_res[0]);
}