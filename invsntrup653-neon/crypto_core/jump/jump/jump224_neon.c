#include "jump_neon.h"
#include "macros_neon.h"
#include "polymul_neon.h"
#include "divstepsx_neon.h"
#include <arm_neon.h>

int jump220(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[168], fg[56], tmp[28], res[2][64], Toom_in[280];

    delta = jump110(delta, f, g, buf);
    polymul_112x112_Toom_InputTransform(Toom_in, buf);
    polymul_112x112_Toom_InputTransform(Toom_in+28, buf+14);
    polymul_112x112_Toom_InputTransform(Toom_in+56, buf+28);
    polymul_112x112_Toom_InputTransform(Toom_in+84, buf+42);
    polymul_112x112_Toom_InputTransform(Toom_in+224, f+14);
    polymul_112x112_Toom_InputTransform(Toom_in+252, g+14);
    polymul_112x112_Toom_mul(res[0], Toom_in, Toom_in+224);
    polymul_112x112_Toom_mul(res[1], Toom_in+28, Toom_in+252);  
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(fg, res[0]);
    polymul_112x112_Toom_mul(res[0], Toom_in+56, Toom_in+224);
    polymul_112x112_Toom_mul(res[1], Toom_in+84, Toom_in+252);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(fg+28, res[0]);
    //f = fx2
    for (int i = 27; i>0; i--) fg[i] = vextq_s16(fg[i-1], fg[i], 6);
    fg[0] = vextq_s16(v0_16, fg[0], 6);
    //g = gx2
    for (int i = 27; i>0; i--) fg[i+28] = vextq_s16(fg[i+27], fg[i+28], 6);
    fg[28] = vextq_s16(v0_16, fg[28], 6);
    for (int i = 0; i < 14; i++)
    {
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+56]));
        fg[i+28] = barrett_fake(vaddq_s16(fg[i+28], buf[i+70]));
    }

    delta = jump110(delta, fg, fg + 28, buf + 84);
    polymul_112x112_Toom_InputTransform(Toom_in+112, buf+84);
    polymul_112x112_Toom_InputTransform(Toom_in+140, buf+98);
    polymul_112x112_Toom_InputTransform(Toom_in+168, buf+112);
    polymul_112x112_Toom_InputTransform(Toom_in+196, buf+126);
    polymul_112x112_Toom_InputTransform(Toom_in+224, fg+14);
    polymul_112x112_Toom_InputTransform(Toom_in+252, fg+42);
    polymul_112x112_Toom_mul(res[0], Toom_in+112, Toom_in+224);
    polymul_112x112_Toom_mul(res[1], Toom_in+140, Toom_in+252);   
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(uvqr+336, res[0]);
    polymul_112x112_Toom_mul(res[0], Toom_in+168, Toom_in+224);
    polymul_112x112_Toom_mul(res[1], Toom_in+196, Toom_in+252);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(uvqr+364, res[0]);
    //f = fx2
    for (int i = 27; i>0; i--) uvqr[i+336] = vextq_s16(uvqr[i+335], uvqr[i+336], 6);
    uvqr[336] = vextq_s16(v0_16, uvqr[336], 6);
    //g = gx2
    for (int i = 27; i>0; i--) uvqr[i+364] = vextq_s16(uvqr[i+363], uvqr[i+364], 6);
    uvqr[364] = vextq_s16(v0_16, uvqr[364], 6);
    for (int i = 0; i < 14; i++)
    {
        uvqr[i + 336] = barrett_fake(vaddq_s16(uvqr[i + 336], buf[i + 140]));
        uvqr[i + 364] = barrett_fake(vaddq_s16(uvqr[i + 364], buf[i + 154]));
    }
    polymul_112x112_Toom_mul(res[0], Toom_in+112, Toom_in);
    polymul_112x112_Toom_mul(res[1], Toom_in+140, Toom_in+56);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(uvqr, res[0]);
    polymul_112x112_Toom_mul(res[0], Toom_in+112, Toom_in+28);
    polymul_112x112_Toom_mul(res[1], Toom_in+140, Toom_in+84);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(uvqr+84, res[0]); 
    polymul_112x112_Toom_mul(res[0], Toom_in+168, Toom_in);
    polymul_112x112_Toom_mul(res[1], Toom_in+196, Toom_in+56);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(uvqr+168, res[0]);  
    polymul_112x112_Toom_mul(res[0], Toom_in+168, Toom_in+28);
    polymul_112x112_Toom_mul(res[1], Toom_in+196, Toom_in+84);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(uvqr+252, res[0]);  
    
    return (delta);
}

int jump205(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[112], fg[56], tmp[28], res[2][64], Toom_in[280];
    
    delta = jump110(delta, f, g, buf);
    polymul_112x112_Toom_InputTransform(Toom_in, buf);
    polymul_112x112_Toom_InputTransform(Toom_in+28, buf+14);
    polymul_112x112_Toom_InputTransform(Toom_in+56, buf+28);
    polymul_112x112_Toom_InputTransform(Toom_in+84, buf+42);
    polymul_112x112_Toom_InputTransform(Toom_in+224, f+14);
    polymul_112x112_Toom_InputTransform(Toom_in+252, g+14);
    polymul_112x112_Toom_mul(res[0], Toom_in, Toom_in+224);
    polymul_112x112_Toom_mul(res[1], Toom_in+28, Toom_in+252);  
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(fg, res[0]);
    polymul_112x112_Toom_mul(res[0], Toom_in+56, Toom_in+224);
    polymul_112x112_Toom_mul(res[1], Toom_in+84, Toom_in+252);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(fg+28, res[0]);
    //f = fx2
    for (int i = 27; i>0; i--) fg[i] = vextq_s16(fg[i-1], fg[i], 6);
    fg[0] = vextq_s16(v0_16, fg[0], 6);
    //g = gx2
    for (int i = 27; i>0; i--) fg[i+28] = vextq_s16(fg[i+27], fg[i+28], 6);
    fg[28] = vextq_s16(v0_16, fg[28], 6);
    for (int i = 0; i < 14; i++)
    {
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+56]));
        fg[i+28] = barrett_fake(vaddq_s16(fg[i+28], buf[i+70]));
    }

    delta = jump95(delta, fg, fg + 28, buf + 84, f0);
    polymul_112x112_Toom_InputTransform(Toom_in+112, buf+84);
    polymul_112x112_Toom_InputTransform(Toom_in+140, buf+98);
    polymul_112x112_Toom_mul(res[0], Toom_in+112, Toom_in);
    polymul_112x112_Toom_mul(res[1], Toom_in+140, Toom_in+56);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(uvqr, res[0]);
    polymul_112x112_Toom_mul(res[0], Toom_in+112, Toom_in+28);
    polymul_112x112_Toom_mul(res[1], Toom_in+140, Toom_in+84);
    for (int i = 0; i < 64; i++) res[0][i] = (vaddq_s16(res[0][i], res[1][i]));
    polymul_112x112_Toom_OutputTransform(uvqr+84, res[0]);
    
    return (delta);
}