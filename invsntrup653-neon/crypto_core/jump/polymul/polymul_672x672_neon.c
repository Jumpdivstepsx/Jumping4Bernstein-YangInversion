#include <arm_neon.h>
#include "polymul_neon.h"
#include "macros_neon.h"
#include <stdio.h>


static inline
void gtReindex_3x224_in(int16x8_t* A, int16x8_t* a){
    int16x8_t mask[3] = {0};
    int16_t m0[8] = {-1, 0, 0, -1, 0, 0, -1, 0};
    int16_t m1[8] = {0, -1, 0, 0, -1, 0, 0, -1};
    int16_t m2[8] = {0, 0, -1, 0, 0, -1, 0, 0};
    mask[0] = vld1q_s16(m0);
    mask[1] = vld1q_s16(m1);
    mask[2] = vld1q_s16(m2);
    for(int i = 0;i<28;i++){
        A[i] = vorrq_s16(vorrq_s16(vandq_s16(a[i], mask[(0+i)%3]), vandq_s16(a[i+28], mask[(1+i)%3])), vandq_s16(a[i+56], mask[(2+i)%3]));
        A[i+28] = vorrq_s16(vorrq_s16(vandq_s16(a[i], mask[(1+i)%3]), vandq_s16(a[i+28], mask[(2+i)%3])), vandq_s16(a[i+56], mask[(0+i)%3]));
        A[i+56] = vorrq_s16(vorrq_s16(vandq_s16(a[i], mask[(2+i)%3]), vandq_s16(a[i+28], mask[(0+i)%3])), vandq_s16(a[i+56], mask[(1+i)%3]));
    }
}

static inline
void gtReindex_3x224_out(int16x8_t* out, int16x8_t* c){
    int16x8_t mask[3] = {0};
    int16_t m0[8] = {-1, 0, 0, -1, 0, 0, -1, 0};
    int16_t m1[8] = {0, -1, 0, 0, -1, 0, 0, -1};
    int16_t m2[8] = {0, 0, -1, 0, 0, -1, 0, 0};
    mask[0] = vld1q_s16(m0);
    mask[1] = vld1q_s16(m1);
    mask[2] = vld1q_s16(m2);
    for(int i = 0;i<28;i++){
        out[i   ] = vorrq_s16(vorrq_s16(vandq_s16(c[i], mask[(0+i)%3]), vandq_s16(c[i+28], mask[(1+i)%3])), vandq_s16(c[i+56], mask[(2+i)%3]));
        out[i+28] = vorrq_s16(vorrq_s16(vandq_s16(c[i], mask[(1+i)%3]), vandq_s16(c[i+28], mask[(2+i)%3])), vandq_s16(c[i+56], mask[(0+i)%3]));
        out[i+56] = vorrq_s16(vorrq_s16(vandq_s16(c[i], mask[(2+i)%3]), vandq_s16(c[i+28], mask[(0+i)%3])), vandq_s16(c[i+56], mask[(1+i)%3]));
    }
}

void polymul_672x672_GoodThomas_in(int16x8_t *NTT_a, int16x8_t *a){
    // 672 = 84*8
    int16x8_t A[84] = {0}, GT_a[84] = {0};
    // reshape 672 -> 3x224
    gtReindex_3x224_in(A, a);
    // good in: y^3-1 ->  (y - 1) * (y - 1763) * (y + 1764)
    for(int i = 0;i<28;i++){
        //a0' <- a0 + a1 + a2 || a1' <- a0 + 1763*a1 - 1764*a2 || a2' <- a0 - 1764*a1 + 1763*a2
        GT_a[i   ] = barrett_fake(vaddq_s16(vaddq_s16(A[i], A[i+28]), A[i+56]));
        GT_a[i+28] = barrett_mla_1763(barrett_mls_1764(A[i], A[i+56]), A[i+28]);
        GT_a[i+56] = barrett_mla_1763(barrett_mls_1764(A[i], A[i+28]), A[i+56]);
    }
    int16x8_t aIn[84];
    //CT-4    
    for(int i = 0;i<3;i++){
        polymul_112x112_ctx2(aIn+i*28, GT_a+i*28);
    }
    
    for (int i=0; i<12; i++){
        polymul_56x56_Toom_InputTransform(NTT_a+(14*i), aIn+(i*7));
    }
}

