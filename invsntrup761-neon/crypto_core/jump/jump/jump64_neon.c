#include "divstepsx_neon.h"
#include "jump_neon.h"
#include "macros_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>

/*
================ div16 ================
*/

int jump64_16(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[48] = {0}, fg[16] = {0}, mc[11][8];

    delta = jump32(delta, f, g, buf);
    __asm_4x32x32_fx1(fg, buf, f+4, g+4, mc);
    for(int i = 0;i<4;i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+16]));
        fg[i + 8] = barrett_fake(vaddq_s16(fg[i + 8], buf[i + 20]));
    }

    delta = jump32(delta, fg, fg + 8, buf + 24);
    __asm_4x32x32_fx1(uvqr+32, buf+24, fg+4, fg+12, mc);
    for(int i = 0;i<4;i++){
        uvqr[i+32] = barrett_fake(vaddq_s16(uvqr[i+32], buf[i+40]));
        uvqr[i+40] = barrett_fake(vaddq_s16(uvqr[i+40], buf[i+44]));
    }

    // u' = uax + vc
    polymul_32x32(mc[0], buf + 24, buf);
    for(int i = 7;i>0;i--) mc[0][i] = vextq_s16(mc[0][i-1], mc[0][i], 7);
    mc[0][0] = vextq_s16(v0, mc[0][0], 7);
    polymul_32x32(uvqr, buf + 28, buf+8);
    for(int i = 0;i<8;i++) uvqr[i] = barrett_fake(vaddq_s16(uvqr[i], mc[0][i]));
    
    // q' = qax + rc
    polymul_32x32(mc[0], buf + 32, buf);
    for(int i = 7;i>0;i--) mc[0][i] = vextq_s16(mc[0][i-1], mc[0][i], 7);
    mc[0][0] = vextq_s16(v0, mc[0][0], 7);
    polymul_32x32(uvqr+16, buf + 36, buf+8);
    for(int i = 0;i<8;i++) uvqr[i+16] = barrett_fake(vaddq_s16(uvqr[i+16], mc[0][i]));

    // v' = ubx + vd
    polymul_32x32(mc[0], buf + 24, buf+4);
    for(int i = 7;i>0;i--) mc[0][i] = vextq_s16(mc[0][i-1], mc[0][i], 7);
    mc[0][0] = vextq_s16(v0, mc[0][0], 7);
    polymul_32x32(uvqr+8, buf + 28, buf+12);
    for(int i = 0;i<8;i++) uvqr[i+8] = barrett_fake(vaddq_s16(uvqr[i+8], mc[0][i]));

    // r' = qbx + rd
    polymul_32x32(mc[0], buf + 32, buf+4);
    for(int i = 7;i>0;i--) mc[0][i] = vextq_s16(mc[0][i-1], mc[0][i], 7);
    mc[0][0] = vextq_s16(v0, mc[0][0], 7);
    polymul_32x32(uvqr+24, buf + 36, buf+12);
    for(int i = 0;i<8;i++) uvqr[i+24] = barrett_fake(vaddq_s16(uvqr[i+24], mc[0][i]));
    
    return (delta);
}

int jump63_16(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr){
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[48] = {0}, fg[16] = {0}, mc[11][8];

    delta = jump31(delta, f, g, buf);
    __asm_4x32x32_x1(fg, buf, f+4, g+4, mc);
    for(int i = 0;i<4;i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+16]));
        fg[i + 8] = barrett_fake(vaddq_s16(fg[i + 8], buf[i + 20]));
    }

    delta = jump32(delta, fg, fg + 8, buf + 24);
    __asm_4x32x32_fx1(uvqr+32, buf+24, fg+4, fg+12, mc);
    for(int i = 0;i<4;i++){
        uvqr[i+32] = barrett_fake(vaddq_s16(uvqr[i+32], buf[i+40]));
        uvqr[i+40] = barrett_fake(vaddq_s16(uvqr[i+40], buf[i+44]));
    }
    
    // u' = (ua + vc)x
    polymul_32x32(mc[0], buf + 24, buf);
    polymul_32x32(uvqr, buf + 28, buf+8);
    for(int i = 0;i<8;i++) uvqr[i] = barrett_fake(vaddq_s16(uvqr[i], mc[0][i]));
    for(int i = 7;i>0;i--) uvqr[i] = vextq_s16(uvqr[i-1], uvqr[i], 7);
    uvqr[0] = vextq_s16(v0, uvqr[0], 7);
    
    // q' = qa + rc
    polymul_32x32(mc[0], buf + 32, buf);
    polymul_32x32(uvqr+16, buf + 36, buf+8);
    for(int i = 0;i<8;i++) uvqr[i+16] = barrett_fake(vaddq_s16(uvqr[i+16], mc[0][i]));
    
    // v' = (ub + vd)x
    polymul_32x32(mc[0], buf + 24, buf+4);
    polymul_32x32(uvqr+8, buf + 28, buf+12);
    for(int i = 0;i<8;i++) uvqr[i+8] = barrett_fake(vaddq_s16(uvqr[i+8], mc[0][i]));
    for(int i = 7;i>0;i--) uvqr[i+8] = vextq_s16(uvqr[i+7], uvqr[i+8], 7);
    uvqr[8] = vextq_s16(v0, uvqr[8], 7);

    // r' = qb + rd
    polymul_32x32(mc[0], buf + 32, buf+4);
    polymul_32x32(uvqr+24, buf + 36, buf+12);
    for(int i = 0;i<8;i++) uvqr[i+24] = barrett_fake(vaddq_s16(uvqr[i+24], mc[0][i]));
    
    return (delta);
}

