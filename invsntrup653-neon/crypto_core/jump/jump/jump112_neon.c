#include "jump_neon.h"
#include "macros_neon.h"
#include "polymul_neon.h"
#include "divstepsx_neon.h"
#include <arm_neon.h>


int jump110(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[84], fg[28], tmp[14], Toom_in[140];
    int16x8x4_t r1[7], r2[7];

    delta = div55(delta, f, g, buf);
    polymul_56x56_Toom_InputTransform(Toom_in, buf);
    polymul_56x56_Toom_InputTransform(Toom_in+14, buf+7);
    polymul_56x56_Toom_InputTransform(Toom_in+28, buf+14);
    polymul_56x56_Toom_InputTransform(Toom_in+42, buf+21);
    polymul_56x56_Toom_InputTransform(Toom_in+112, f+7);
    polymul_56x56_Toom_InputTransform(Toom_in+126, g+7);
    polymul_56x56_Toom_Mul(r1, Toom_in, Toom_in+112);
    polymul_56x56_Toom_Mul(r2, Toom_in+14, Toom_in+126);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(fg, r1);
    polymul_56x56_Toom_Mul(r1, Toom_in+28, Toom_in+112);
    polymul_56x56_Toom_Mul(r2, Toom_in+42, Toom_in+126);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(fg+14, r1);
    //f = fx
    for (int i = 13; i>0; i--) fg[i] = vextq_s16(fg[i-1], fg[i], 7);
    fg[0] = vextq_s16(v0_16, fg[0], 7);
    //g = gx
    for (int i = 13; i>0; i--) fg[i+14] = vextq_s16(fg[i+13], fg[i+14], 7);
    fg[14] = vextq_s16(v0_16, fg[14], 7);
    for (int i = 0; i < 7; i++)
    {
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+28]));
        fg[i+14] = barrett_fake(vaddq_s16(fg[i+14], buf[i+35]));
    }

    delta = div55(delta, fg, fg + 14, buf + 42);
    polymul_56x56_Toom_InputTransform(Toom_in+56, buf+42);
    polymul_56x56_Toom_InputTransform(Toom_in+70, buf+49);
    polymul_56x56_Toom_InputTransform(Toom_in+84, buf+56);
    polymul_56x56_Toom_InputTransform(Toom_in+98, buf+63);
    polymul_56x56_Toom_InputTransform(Toom_in+112, fg+7);
    polymul_56x56_Toom_InputTransform(Toom_in+126, fg+21);
    polymul_56x56_Toom_Mul(r1, Toom_in+56, Toom_in+112);
    polymul_56x56_Toom_Mul(r2, Toom_in+70, Toom_in+126);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(uvqr+56, r1);
    polymul_56x56_Toom_Mul(r1, Toom_in+84, Toom_in+112);
    polymul_56x56_Toom_Mul(r2, Toom_in+98, Toom_in+126);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(uvqr+70, r1);
    //f = fx
    for (int i = 13; i>0; i--) uvqr[i+56] = vextq_s16(uvqr[i+55], uvqr[i+56], 7);
    uvqr[56] = vextq_s16(v0_16, uvqr[56], 7);
    //g = gx
    for (int i = 13; i>0; i--) uvqr[i+70] = vextq_s16(uvqr[i+69], uvqr[i+70], 7);
    uvqr[70] = vextq_s16(v0_16, uvqr[70], 7);
    for (int i = 0; i < 7; i++)
    {
        uvqr[i + 56] = barrett_fake(vaddq_s16(uvqr[i + 56], buf[i + 70]));
        uvqr[i + 70] = barrett_fake(vaddq_s16(uvqr[i + 70], buf[i + 77]));
    }

    //Merge uvqr
    polymul_56x56_Toom_Mul(r1, Toom_in+56, Toom_in);
    polymul_56x56_Toom_Mul(r2, Toom_in+70, Toom_in+28);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(uvqr, r1);
    polymul_56x56_Toom_Mul(r1, Toom_in+56, Toom_in+14);
    polymul_56x56_Toom_Mul(r2, Toom_in+70, Toom_in+42);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(uvqr+14, r1);
    polymul_56x56_Toom_Mul(r1, Toom_in+84, Toom_in);
    polymul_56x56_Toom_Mul(r2, Toom_in+98, Toom_in+28);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(uvqr+28, r1);
    polymul_56x56_Toom_Mul(r1, Toom_in+84, Toom_in+14);
    polymul_56x56_Toom_Mul(r2, Toom_in+98, Toom_in+42);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(uvqr+42, r1);
    
    return (delta);
}


int jump95(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[56], fg[28], tmp[14], Toom_in[140];
    int16x8x4_t r1[7], r2[7];

    delta = div55(delta, f, g, buf);
    polymul_56x56_Toom_InputTransform(Toom_in, buf);
    polymul_56x56_Toom_InputTransform(Toom_in+14, buf+7);
    polymul_56x56_Toom_InputTransform(Toom_in+28, buf+14);
    polymul_56x56_Toom_InputTransform(Toom_in+42, buf+21);
    polymul_56x56_Toom_InputTransform(Toom_in+112, f+7);
    polymul_56x56_Toom_InputTransform(Toom_in+126, g+7);
    polymul_56x56_Toom_Mul(r1, Toom_in, Toom_in+112);
    polymul_56x56_Toom_Mul(r2, Toom_in+14, Toom_in+126);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(fg, r1);
    polymul_56x56_Toom_Mul(r1, Toom_in+28, Toom_in+112);
    polymul_56x56_Toom_Mul(r2, Toom_in+42, Toom_in+126);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(fg+14, r1);
    //f = fx
    for (int i = 13; i>0; i--) fg[i] = vextq_s16(fg[i-1], fg[i], 7);
    fg[0] = vextq_s16(v0_16, fg[0], 7);
    //g = gx
    for (int i = 13; i>0; i--) fg[i+14] = vextq_s16(fg[i+13], fg[i+14], 7);
    fg[14] = vextq_s16(v0_16, fg[14], 7);
    for (int i = 0; i < 7; i++)
    {
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+28]));
        fg[i+14] = barrett_fake(vaddq_s16(fg[i+14], buf[i+35]));
    }

    delta = div40(delta, fg, fg + 14, buf + 42, f0);
    polymul_56x56_Toom_InputTransform(Toom_in+56, buf+42);
    polymul_56x56_Toom_InputTransform(Toom_in+70, buf+49);
    
    //Merge uvqr
    polymul_56x56_Toom_Mul(r1, Toom_in+56, Toom_in);
    polymul_56x56_Toom_Mul(r2, Toom_in+70, Toom_in+28);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(uvqr, r1);
    polymul_56x56_Toom_Mul(r1, Toom_in+56, Toom_in+14);
    polymul_56x56_Toom_Mul(r2, Toom_in+70, Toom_in+42);
    for (int i = 0; i < 28; i++) r1[i/4].val[i%4] = barrett_fake(vaddq_s16(r1[i/4].val[i%4], r2[i/4].val[i%4]));
    polymul_56x56_Toom_OutputTransform(uvqr+14, r1);
    
    return (delta);
}