#include <arm_neon.h>
#include "polymul_neon.h"
#include "macros_neon.h"
#include <string.h>

static inline
void polymul_64x64_Toom_InputTransform(int16x8_t *c, int16x8_t *a)
{
    //Input
    int16x8_t odd[4] = {0}, even[4];
    for (int i = 0; i < 2; i++)
    {
        // 0
        c[i] = a[i];
        // 00
        c[i+6] = a[i+6];
        // even/odd: 1, -1, 2, -2
        even[i] = vaddq_s16(a[i], a[i+4]);
        odd[i] = vaddq_s16(a[i+2], a[i+6]);
        even[i+2] = barrett_mla_4(a[i], a[i+4]);
        odd[i+2] = barrett_mla_8(barrett_mla_2(odd[i+2], a[i+2]), a[i+6]);      
        // 4
        c[i+12] = barrett_mla_64(barrett_mla_16(barrett_mla_4(a[i], a[i+2]), a[i+4]), a[i+6]);
    }

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
void polymul_64x64_Toom_OutputTransform(int16x8_t *c, int16x8_t *a, int16x8_t *b)
{
    
    int16x8x4_t h[7];
    for(int i = 0;i<7;i++)
    {
        h[i] = polymul_16x16(a+(i*2), b+(i*2));
    }
    
    //Inverse matrix
    /*  [[1, 0, 0, 0, 0, 0, 0],
        [1155, 3595, 770, 4605, 2464, 2824, 3055],
        [1154, 1541, 2503, 4, 1541, 2503, 0],
        [2022, 513, 289, 20, 0, 2150, 4268],
        [3466, 770, 2118, 4616, 770, 2118, 0],
        [1444, 2824, 3562, 4617, 4467, 4268, 1919],
        [0, 0, 0, 1, 0, 0, 0]]
    */
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
    

    int16x8_t res[16] = {0};
    for (int i = 0; i < 7; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            res[(i * 2) + j] = barrett_fake(vaddq_s16(res[(i * 2) + j], cx[(i * 4) + j]));
        }
    }

    memcpy(c, res, 128*sizeof(int16_t));
}

void polymul_64x64_Toom(int16x8_t *c, int16x8_t *a, int16x8_t *b)
{
    int16x8_t aIn[14] = {0},  bIn[14] = {0};
    polymul_64x64_Toom_InputTransform(aIn, a);
    polymul_64x64_Toom_InputTransform(bIn, b);
    polymul_64x64_Toom_OutputTransform(c, aIn, bIn);
}