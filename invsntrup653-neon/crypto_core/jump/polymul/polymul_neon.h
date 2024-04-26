#ifndef _POLYMUL_NEON_H_
#define _POLYMUL_NEON_H_

#include <arm_neon.h>
#include <macros_neon.h>
#include <string.h>

extern void __asm_8x32x32 (int16x8_t* c, int16x8_t* a, int16x8_t* b, int16x8_t (*mc)[16], int16x8_t (*mab)[8]);

#define polymul_8x8 polymul_8x8_schoolbook_32_neon
#define polymul_16x16 polymul_16x16_karatsuba


//8x8 = 16
static inline int16x8x2_t polymul_8x8_schoolbook_32_neon(const int16x8_t a, const int16x8_t b)
{   
    // faster in cortex-a72
    int16x4x2_t *ssa = (int16x4x2_t *) &a;
    int16x4x2_t *ssb = (int16x4x2_t *) &b;

    int16x4_t a0 = ssa->val[0];
    int16x4_t a1 = ssa->val[1];
    int16x4_t b0 = ssb->val[0];
    int16x4_t b1 = ssb->val[1];
    
    //Low part
    int32x4_t c0_0 = vmull_lane_s16(a0, b0, 0);
    int32x4_t c0_1 = vmull_lane_s16(a0, b0, 1);
    int32x4_t c0_2 = vmull_lane_s16(a0, b0, 2);
    int32x4_t c0_3 = vmull_lane_s16(a0, b0, 3);
    
    //Mid part
    int32x4_t c1_0 = vmull_lane_s16(a1, b0, 0);
    int32x4_t c1_1 = vmull_lane_s16(a1, b0, 1);
    int32x4_t c1_2 = vmull_lane_s16(a1, b0, 2);
    int32x4_t c1_3 = vmull_lane_s16(a1, b0, 3);
    
    c1_0 = vmlal_lane_s16(c1_0, a0, b1, 0);
    c1_1 = vmlal_lane_s16(c1_1, a0, b1, 1);
    c1_2 = vmlal_lane_s16(c1_2, a0, b1, 2);
    c1_3 = vmlal_lane_s16(c1_3, a0, b1, 3);
    
    //High part
    int32x4_t c2_0 = vmull_lane_s16(a1, b1, 0);
    int32x4_t c2_1 = vmull_lane_s16(a1, b1, 1);
    int32x4_t c2_2 = vmull_lane_s16(a1, b1, 2);
    int32x4_t c2_3 = vmull_lane_s16(a1, b1, 3);

    int32x4_t c0 = c0_0;
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_1, 3));
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_2, 2));
    c0 = vaddq_s32(c0, vextq_s32(v0_32x4, c0_3, 1));

    int32x4_t c1 = c1_0;
    c1 = vaddq_s32(c1, vextq_s32(c0_1, c1_1, 3));
    c1 = vaddq_s32(c1, vextq_s32(c0_2, c1_2, 2));
    c1 = vaddq_s32(c1, vextq_s32(c0_3, c1_3, 1));

    int32x4_t c2 = c2_0;
    c2 = vaddq_s32(c2, vextq_s32(c1_1, c2_1, 3));
    c2 = vaddq_s32(c2, vextq_s32(c1_2, c2_2, 2));
    c2 = vaddq_s32(c2, vextq_s32(c1_3, c2_3, 1));

    int32x4_t c3 = vextq_s32(c2_1, v0_32x4, 3);
    c3 = vaddq_s32(c3, vextq_s32(c2_2, v0_32x4, 2));
    c3 = vaddq_s32(c3, vextq_s32(c2_3, v0_32x4, 1));

    int16x8x2_t c;
    c.val[0] = barrett_fake_32x4(c0, c1);
    c.val[1] = barrett_fake_32x4(c2, c3);
    return c;
}

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

static inline void convert16x16(int16x8_t *out, int16x8_t *uvqr, int16x8_t *f){
    int16x8x4_t tmp = polymul_16x16(uvqr, f);
    for(int i = 0;i<4;i++){
        out[i] = tmp.val[i];
    }
}

//56x56
static inline
void polymul_56x56_Toom_InputTransform(int16x8_t *c, int16x8_t *a)
{
    //Input
    int16x8_t odd[4] = {0}, even[4];
    for (int i = 0; i < 2; i++){
        c[i] = a[i];
        even[i] = vaddq_s16(a[i], a[i+4]);
        even[i+2] = barrett_mla_4(a[i], a[i+4]);      
    }
    c[6] = a[6];
    c[7] = v0_16;
    odd[0] = vaddq_s16(a[2], a[6]);
    odd[1] = a[3];
    odd[2] = barrett_mla_8(barrett_mla_2(odd[2], a[2]), a[6]);
    odd[3] = barrett_mla_2(odd[3], a[3]);
    c[12] = barrett_mla_64(barrett_mla_16(barrett_mla_4(a[0], a[2]), a[4]), a[6]);
    c[13] = barrett_mla_16(barrett_mla_4(a[1], a[3]), a[5]);

    for (int i=0; i<2; i++){
        //1, -1
        c[i+2]  =  barrett_fake(vaddq_s16(even[i], odd[i]));
        c[i+8]  =  barrett_fake(vsubq_s16(even[i], odd[i])); 
        //2, -2
        c[i+4]  =  barrett_fake(vaddq_s16(even[i+2], odd[i+2]));
        c[i+10] =  barrett_fake(vsubq_s16(even[i+2], odd[i+2]));
    }
}

