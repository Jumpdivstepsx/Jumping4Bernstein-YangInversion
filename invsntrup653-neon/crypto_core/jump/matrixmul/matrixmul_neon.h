#ifndef _MATREIXMUL_NEON_H_
#define _MATREIXMUL_NEON_H_

#include <arm_neon.h>

//672x672 = 672
void matrixmul_672x672_uvqr_fg_NTT_fgx4(int16x8_t *out, int16x8_t *NTT_uvqr, int16x8_t *f, int16x8_t *g);
void matrixmul_672x672_uvqr_NTT_vr(int16x8x4_t* out, int16x8_t *NTT_uvqr, int16x8_t *b, int16x8_t *d);
void matrixmul_672x672_uvqr_NTT_uv(int16x8x4_t* out, int16x8_t *NTT_uv, int16x8_t *NTT_uvqr);
#endif