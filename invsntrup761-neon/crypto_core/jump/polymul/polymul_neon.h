#ifndef _POLYMUL_NEON_H_
#define _POLYMUL_NEON_H_

#include <arm_neon.h>
#include "macros_neon.h"

extern void __asm_4x32x32(int16x8_t* c, int16x8_t* uvqr, int16x8_t* f, int16x8_t* g, int16x8_t (*mc)[8]);
extern void __asm_4x32x32_x1(int16x8_t* c, int16x8_t* uvqr, int16x8_t* f, int16x8_t* g, int16x8_t (*mc)[8]);
extern void __asm_4x32x32_fx1(int16x8_t* c, int16x8_t* uvqr, int16x8_t* f, int16x8_t* g, int16x8_t (*mc)[8]);
extern void __asm_4x32x32_uvqr(int16x8_t* c, int16x8_t* uvqr, int16x8_t* f, int16x8_t* g, int16x8_t (*mc)[8]);
extern void __asm_4x32x32_uvqr_x(int16x8_t* c, int16x8_t* uvqr, int16x8_t* f, int16x8_t* g, int16x8_t (*mc)[8]);
extern void __asm8_16x16(int16x8_t *c, int16x8_t *a, int16x8_t *b, int16x8_t *tmp);
extern void __transpose8_8x8(int16x8_t* a);
extern void __rader8x8p(int16x8_t* c, int16x8_t* a, int16x8_t* b);
extern void __rader8x8n(int16x8_t* c, int16x8_t* a, int16x8_t* b);
extern void __rader8x8p_x1(int16x8_t* c, int16x8_t* a, int16x8_t* b);
extern void __rader8x8n_x1(int16x8_t* c, int16x8_t* a, int16x8_t* b);
extern void __rader8x8p_x2(int16x8_t* c, int16x8_t* a, int16x8_t* b);
extern void __rader8x8n_x2(int16x8_t* c, int16x8_t* a, int16x8_t* b);
extern void __rader8x8p_x4(int16x8_t* c, int16x8_t* a, int16x8_t* b);
extern void __rader8x8n_x4(int16x8_t* c, int16x8_t* a, int16x8_t* b);
extern void __truncated_rader17_64(int16x8_t* c, int16x8_t* a, int16x8_t* bp, int16x8_t* bn, int16x8_t* twist);
extern void __itruncated_rader_17_64(int16x8_t* c, int16x8_t* a, int16x8_t* bp, int16x8_t* bn, int16x8_t* twist);
extern void __truncated_rader17_128(int16x8_t* c, int16x8_t* a, int16x8_t* bp, int16x8_t* bn, int16x8_t* twist);
extern void __itruncated_rader_17_128(int16x8_t* c, int16x8_t* a, int16x8_t* bp, int16x8_t* bn, int16x8_t* twist);
extern void __truncated_rader17_768(int16x8_t* c, int16x8_t* a, int16x8_t* bp, int16x8_t* bn, int16x8_t* twist);
extern void __itruncated_rader_17_768(int16x8_t* c, int16x8_t* a, int16x8_t* bp, int16x8_t* bn, int16x8_t* twist);

#define polymul_8x8 polymul_8x8_ext
#define polymul_16x16 polymul_16x16_karatsuba
#define polymul_32x32 polymul_32x32_karatsuba
#define polymul_64x64 polymul_64x64_truncated_rader17

extern void __asm8_16x16(int16x8_t *c, int16x8_t *a, int16x8_t *b, int16x8_t *tmp);
extern void __asm_8x32x32 (int16x8_t* c, int16x8_t* a, int16x8_t* b, int16x8_t (*mc)[16], int16x8_t (*mab)[8]);

//8x8 = 16
int16x8x2_t polymul_8x8_ext(const int16x8_t a, const int16x8_t b);
int16x8x2_t polymul_8x8_karatsuba(int16x8_t a, int16x8_t b);

//16x16 = 32
static inline int16x8x4_t polymul_16x16_karatsuba(const int16x8_t *a, const int16x8_t *b)
{
    int16x8x2_t c0, c1, c2;
    int16x8x4_t c;

    // up and low term
    c0 = polymul_8x8(a[0], b[0]);
    c2 = polymul_8x8(a[1], b[1]);

    // mid term
    c1 = polymul_8x8(vaddq_s16(a[0], a[1]), vaddq_s16(b[0], b[1]));
    c1.val[0] = vsubq_s16(c1.val[0], vaddq_s16(c0.val[0], c2.val[0]));
    c1.val[1] = vsubq_s16(c1.val[1], vaddq_s16(c0.val[1], c2.val[1]));

    // merge
    c.val[0] = c0.val[0];
    c.val[1] = barrett_fake(vaddq_s16(c0.val[1], c1.val[0]));
    c.val[2] = barrett_fake(vaddq_s16(c2.val[0], c1.val[1]));
    c.val[3] = c2.val[1];
    return c;
}

