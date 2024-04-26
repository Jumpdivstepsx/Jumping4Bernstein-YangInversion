#include <arm_neon.h>
#include "polymul_neon.h"
#include "macros_neon.h"
#include <stdio.h>
#include <string.h>

//ax + b =  (a+b) / (a-b)

void polymul_112x112_ctx2(int16x8_t* out, int16x8_t*  in){
    int16x8_t c[2][14];
    // x^4 -1 -> (x^2 -1) * (x^2 +1)
    for (int i = 0;i<14;i++){
        c[0][i] = (in[i] + in[i+14]);
        c[1][i] = (in[i] - in[i+14]);
    }
    
    //(x^2 -1)-> (x - 1) * (x + 1)
    //(x^2 +1)-> (x - 152) * (x + 152)
    int16x8_t tmp;
    for (int i = 0;i<7;i++){
        out[i]    = barrett_fake(c[0][i] + c[0][i+7]);
        out[i+7]  = barrett_fake(c[0][i] - c[0][i+7]);
        tmp = innerProduct_152(c[1][i+7]);
        out[i+14] = barrett_fake(c[1][i] + tmp);
        out[i+21] = barrett_fake(c[1][i] - tmp);
    }  
}

void polymul_112x112_ctx2_112(int16x8_t* out, int16x8_t*  in){
    int16x8_t tmp;
    for (int i = 0;i<7;i++){
        out[i]    = barrett_fake(in[i] + in[i+7]);
        out[i+8]  = barrett_fake(in[i] - in[i+7]);
        tmp = innerProduct_152(in[i+7]);
        out[i+16] = barrett_fake(in[i] + tmp);
        out[i+24] = barrett_fake(in[i] - tmp);
    }     
}

void polymul_112x112_gsx2(int16x8_t* out, int16x8_t*  in){
    //(x - 1)   * (x + 1)   -> (x^2 - 1)
    //(x - 152) * (x + 152) -> (x^2 + 1)
    int16x8_t c1[2][14] = {0};
    for (int i = 0;i<7;i++){
        c1[0][i]   = innerProduct_3466(in[i] + in[i+7]);
        c1[0][i+7] = innerProduct_3466(in[i] - in[i+7]);        
        c1[1][i]   = innerProduct_3466(in[i+14] + in[i+21]); 
        c1[1][i+7] = innerProduct_38(in[i+21] - in[i+14]);
    }

    for (int i = 0;i<14;i++){
        out[i]    = barrett_fake(c1[0][i] + c1[1][i]);
        out[i+14] = barrett_fake(c1[0][i] - c1[1][i]);
    }
}


void polymul_112x112_ct_t4(int16x8_t* c, int16x8_t*  a, int16x8_t* b){
    int16x8_t aIn[32] = {0}, bIn[32] = {0}, cIn[4][16] = {0}, dIn[4][7] = {0};

    polymul_112x112_ctx2_112(aIn, a);
    polymul_112x112_ctx2_112(bIn, b);

    for(int i = 0;i<4;i++){
        polymul_64x64_Toom(cIn[i], aIn+8*i, bIn+8*i);
    }

    // mod
    for(int i = 0;i<7;i++){
        dIn[0][i] = (cIn[0][i] + cIn[0][i+7]);
        dIn[1][i] = (cIn[1][i] - cIn[1][i+7]);
        dIn[2][i] = (cIn[2][i] + innerProduct_152(cIn[2][i+7]));  
        dIn[3][i] = (cIn[3][i] - innerProduct_152(cIn[3][i+7]));
    }
    dIn[0][0] = barrett_fake(dIn[0][0] + cIn[0][14]);
    dIn[1][0] = barrett_fake(dIn[1][0] + cIn[1][14]);
    dIn[2][0] = barrett_fake(dIn[2][0] - cIn[2][14]);
    dIn[3][0] = barrett_fake(dIn[3][0] - cIn[3][14]);
    dIn[0][1] = barrett_fake(dIn[0][1] + cIn[0][15]);
    dIn[1][1] = barrett_fake(dIn[1][1] + cIn[1][15]);
    dIn[2][1] = barrett_fake(dIn[2][1] - cIn[2][15]);
    dIn[3][1] = barrett_fake(dIn[3][1] - cIn[3][15]);
    
    polymul_112x112_gsx2(c, dIn[0]);
}

void polymul_112x112_Toom_InputTransform(int16x8_t *c, int16x8_t *a)
{
    //Input
    int16x8_t odd[14] = {0}, even[14] = {0};
    for (int i = 0; i < 4; i++)
    {
        c[i] = barrett_fake(a[i]);
        even[i] = (vaddq_s16(a[i], a[8+i]));
        even[i+4] = (barrett_mla_4(a[i], a[8+i]));
    }
    for (int i=0; i<2; i++){
        c[i+12] = barrett_fake(a[i+12]);
        c[14] = c[15] = v0_16;
        odd[i] = (vaddq_s16(a[4+i], a[12+i]));
        odd[i+2] = (a[6+i]);
        odd[i+4] = barrett_fake(barrett_mla_8(barrett_mla_2(odd[i+4], a[4+i]), a[12+i]));
        odd[i+6] = (barrett_mla_2(odd[i+6], a[6+i]));
        c[i+24] = barrett_fake(barrett_mla_64(barrett_mla_16(barrett_mla_4(a[i], a[4+i]), (a[8+i])), (a[12+i])));
        c[i+26] = barrett_fake(barrett_mla_16(barrett_mla_4(a[i+2], a[6+i]), (a[10+i])));
    }

    for (int i=0; i<4; i++){
        //1, -1
        c[i+4] =  barrett_fake(vaddq_s16(even[i], odd[i]));
        c[i+16] = barrett_fake(vsubq_s16(even[i], odd[i])); 
        //2, -2
        c[i+8] =  barrett_fake(vaddq_s16(even[i+4], odd[i+4]));
        c[i+20] =  barrett_fake(vsubq_s16(even[i+4], odd[i+4]));
    }
}