int jump62_16(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[48] = {0}, fg[16] = {0}, mc[11][8];

    delta = jump31(delta, f, g, buf);
    __asm_4x32x32_x1(fg, buf, f+4, g+4, mc);
    for(int i = 0;i<4;i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+16]));
        fg[i + 8] = barrett_fake(vaddq_s16(fg[i + 8], buf[i + 20]));
    }

    delta = jump31(delta, fg, fg + 8, buf + 24);
    __asm_4x32x32_x1(uvqr+32, buf+24, fg+4, fg+12, mc);
    for(int i = 0;i<4;i++){
        uvqr[i+32] = barrett_fake(vaddq_s16(uvqr[i+32], buf[i+40]));
        uvqr[i+40] = barrett_fake(vaddq_s16(uvqr[i+40], buf[i+44]));
    }

    __asm_4x32x32_uvqr(uvqr  , buf+24, buf  , buf+8 , mc);
    __asm_4x32x32_uvqr(uvqr+8, buf+24, buf+4, buf+12, mc);
    return (delta);
}

int jump62_16x(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[48] = {0}, fg[16] = {0}, mc[11][8];

    delta = jump31(delta, f, g, buf);
    __asm_4x32x32_x1(fg, buf, f+4, g+4, mc);
    for(int i = 0;i<4;i++){
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i+16]));
        fg[i + 8] = barrett_fake(vaddq_s16(fg[i + 8], buf[i + 20]));
    }

    delta = jump31x(delta, fg, fg + 8, buf + 24);
    uvqr[32][0] = buf[40][0];
                               
    __asm_4x32x32_uvqr(uvqr  , buf+24, buf  , buf+8 , mc);
    __asm_4x32x32_uvqr(uvqr+8, buf+24, buf+4, buf+12, mc);
    return (delta);
}


/*
================ div32 ================
*/


// jumpdivstepsx on f,g length of 64, using two divsteps-32
int jump64_32(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[48] = {0}, fg[16] = {0}, mc[11][8];

    delta = div32(delta, f, g, buf);
    __asm_4x32x32_fx1(fg, buf, f+4, g+4, mc);
    for(int i = 0;i<4;i++){
        fg[i] = (vaddq_s16(fg[i], buf[i+16]));
        fg[i + 8] = (vaddq_s16(fg[i + 8], buf[i + 20]));
    }

    delta = div32(delta, fg, fg + 8, buf + 24);
    __asm_4x32x32_fx1(uvqr+32, buf+24, fg+4, fg+12, mc);
    for(int i = 0;i<4;i++){
        uvqr[i+32] = barrett_fake(vaddq_s16(uvqr[i+32], buf[i+40]));
        uvqr[i+40] = barrett_fake(vaddq_s16(uvqr[i+40], buf[i+44]));
    }
    
    polymul_32x32(mc[0], buf + 24, buf);
    for(int i = 7;i>0;i--) mc[0][i] = vextq_s16(mc[0][i-1], mc[0][i], 7);
    mc[0][0] = vextq_s16(v0, mc[0][0], 7);
    polymul_32x32(uvqr, buf + 28, buf+8);
    for(int i = 0;i<8;i++) uvqr[i] = vaddq_s16(uvqr[i], mc[0][i]);
    polymul_32x32(mc[0], buf + 24, buf+4);
    for(int i = 7;i>0;i--) mc[0][i] = vextq_s16(mc[0][i-1], mc[0][i], 7);
    mc[0][0] = vextq_s16(v0, mc[0][0], 7);
    polymul_32x32(uvqr+8, buf + 28, buf+12);
    for(int i = 0;i<8;i++) uvqr[i+8] = vaddq_s16(uvqr[i+8], mc[0][i]);
    polymul_32x32(mc[0], buf + 32, buf);
    for(int i = 7;i>0;i--) mc[0][i] = vextq_s16(mc[0][i-1], mc[0][i], 7);
    mc[0][0] = vextq_s16(v0, mc[0][0], 7);
    polymul_32x32(uvqr+16, buf + 36, buf+8);
    for(int i = 0;i<8;i++) uvqr[i+16] = vaddq_s16(uvqr[i+16], mc[0][i]);
    polymul_32x32(mc[0], buf + 32, buf+4);
    for(int i = 7;i>0;i--) mc[0][i] = vextq_s16(mc[0][i-1], mc[0][i], 7);
    mc[0][0] = vextq_s16(v0, mc[0][0], 7);
    polymul_32x32(uvqr+24, buf + 36, buf+12);
    for(int i = 0;i<8;i++) uvqr[i+24] = vaddq_s16(uvqr[i+24], mc[0][i]);
    
    return (delta);
}