static inline int16x8x4_t polymul_16x16_schoolbook(const int16x8_t *a, const int16x8_t *b){
    int16x8x2_t c[4];
    int16x8x4_t res;
    c[0] = polymul_8x8(a[0], b[0]);
    c[1] = polymul_8x8(a[0], b[1]);
    c[2] = polymul_8x8(a[1], b[0]);
    c[3] = polymul_8x8(a[1], b[1]);
    res.val[0] = c[0].val[0];
    res.val[1] = barrett_fake(c[0].val[1] + c[1].val[0] + c[2].val[0]);
    res.val[2] = barrett_fake(c[3].val[0] + c[1].val[1] + c[2].val[1]);
    res.val[3] = c[3].val[1];
    return res;
}

static inline void convert16x16(int16x8_t *out, int16x8_t *uvqr, int16x8_t *f){
    int16x8x4_t tmp = polymul_16x16(uvqr, f);
    for(int i = 0;i<4;i++){
        out[i] = tmp.val[i];
    }
}

int16x8x2_t polymul_8x8_mont(int16x8_t a, int16x8_t b);

//32x32 = 64
void polymul_32x32_karatsuba(int16x8_t *c, const int16x8_t *a, const int16x8_t *b);
void polymul_32x32_schoolbook(int16x8_t *c, const int16x8_t *a, const int16x8_t *b);
void polymul_32x32_Toom_InputTransform(int16x8_t *c, const int16x8_t *a);
void polymul_32x32_Toom_Output(int16x8_t *c, int16x8x2_t *h);

//64x64 = 128
void polymul_64x64_schoolbook(int16x8_t *c, const int16x8_t *a, const int16x8_t *b);

void polymul_64x64_rader_in(int16x8_t* a_out, int16x8_t* b_out, int16x8_t* a, int16x8_t* b);
void polymul_64x64_rader_8x8(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void polymul_64x64_rader_8x8_x1(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void polymul_64x64_rader_8x8_x2(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void polymul_64x64_rader_out(int16x8_t* c, int16x8_t* c_in);
void polymul_64x64_rader_out_x1(int16x8_t* c, int16x8_t* c_in);
void polymul_64x64_rader_out_x2(int16x8_t* c, int16x8_t* c_in);
void polymul_64x64_truncated_rader17(int16x8_t *c, int16x8_t *a, int16x8_t *b);

void polymul_64x64_Schonhage(int16x8_t *c, const int16x8_t *a, const int16x8_t *b);
void permutation_64(int16x8_t* out, const int16x8_t* in);
void SchonhageIn_64(int16x8_t* out, int16x8_t* in);
void SchonhageMul_64(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void SchonhageOut_64(int16x8_t* out, int16x8_t* in);

void polymul_64x64_Toom_InputTransform(int16x8_t *c, const int16x8_t *a);
void polymul_64x64_Toom_Output(int16x8_t *c, int16x8x4_t *h);

void polymul_64x64_karatsuba(int16x8_t *c, const int16x8_t *a, const int16x8_t *b);

//128x128 = 256
void polymul_128x128_rader_in(int16x8_t* a_out, int16x8_t* b_out, int16x8_t* a, int16x8_t* b);
void polymul_128x128_rader_16x16(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void polymul_128x128_rader_16x16_x1(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void polymul_128x128_rader_16x16_x4(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void polymul_128x128_rader_out(int16x8_t* c, int16x8_t* c_in);
void polymul_128x128_rader_out_x1(int16x8_t* c, int16x8_t* c_in);
void polymul_128x128_rader_out_x4(int16x8_t* c, int16x8_t* c_in);

void permutation_128(int16x8_t* out, const int16x8_t* in);
void SchonhageIn_128(int16x8_t* out, int16x8_t* in);
void SchonhageMul_128(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void SchonhageOut_128(int16x8_t* out, int16x8_t* in);

void polymul_128x128_Toom_Out(int16x8_t *c, int16x8_t *h);
void polymul_128x128_Toom_InputTransform(int16x8_t *c, int16x8_t *a);

void polymul_128x128_schoolbook(int16x8_t *c, int16x8_t *a, int16x8_t *b);
void polymul_128x128_karatsuba(int16x8_t *c, int16x8_t *a, int16x8_t *b);

void Brunn_128_In(int16x8_t *out, int16x8_t *in);
void Brunn_128_modRing(int16x8_t *out, int16x8_t *in);
void Brunn_128_Out(int16x8_t *out, int16x8_t *in);
void Brunn_128_stage256(int16x8_t *out, int16x8_t *in);
void Brunn_128_stage128(int16x8_t *out, int16x8_t *in);
void Brunn_128_stage64(int16x8_t *out, int16x8_t *in);
void Brunn_128_stage32(int16x8_t *out, int16x8_t *in);
void iBrunn_128_stage256(int16x8_t *out, int16x8_t *in);
void iBrunn_128_stage128(int16x8_t *out, int16x8_t *in);
void iBrunn_128_stage64(int16x8_t *out, int16x8_t *in);
void iBrunn_128_stage32(int16x8_t *out, int16x8_t *in);

//768x768 = 768
void polymul_768x768_rader_in(int16x8_t* NTT_a, int16x8_t* NTT_b, int16x8_t* a, int16x8_t* b);
void polymul_768x768_rader_16x16(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void polymul_768x768_rader_out(int16x8_t* c, int16x8_t* c_in);
void polymul_768x768_rader_16x16_x2(int16x8_t* c, int16x8_t* a, int16x8_t* b);
void polymul_768x768_rader_out_x2(int16x8_t* c, int16x8_t* c_in);

#endif