void polymul_112x112_Toom_mul(int16x8_t *c, int16x8_t *a, int16x8_t *b){
    int16x8_t h[64] = {0};
    int16x8_t mab[8][8], mc[9][16];
    __asm_8x32x32(h, a, b, mc, mab);

    memcpy(c, h, 512*sizeof(int16_t));
}

void polymul_112x112_Toom_OutputTransform(int16x8_t *c, int16x8_t *h)
{
    int16x8_t cx[56] = {0};

    for(int i = 0;i<8;i++){
        cx[i] = (h[i]);

        cx[8+i] = (barrett_mla_1155(cx[8+i], h[0+i]));
        cx[8+i] = (barrett_mla_3595(cx[8+i], h[8+i]));
        cx[8+i] = (barrett_mla_770(cx[8+i], h[16+i]));
        cx[8+i] = (barrett_mla_4605(cx[8+i], h[24+i]));
        cx[8+i] = (barrett_mla_2464(cx[8+i], h[32+i]));
        cx[8+i] = (barrett_mla_2824(cx[8+i], h[40+i]));
        cx[8+i] = barrett_fake(barrett_mla_3055(cx[8+i], h[48+i]));

        cx[16+i] = (barrett_mla_1154(cx[16+i], h[0+i]));
        cx[16+i] = (barrett_mla_1541(cx[16+i], h[8+i]));
        cx[16+i] = (barrett_mla_2503(cx[16+i], h[16+i]));
        cx[16+i] = (barrett_fake(barrett_mla_4(cx[16+i], h[24+i])));
        cx[16+i] = (barrett_mla_1541(cx[16+i], h[32+i]));
        cx[16+i] = barrett_fake(barrett_mla_2503(cx[16+i], h[40+i]));

        cx[24+i] = (barrett_mla_2022(cx[24+i], h[0+i]));
        cx[24+i] = (barrett_mla_513(cx[24+i], h[8+i]));
        cx[24+i] = (barrett_fake(barrett_mla_289(cx[24+i], h[16+i])));
        cx[24+i] = (barrett_mla_20(cx[24+i], h[24+i]));
        cx[24+i] = (barrett_mla_2150(cx[24+i], h[40+i]));
        cx[24+i] = barrett_fake(barrett_mla_4268(cx[24+i], h[48+i]));

        cx[32+i] = barrett_mla_3466(cx[32+i], h[0+i]);
        cx[32+i] = (barrett_mla_770(cx[32+i], h[8+i]));
        cx[32+i] = (barrett_mla_2118(cx[32+i], h[16+i]));
        cx[32+i] = (barrett_mla_4616(cx[32+i], h[24+i]));
        cx[32+i] = (barrett_mla_770(cx[32+i], h[32+i]));
        cx[32+i] = barrett_fake(barrett_mla_2118(cx[32+i], h[40+i]));

        cx[40+i] = (barrett_mla_1444(cx[40+i], h[0+i]));
        cx[40+i] = (barrett_mla_2824(cx[40+i], h[8+i]));
        cx[40+i] = (barrett_mla_3562(cx[40+i], h[16+i]));
        cx[40+i] = (barrett_mla_4617(cx[40+i], h[24+i]));
        cx[40+i] = (barrett_mla_4467(cx[40+i], h[32+i]));
        cx[40+i] = (barrett_mla_4268(cx[40+i], h[40+i]));
        cx[40+i] = barrett_fake(barrett_mla_1919(cx[40+i], h[48+i]));
        
        cx[48+i] = barrett_fake(h[24+i]);
    }
    int16x8_t res[28] = {0};
    for (int i = 0; i < 6; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            res[(i * 4) + j] = barrett_fake(vaddq_s16(res[(i * 4) + j], cx[(i * 8) + j]));
        }
    }
    res[24] = barrett_fake(vaddq_s16(res[24], cx[48]));
    res[25] = barrett_fake(vaddq_s16(res[25], cx[49]));
    res[26] = barrett_fake(vaddq_s16(res[26], cx[50]));
    res[27] = barrett_fake(vaddq_s16(res[27], cx[51]));

    memcpy(c, res, 224*sizeof(int16_t));
}

void polymul_112x112_Toom(int16x8_t *c, int16x8_t *a, int16x8_t *b)
{
    int16x8_t aIn[28],  bIn[28], cIn[64];
    polymul_112x112_Toom_InputTransform(aIn, a);
    polymul_112x112_Toom_InputTransform(bIn, b);
    polymul_112x112_Toom_mul(cIn, aIn, bIn);
    polymul_112x112_Toom_OutputTransform(c, cIn);
}