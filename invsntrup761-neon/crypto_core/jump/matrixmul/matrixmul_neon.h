#ifndef _MATREIXMUL_NEON_H_
#define _MATREIXMUL_NEON_H_

#include <arm_neon.h>

//16x16 = 32
void matrixmul_16x16_uvqr_fg(int16x8_t *out, int16x8_t *uvqr, int16x8_t *f, int16x8_t *g);


//64x64 = 128
void matrixmul_64x64_uvqr_fg_NTT(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_64x64_uvqr_fg_NTT_fgx1(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_64x64_uvqr_fg_NTT_fgx2(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_64x64_uvqr_fg_NTT_fx1(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_64x64_uvqr_NTT(int16x8_t *out, int16x8_t *NTT_uvqr);
void matrixmul_64x64_uvqr_NTTx(int16x8_t *out, int16x8_t *NTT_uvqr);
void matrixmul_64x64_uvqr_NTT_uvx1(int16x8_t *out, int16x8_t *NTT_uvqr);

//128x128 = 256
void matrixmul_128x128_uvqr_fg_NTT(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_128x128_uvqr_fg_NTT_fgx1(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_128x128_uvqr_fg_NTT_fgx4(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_128x128_uvqr_NTT(int16x8_t *out, int16x8_t *NTT_uvqr);
void matrixmul_128x128_uvqr_NTTx(int16x8_t *out, int16x8_t *NTT_uvqr);

//768x768 = 768
void matrixmul_768x768_uvqr_fg64_NTT_fgx2(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_768x768_uvqr_NTT_vr(int16x8_t* out, int16x8_t *NTT_uvqr, int16x8_t *b, int16x8_t *d);
void matrixmul_768x768_uvqr_NTT_uv(int16x8_t *out, int16x8_t *uv, int16x8_t *abcd);
void matrixmul_768x768_uvqr_NTT(int16x8_t *out, int16x8_t *NTT_uvqr);
#endif