void polymul_672x672_GoodThomas_mul(int16x8x4_t *NTT_c, int16x8_t *NTT_a, int16x8_t *NTT_b){
    for(int i = 0;i<12;i++){
        polymul_56x56_Toom_Mul(NTT_c+7*i, NTT_a+14*i, NTT_b+14*i);
    }
}

void polymul_672x672_GoodThomas_out(int16x8_t *a, int16x8x4_t* cin){
    int16x8_t NTT_a[168];
    for(int i = 0;i<12;i++)  polymul_56x56_Toom_OutputTransform(NTT_a+14*i, cin+7*i);
    
    int16x8_t d_ct[3][4][7];
    for(int i = 0;i<3;i++){
        for(int j=0;j<7;j++){
            d_ct[i][0][j] = NTT_a[(i*4)*14+j] + NTT_a[(i*4)*14+j+7];
            d_ct[i][1][j] = NTT_a[(i*4+1)*14+j] - NTT_a[(i*4+1)*14+j+7];
            d_ct[i][2][j] = NTT_a[(i*4+2)*14+j] + innerProduct_152(NTT_a[(i*4+2)*14+j+7]);
            d_ct[i][3][j] = NTT_a[(i*4+3)*14+j] - innerProduct_152(NTT_a[(i*4+3)*14+j+7]);
        }
    }

    // gentlemen-sande x2
    int16x8_t  c[3][28];
    for(int i = 0;i<3;i++){
        polymul_112x112_gsx2(c[i], d_ct[i][0]);
    }

    // good out: (y - 1) * (y - 1763) * (y + 1764) -> y^3-1
    int16x8_t C[84];
    for(int i = 0; i <28;i++){
        //c0 <- 3081x(c0'+c1'+c2') || c1 <- 3081 x c0' + 4033 x c1' + 2128 x c2' || c2 <- 3081 x c0' + 2128 x c1' + 4033 x c2
        C[i]    = innerProduct_3081(vaddq_s16(c[0][i], vaddq_s16(c[1][i], c[2][i])));
        C[i+28] = barrett_fake(barrett_mla_2128(barrett_mla_4033(innerProduct_3081(c[0][i]), c[1][i]), c[2][i])); 
        C[i+56] = barrett_fake(barrett_mla_4033(barrett_mla_2128(innerProduct_3081(c[0][i]), c[1][i]), c[2][i])); 
    }
    // reshape 3x224 -> 672
    gtReindex_3x224_out(a, C);
}