int jump63_32(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr){
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[48] = {0}, fg[16] = {0}, mc[11][8];

    delta = div31(delta, f, g, buf);
    __asm_4x32x32_x1(fg, buf, f+4, g+4, mc);
    for(int i = 0;i<4;i++){
        fg[i] = (vaddq_s16(fg[i], buf[i+16]));
        fg[i + 8] = (vaddq_s16(fg[i + 8], buf[i + 20]));
    }

    delta = div32(delta, fg, fg + 8, buf + 24);
    __asm_4x32x32_fx1(uvqr+32, buf+24, fg+4, fg+12, mc);
    for(int i = 0;i<4;i++){
        uvqr[i+32] = barrett_fake(vaddq_s16(uvqr[i+32], buf[i+40]));
        uvqr[i+40] = barrett_fake(vaddq_s16(uvqr[i+40], buf[i+44]));
    }
    
    polymul_32x32(mc[0], buf + 24, buf);
    polymul_32x32(uvqr, buf + 28, buf+8);
    for(int i = 0;i<8;i++) uvqr[i] = (vaddq_s16(uvqr[i], mc[0][i]));
    for(int i = 7;i>0;i--) uvqr[i] = vextq_s16(uvqr[i-1], uvqr[i], 7);
    uvqr[0] = vextq_s16(v0, uvqr[0], 7);
    polymul_32x32(mc[0], buf + 24, buf+4);
    polymul_32x32(uvqr+8, buf + 28, buf+12);
    for(int i = 0;i<8;i++) uvqr[i+8] = (vaddq_s16(uvqr[i+8], mc[0][i]));
    for(int i = 7;i>0;i--) uvqr[i+8] = vextq_s16(uvqr[i+7], uvqr[i+8], 7);
    uvqr[8] = vextq_s16(v0, uvqr[8], 7);
    polymul_32x32(mc[0], buf + 32, buf);
    polymul_32x32(uvqr+16, buf + 36, buf+8);
    for(int i = 0;i<8;i++) uvqr[i+16] = (vaddq_s16(uvqr[i+16], mc[0][i]));
    polymul_32x32(mc[0], buf + 32, buf+4);
    polymul_32x32(uvqr+24, buf + 36, buf+12);
    for(int i = 0;i<8;i++) uvqr[i+24] = (vaddq_s16(uvqr[i+24], mc[0][i]));
    
    return (delta);
}

int jump62_32(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[48] = {0}, fg[16] = {0}, mc[11][8];

    delta = div31(delta, f, g, buf);
    __asm_4x32x32_x1(fg, buf, f+4, g+4, mc);
    for(int i = 0;i<4;i++){
        fg[i] = (vaddq_s16(fg[i], buf[i+16]));
        fg[i + 8] = (vaddq_s16(fg[i + 8], buf[i + 20]));
    }

    delta = div31(delta, fg, fg + 8, buf + 24);
    __asm_4x32x32_x1(uvqr+32, buf+24, fg+4, fg+12, mc);
    for(int i = 0;i<4;i++){
        uvqr[i+32] = barrett_fake(vaddq_s16(uvqr[i+32], buf[i+40]));
        uvqr[i+40] = barrett_fake(vaddq_s16(uvqr[i+40], buf[i+44]));
    }

    __asm_4x32x32_uvqr(uvqr  , buf+24, buf  , buf+8 , mc);
    __asm_4x32x32_uvqr(uvqr+8, buf+24, buf+4, buf+12, mc);
    return (delta);
}