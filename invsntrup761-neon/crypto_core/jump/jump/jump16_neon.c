#include "divstepsx_neon.h"
#include "jump_neon.h"
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>

// jumpdivstepsx on f,g length of 16, using two divsteps-8
int jump16(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[12], fg[4];
    int16x8x2_t tmp[2];

    delta = div8(delta, f, g, buf);
    tmp[0] = polymul_8x8(buf[0], f[1]);
    tmp[1] = polymul_8x8(buf[1], g[1]);
    fg[0] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    fg[1] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    tmp[0] = polymul_8x8(buf[2], f[1]);
    tmp[1] = polymul_8x8(buf[3], g[1]);
    fg[2] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    fg[3] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);    
    // f*x
    fg[1] = vextq_s16(fg[0], fg[1], 7);
    fg[0] = vextq_s16(v0, fg[0], 7);
    fg[0] = barrett_fake(vaddq_s16(fg[0], buf[4]));
    fg[2] = barrett_fake(vaddq_s16(fg[2], buf[5]));

    delta = div8(delta, fg, fg + 2, buf + 6);
    tmp[0] = polymul_8x8(buf[6], fg[1]);
    tmp[1] = polymul_8x8(buf[7], fg[3]);
    uvqr[8] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[9] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    tmp[0] = polymul_8x8(buf[8], fg[1]);
    tmp[1] = polymul_8x8(buf[9], fg[3]);
    uvqr[10] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[11] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);    
    // f*x
    uvqr[9] = vextq_s16(uvqr[8], uvqr[9], 7);
    uvqr[8] = vextq_s16(v0, uvqr[8], 7);
    uvqr[8] = barrett_fake(vaddq_s16(uvqr[8], buf[10]));
    uvqr[10] = barrett_fake(vaddq_s16(uvqr[10], buf[11]));

    // Merge two sets and store in uvqr
    tmp[0] = polymul_8x8(buf[6], buf[0]);
    tmp[1] = polymul_8x8(buf[7], buf[2]);
    tmp[0].val[1] = vextq_s16(tmp[0].val[0], tmp[0].val[1], 7);
    tmp[0].val[0] = vextq_s16(v0, tmp[0].val[0], 7);
    uvqr[0] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[1] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);    

    tmp[0] = polymul_8x8(buf[6], buf[1]);
    tmp[1] = polymul_8x8(buf[7], buf[3]);
    tmp[0].val[1] = vextq_s16(tmp[0].val[0], tmp[0].val[1], 7);
    tmp[0].val[0] = vextq_s16(v0, tmp[0].val[0], 7);
    uvqr[2] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[3] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    
    tmp[0] = polymul_8x8(buf[8], buf[0]);
    tmp[1] = polymul_8x8(buf[9], buf[2]);
    tmp[0].val[1] = vextq_s16(tmp[0].val[0], tmp[0].val[1], 7);
    tmp[0].val[0] = vextq_s16(v0, tmp[0].val[0], 7);
    uvqr[4] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[5] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    
    tmp[0] = polymul_8x8(buf[8], buf[1]);
    tmp[1] = polymul_8x8(buf[9], buf[3]);
    tmp[0].val[1] = vextq_s16(tmp[0].val[0], tmp[0].val[1], 7);
    tmp[0].val[0] = vextq_s16(v0, tmp[0].val[0], 7);
    uvqr[6] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[7] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    
    return (delta);
}