void polymul_672x672_GoodThomas(int16x8_t *out, int16x8_t *ain, int16x8_t *bin){
    // 672 = 84*8
    int16x8_t A[84] = {0}, B[84] = {0}, C[84] = {0};    // before-good  
    int16x8_t a[84] = {0}, b[84] = {0}, c[3][32] = {0}; // after-good 
    // reshape 672 -> 3x224
    gtReindex_3x224_in(A, ain);
    gtReindex_3x224_in(B, bin); 

    // good in: y^3-1 ->  (y - 1) * (y - 1763) * (y + 1764)
    for(int i = 0;i<28;i++){
        //a0' <- a0 + a1 + a2 || a1' <- a0 + 1763*a1 - 1764*a2 || a2' <- a0 - 1764*a1 + 1763*a2
        a[i   ] = barrett_fake(vaddq_s16(vaddq_s16(A[i], A[i+28]), A[i+56]));
        a[i+28] = barrett_mla_1763(barrett_mls_1764(A[i], A[i+56]), A[i+28]);
        a[i+56] = barrett_mla_1763(barrett_mls_1764(A[i], A[i+28]), A[i+56]);
        b[i   ] = barrett_fake(vaddq_s16(vaddq_s16(B[i], B[i+28]), B[i+56]));
        b[i+28] = barrett_mla_1763(barrett_mls_1764(B[i], B[i+56]), B[i+28]);
        b[i+56] = barrett_mla_1763(barrett_mls_1764(B[i], B[i+28]), B[i+56]);
    }    

    int16x8_t a_ct[96] = {0}, b_ct[96] = {0}, c_ct[12][16] = {0};
    for(int i = 0;i<3;i++){
        polymul_112x112_ctx2(a_ct+i*32, a+i*28);
        polymul_112x112_ctx2(b_ct+i*32, b+i*28);
    }

    for(int i = 0;i<12;i++){
        polymul_64x64_Toom(c_ct[i], a_ct+i*8, b_ct+i*8);
    }

    int16x8_t d_ct[3][4][7] = {0};
    for(int i = 0;i<3;i++){
        for(int j=0;j<7;j++){
            d_ct[i][0][j] = c_ct[i*4][j] + c_ct[i*4][j+7];
            d_ct[i][1][j] = c_ct[i*4+1][j] - c_ct[i*4+1][j+7];
            d_ct[i][2][j] = c_ct[i*4+2][j] + innerProduct_152(c_ct[i*4+2][j+7]);
            d_ct[i][3][j] = c_ct[i*4+3][j] - innerProduct_152(c_ct[i*4+3][j+7]);
        }

        for(int j = 0;j<2;j++){
            d_ct[i][0][j] = barrett_fake(d_ct[i][0][j] + c_ct[i*4][j+14]);
            d_ct[i][1][j] = barrett_fake(d_ct[i][1][j] + c_ct[i*4+1][j+14]);
            d_ct[i][2][j] = barrett_fake(d_ct[i][2][j] - c_ct[i*4+2][j+14]);
            d_ct[i][3][j] = barrett_fake(d_ct[i][3][j] - c_ct[i*4+3][j+14]);
        }
    }

    // gentlemen-sande x2
    for(int i = 0;i<3;i++){
        polymul_112x112_gsx2(c[i], d_ct[i][0]);
    }
    
    // good out: (y - 1) * (y - 1763) * (y + 1764) -> y^3-1
    for(int i = 0; i <28;i++){
        //c0 <- 3081x(c0'+c1'+c2') || c1 <- 3081 x c0' + 4033 x c1' + 2128 x c2' || c2 <- 3081 x c0' + 2128 x c1' + 4033 x c2
        C[i]    = innerProduct_3081(vaddq_s16(c[0][i], vaddq_s16(c[1][i], c[2][i])));
        C[i+28] = barrett_fake(barrett_mla_2128(barrett_mla_4033(innerProduct_3081(c[0][i]), c[1][i]), c[2][i])); 
        C[i+56] = barrett_fake(barrett_mla_4033(barrett_mla_2128(innerProduct_3081(c[0][i]), c[1][i]), c[2][i])); 
    }
    gtReindex_3x224_out(out, C);
}

void polymul_672_Toom_modring(int16x8_t* NTT_ct, int16x8x4_t* NTT_vr){
    int16x8_t NTT_a[168];
    for(int i = 0;i<12;i++)  polymul_56x56_Toom_OutputTransform(NTT_a+14*i, NTT_vr+7*i);

    int16x8_t d_ct[84];
    for(int i = 0;i<3;i++){
        for(int j=0;j<7;j++){
            d_ct[i*28+j] = NTT_a[(i*4)*14+j] + NTT_a[(i*4)*14+j+7];
            d_ct[i*28+7+j] = NTT_a[(i*4+1)*14+j] - NTT_a[(i*4+1)*14+j+7];
            d_ct[i*28+14+j] = NTT_a[(i*4+2)*14+j] + innerProduct_152(NTT_a[(i*4+2)*14+j+7]);
            d_ct[i*28+21+j] = NTT_a[(i*4+3)*14+j] - innerProduct_152(NTT_a[(i*4+3)*14+j+7]);
        }
    }

    for (int i=0; i<12; i++){
        polymul_56x56_Toom_InputTransform(NTT_ct+(14*i), d_ct+(i*7));
    }
}