static inline
void polymul_56x56_Toom_Mul(int16x8x4_t *c, int16x8_t *a, int16x8_t *b)
{
    for(int i = 0;i<7;i++)
    {
        c[i] = polymul_16x16(a+(i*2), b+(i*2));
    }
}

static inline
void polymul_56x56_Toom_OutputTransform(int16x8_t *c, int16x8x4_t *h)
{
    int16x8_t cx[28] = {0};
    for(int i = 0;i<4;i++){
        cx[i] = h[0].val[i];

        cx[4+i] = barrett_mla_1155(cx[4+i], h[0].val[i]);
        cx[4+i] = barrett_mla_3595(cx[4+i], h[1].val[i]);
        cx[4+i] = barrett_mla_770(cx[4+i], h[2].val[i]);
        cx[4+i] = barrett_mla_4605(cx[4+i], h[3].val[i]);
        cx[4+i] = barrett_mla_2464(cx[4+i], h[4].val[i]);
        cx[4+i] = barrett_mla_2824(cx[4+i], h[5].val[i]);
        cx[4+i] = barrett_mla_3055(cx[4+i], h[6].val[i]);

        cx[8+i] = barrett_mla_1154(cx[8+i], h[0].val[i]);
        cx[8+i] = barrett_mla_1541(cx[8+i], vaddq_s16(h[1].val[i],  h[4].val[i]));
        cx[8+i] = barrett_mla_2503(cx[8+i], vaddq_s16(h[2].val[i], h[5].val[i]));
        cx[8+i] = barrett_mla_4(cx[8+i], h[3].val[i]);

        cx[12+i] = barrett_mla_2022(cx[12+i], h[0].val[i]);
        cx[12+i] = barrett_mla_513(cx[12+i], h[1].val[i]);
        cx[12+i] = barrett_mla_289(cx[12+i], h[2].val[i]);
        cx[12+i] = barrett_mla_20(cx[12+i], h[3].val[i]);
        cx[12+i] = barrett_mla_2150(cx[12+i], h[5].val[i]);
        cx[12+i] = barrett_mla_4268(cx[12+i], h[6].val[i]);

        cx[16+i] = barrett_mla_3466(cx[16+i], h[0].val[i]);
        cx[16+i] = barrett_mla_770(cx[16+i], vaddq_s16(h[1].val[i], h[4].val[i]));
        cx[16+i] = barrett_mla_2118(cx[16+i], vaddq_s16(h[2].val[i],h[5].val[i]));
        cx[16+i] = barrett_mla_4616(cx[16+i], h[3].val[i]);

        cx[20+i] = barrett_mla_1444(cx[20+i], h[0].val[i]);
        cx[20+i] = barrett_mla_2824(cx[20+i], h[1].val[i]);
        cx[20+i] = barrett_mla_3562(cx[20+i], h[2].val[i]);
        cx[20+i] = barrett_mla_4617(cx[20+i], h[3].val[i]);
        cx[20+i] = barrett_mla_4467(cx[20+i], h[4].val[i]);
        cx[20+i] = barrett_mla_4268(cx[20+i], h[5].val[i]);
        cx[20+i] = barrett_mla_1919(cx[20+i], h[6].val[i]);
        cx[24+i] = h[3].val[i];
    }
    
    int16x8_t res[14] = {0};
    
    for (int i = 0; i < 6; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            res[(i * 2) + j] = barrett_fake(vaddq_s16(res[(i * 2) + j], cx[(i * 4) + j]));
        }
    }
    res[12] = barrett_fake(vaddq_s16(res[12], cx[24]));
    res[13] = barrett_fake(vaddq_s16(res[13], cx[25]));

    memcpy(c, res, 112*sizeof(int16_t));
}
void polymul_56x56_Toom(int16x8_t *c, int16x8_t *a, int16x8_t *b);

//64x64
static inline void polymul_64x64_Toom_InputTransform(int16x8_t *c, int16x8_t *a);
static inline void polymul_64x64_Toom_OutputTransform(int16x8_t *c, int16x8_t *a, int16x8_t *b);
void polymul_64x64_Toom(int16x8_t *c, int16x8_t *a, int16x8_t *b);

//112x112
void polymul_112x112_Toom_InputTransform(int16x8_t *c, int16x8_t *a);
void polymul_112x112_Toom_mul(int16x8_t *c, int16x8_t *a, int16x8_t *b);
void polymul_112x112_Toom_OutputTransform(int16x8_t *c, int16x8_t *a);
void polymul_112x112_Toom(int16x8_t *c, int16x8_t *a, int16x8_t *b);


//NTT224
void polymul_112x112_ctx2(int16x8_t* out, int16x8_t*  in);
void polymul_112x112_gsx2(int16x8_t* out, int16x8_t*  in);
void polymul_112x112_ct_t4(int16x8_t* c, int16x8_t*  a, int16x8_t* b);
void polymul_112x112_ctx2_112(int16x8_t* out, int16x8_t*  in);

//NTT672
static inline void gtReindex_3x224_in(int16x8_t* A, int16x8_t* a);
static inline void gtReindex_3x224_out(int16x8_t* out, int16x8_t* c);
void polymul_672x672_GoodThomas_in(int16x8_t* NTT_a, int16x8_t* a);
void polymul_672x672_GoodThomas_mul(int16x8x4_t *NTT_c, int16x8_t *NTT_a, int16x8_t *NTT_b);
void polymul_672x672_GoodThomas_out(int16x8_t *a, int16x8x4_t *NTT_a);
void polymul_672x672_GoodThomas(int16x8_t *out, int16x8_t *ain, int16x8_t *bin);
void polymul_672_Toom_modring(int16x8_t* NTT_ct, int16x8x4_t* NTT_vr);

#endif