int jump15(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[12], fg[4];
    int16x8x2_t tmp[2];

    delta = div7(delta, f, g, buf);
    tmp[0] = polymul_8x8(buf[0], f[1]);
    tmp[1] = polymul_8x8(buf[1], g[1]);
    fg[0] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    fg[1] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    // f*x
    fg[1] = vextq_s16(fg[0], fg[1], 7);
    fg[0] = vextq_s16(v0, fg[0], 7);

    tmp[0] = polymul_8x8(buf[2], f[1]);
    tmp[1] = polymul_8x8(buf[3], g[1]);
    fg[2] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    fg[3] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    // g*x
    fg[3] = vextq_s16(fg[2], fg[3], 7);
    fg[2] = vextq_s16(v0, fg[2], 7);
    fg[0] =  barrett_fake(vaddq_s16(fg[0], buf[4]));
    fg[2] = barrett_fake(vaddq_s16(fg[2], buf[5]));
    

    delta = div8(delta, fg, fg + 2, buf + 6);
    tmp[0] = polymul_8x8(buf[6], fg[1]);
    tmp[1] = polymul_8x8(buf[7], fg[3]);
    uvqr[8] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[9] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    uvqr[9] = vextq_s16(uvqr[8], uvqr[9], 7);
    uvqr[8] = vextq_s16(v0, uvqr[8], 7);
    tmp[0] = polymul_8x8(buf[8], fg[1]);
    tmp[1] = polymul_8x8(buf[9], fg[3]);
    uvqr[10] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[11] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    uvqr[8] =  barrett_fake(vaddq_s16(uvqr[8], buf[10]));
    uvqr[10] = barrett_fake(vaddq_s16(uvqr[10], buf[11]));
    
    // Merge
    // u' = (ua + vc)x
    tmp[0] = polymul_8x8(buf[6], buf[0]);
    tmp[1] = polymul_8x8(buf[7], buf[2]);
    uvqr[0] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[1] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    uvqr[1] = vextq_s16(uvqr[0], uvqr[1], 7);
    uvqr[0] = vextq_s16(v0, uvqr[0], 7);
    tmp[0] = polymul_8x8(buf[6], buf[1]);
    tmp[1] = polymul_8x8(buf[7], buf[3]);
    uvqr[2] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[3] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    uvqr[3] = vextq_s16(uvqr[2], uvqr[3], 7);
    uvqr[2] = vextq_s16(v0, uvqr[2], 7);
    tmp[0] = polymul_8x8(buf[8], buf[0]);
    tmp[1] = polymul_8x8(buf[9], buf[2]);
    uvqr[4] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[5] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    tmp[0] = polymul_8x8(buf[8], buf[1]);
    tmp[1] = polymul_8x8(buf[9], buf[3]);
    uvqr[6] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[7] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    
    
    return (delta);
}

// jumpdivstepsx on f,g length of 64, using two divsteps-32
int jump16x(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[8], fg[4];
    int16x8x2_t tmp[2];

    delta = div8(delta, f, g, buf);
    tmp[0] = polymul_8x8(buf[0], f[1]);
    tmp[1] = polymul_8x8(buf[1], g[1]);
    fg[0] = (tmp[0].val[0] + tmp[1].val[0]);
    fg[1] = (tmp[0].val[1] + tmp[1].val[1]);
    tmp[0] = polymul_8x8(buf[2], f[1]);
    tmp[1] = polymul_8x8(buf[3], g[1]);
    fg[2] = (tmp[0].val[0] + tmp[1].val[0]);
    fg[3] = (tmp[0].val[1] + tmp[1].val[1]);    
    // f*x
    fg[1] = vextq_s16(fg[0], fg[1], 7);
    fg[0] = vextq_s16(v0, fg[0], 7);
    fg[0] = barrett_fake(vaddq_s16(fg[0], buf[4]));
    fg[2] = barrett_fake(vaddq_s16(fg[2], buf[5]));

    delta = div8x(delta, fg, fg + 2, buf + 6, f0);
    tmp[0] = polymul_8x8(buf[6], buf[0]);
    tmp[1] = polymul_8x8(buf[7], buf[2]);
    tmp[0].val[1] = vextq_s16(tmp[0].val[0], tmp[0].val[1], 7);
    tmp[0].val[0] = vextq_s16(v0, tmp[0].val[0], 7);
    uvqr[0] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[1] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);    
    tmp[0] = polymul_8x8(buf[6], buf[1]);
    tmp[1] = polymul_8x8(buf[7], buf[3]);
    tmp[0].val[1] = vextq_s16(tmp[0].val[0], tmp[0].val[1], 7);
    tmp[0].val[0] = vextq_s16(v0, tmp[0].val[0], 7);
    uvqr[2] = barrett_fake(tmp[0].val[0] + tmp[1].val[0]);
    uvqr[3] = barrett_fake(tmp[0].val[1] + tmp[1].val[1]);
    
    return (delta);
}