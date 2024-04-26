#include "macros_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>

void polymul_32x32_Toom_InputTransform(int16x8_t *c, const int16x8_t *a)
{
    //Input
    int16x8_t odd[2] = {0}, even[2] = {0};
    // 0
    c[0] = a[0];
    // 00
    c[3] = a[3];
    // even/odd: 1, -1, 2, -2
    even[0] = vaddq_s16(a[0], a[2]);
    odd[0] = vaddq_s16(a[1], a[3]);
    even[1] = barrett_mla_4(a[0], a[2]);
    odd[1] = barrett_mla_8(barrett_mla_2(odd[1], a[1]), a[3]);
    // 4
    c[6] = barrett_mla_64(barrett_mla_16(barrett_mla_4(a[0], a[1]), a[2]), a[3]);
    //1, -1
    c[1]  =  barrett_fake(vaddq_s16(even[0], odd[0]));
    c[4]  =  barrett_fake(vsubq_s16(even[0], odd[0])); 
    //2, -2
    c[2]  =  barrett_fake(vaddq_s16(even[1], odd[1]));
    c[5] =  barrett_fake(vsubq_s16(even[1], odd[1]));
}


void polymul_32x32_Toom_Output(int16x8_t *c, int16x8x2_t *h){
    int16x8_t cx[14] = {0};
    for(int i = 0;i<2;i++){
        cx[i] = h[0].val[i];

        cx[2+i] = barrett_mla_3443(cx[2+i], h[0].val[i]);
        cx[2+i] = barrett_mla_511(cx[2+i], h[1].val[i]);
        cx[2+i] = barrett_mla_765(cx[2+i], h[2].val[i]);
        cx[2+i] = barrett_mla_4575(cx[2+i], h[3].val[i]);
        cx[2+i] = barrett_mla_2448(cx[2+i], h[4].val[i]);
        cx[2+i] = barrett_mla_4336(cx[2+i], h[5].val[i]);
        cx[2+i] = barrett_mla_2270(cx[2+i], h[6].val[i]);

        cx[4+i] = barrett_mla_3442(cx[4+i], h[0].val[i]);
        cx[4+i] = barrett_mla_1531(cx[4+i], vaddq_s16(h[1].val[i],  h[4].val[i]));
        cx[4+i] = barrett_mla_1339(cx[4+i], vaddq_s16(h[2].val[i], h[5].val[i]));
        cx[4+i] = barrett_mla_4(cx[4+i], h[3].val[i]);

        cx[6+i] = barrett_mla_1435(cx[6+i], h[0].val[i]);
        cx[6+i] = barrett_mla_2040(cx[6+i], h[1].val[i]);
        cx[6+i] = barrett_mla_861(cx[6+i], h[2].val[i]);
        cx[6+i] = barrett_mla_20(cx[6+i], h[3].val[i]);
        cx[6+i] = barrett_mla_797(cx[6+i], h[5].val[i]);
        cx[6+i] = barrett_mla_4049(cx[6+i], h[6].val[i]);

        cx[8+i] = barrett_mla_1148(cx[8+i], h[0].val[i]);
        cx[8+i] = barrett_mla_765(cx[8+i], vaddq_s16(h[1].val[i], h[4].val[i]));
        cx[8+i] = barrett_mla_3252(cx[8+i], vaddq_s16(h[2].val[i],h[5].val[i]));
        cx[8+i] = barrett_mla_4586(cx[8+i], h[3].val[i]);

        cx[10+i] = barrett_mla_4304(cx[10+i], h[0].val[i]);
        cx[10+i] = barrett_mla_4336(cx[10+i], h[1].val[i]);
        cx[10+i] = barrett_mla_2965(cx[10+i], h[2].val[i]);
        cx[10+i] = barrett_mla_4587(cx[10+i], h[3].val[i]);
        cx[10+i] = barrett_mla_4438(cx[10+i], h[4].val[i]);
        cx[10+i] = barrett_mla_4049(cx[10+i], h[5].val[i]);
        cx[10+i] = barrett_mla_2863(cx[10+i], h[6].val[i]);
        
        cx[12+i] = h[3].val[i];
    }
    
    for (int i = 0; i < 7; i++)
    {
        for (int j = 0; j < 2; j++)
        {
            c[i + j] = barrett_fake(vaddq_s16(c[i + j], cx[(i*2) + j]));
        }
    }
}

void polymul_32x32_karatsuba(int16x8_t *c, const int16x8_t *a, const int16x8_t *b)
{
    int16x8_t tmp1[2] = {0}, tmp2[2] = {0};
    int16x8x4_t c0, c1, c2;

    // up and low term
    c0 = polymul_16x16(a, b);
    c2 = polymul_16x16(a + 2, b + 2);

    // mid term
    for (int i = 0; i < 2; i++)
    {
        tmp1[i] = barrett_fake(vaddq_s16(a[i], a[i + 2]));
        tmp2[i] = barrett_fake(vaddq_s16(b[i], b[i + 2]));
    }

    c1 = polymul_16x16(tmp1, tmp2);
    for (int i = 0; i < 4; i++)
    {
        c1.val[i] = vsubq_s16(c1.val[i], vaddq_s16(c0.val[i], c2.val[i]));
    }
    // merge
    for (int i = 0; i < 2; i++)
    {
        c[i] = barrett_fake(c0.val[i]);
        c[i + 6] = barrett_fake(c2.val[i + 2]);
        // mid
        c[i + 2] = barrett_fake(vaddq_s16(c0.val[i + 2], c1.val[i]));
        c[i + 4] = barrett_fake(vaddq_s16(c1.val[i + 2], c2.val[i]));
    }
}


void polymul_32x32_schoolbook(int16x8_t *c, const int16x8_t *a, const int16x8_t *b)
{
    int16x8x4_t c1[4];
    c1[0] = polymul_16x16(a, b);
    c1[1] = polymul_16x16(a, b+2);
    c1[2] = polymul_16x16(a+2, b);
    c1[3] = polymul_16x16(a+2, b+2);

    for(int i = 0;i<2;i++){
        c[i] = c1[0].val[i];
        c[i+2] = barrett_fake(c1[0].val[i+2] + c1[1].val[i] + c1[2].val[i]);
        c[i+4] = barrett_fake(c1[3].val[i] + c1[1].val[i+2] + c1[2].val[i+2]);
        c[i+6] = c1[3].val[i+2];
    }
}