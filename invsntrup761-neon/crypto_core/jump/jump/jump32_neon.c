#include "divstepsx_neon.h"
#include "jump_neon.h"
#include "macros_neon.h"
#include "matrixmul_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>

// jumpdivstepsx on f,g length of 64, using two divsteps-32
int jump32(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[24], fg[8], tmp[4];

    delta = div16(delta, f, g, buf);
    //delta = jump16(delta, f, g, buf);
    matrixmul_16x16_uvqr_fg(fg, buf, f + 2, g + 2);
    for(int i = 3;i>0;i--) fg[i] = vextq_s16(fg[i-1], fg[i], 7);
    fg[0] = vextq_s16(v0, fg[0], 7);

    for (int i = 0; i < 2; i++)
    {
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i + 8]));
        fg[i + 4] = barrett_fake(vaddq_s16(fg[i + 4], buf[i + 10]));
    }

    delta = div16(delta, fg, fg + 4, buf + 12);
    matrixmul_16x16_uvqr_fg(uvqr + 16, buf + 12, fg + 2, fg + 6);
    for(int i = 3;i>0;i--) uvqr[i+16] = vextq_s16(uvqr[i+15], uvqr[i+16], 7);
    uvqr[16] = vextq_s16(v0, uvqr[16], 7);

    for (int i = 0; i < 2; i++)
    {
        uvqr[i + 16] = barrett_fake(vaddq_s16(uvqr[i + 16], buf[i + 20]));
        uvqr[i + 20] = barrett_fake(vaddq_s16(uvqr[i + 20], buf[i + 22]));
    }

    // Merge two sets and store in uvqr
    // u' = uax + vc
    convert16x16(tmp, buf + 12, buf);
    for(int i = 3;i>0;i--) tmp[i] = vextq_s16(tmp[i-1], tmp[i], 7);
    tmp[0] = vextq_s16(v0, tmp[0], 7);
    convert16x16(uvqr, buf + 14, buf+4);
    for(int i = 0;i<4;i++) uvqr[i] = barrett_fake(vaddq_s16(uvqr[i], tmp[i]));

    // v' = ubx + vd
    convert16x16(tmp, buf + 12, buf+2);
    for(int i = 3;i>0;i--) tmp[i] = vextq_s16(tmp[i-1], tmp[i], 7);
    tmp[0] = vextq_s16(v0, tmp[0], 7);
    convert16x16(uvqr+4, buf + 14, buf+6);
    for(int i = 0;i<4;i++) uvqr[i+4] = barrett_fake(vaddq_s16(uvqr[i+4], tmp[i]));
    
    // q' = qax + rc
    convert16x16(tmp, buf + 16, buf);
    for(int i = 3;i>0;i--) tmp[i] = vextq_s16(tmp[i-1], tmp[i], 7);
    tmp[0] = vextq_s16(v0, tmp[0], 7);
    convert16x16(uvqr+8, buf + 18, buf+4);
    for(int i = 0;i<4;i++) uvqr[i+8] = barrett_fake(vaddq_s16(uvqr[i+8], tmp[i]));
    
    // r' = qbx + rd
    convert16x16(tmp, buf + 16, buf+2);
    for(int i = 3;i>0;i--) tmp[i] = vextq_s16(tmp[i-1], tmp[i], 7);
    tmp[0] = vextq_s16(v0, tmp[0], 7);
    convert16x16(uvqr+12, buf + 18, buf+6);
    for(int i = 0;i<4;i++) uvqr[i+12] = barrett_fake(vaddq_s16(uvqr[i+12], tmp[i]));
    
    return (delta);
}


// jumpdivstepsx on f,g length of 64, using two divsteps-32
int jump31(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[24], fg[8], tmp[4];

    delta = div15(delta, f, g, buf);
    //delta = jump15(delta, f, g, buf);
    matrixmul_16x16_uvqr_fg(fg, buf, f + 2, g + 2);
    for(int i = 3;i>0;i--) fg[i] = vextq_s16(fg[i-1], fg[i], 7);
    fg[0] = vextq_s16(v0, fg[0], 7);
    for(int i = 3;i>0;i--) fg[i+4] = vextq_s16(fg[i+3], fg[i+4], 7);
    fg[4] = vextq_s16(v0, fg[4], 7);

    for (int i = 0; i < 2; i++)
    {
        fg[i] =  barrett_fake(vaddq_s16(fg[i], buf[i + 8]));
        fg[i + 4] = barrett_fake(vaddq_s16(fg[i + 4], buf[i + 10]));
    }

    delta = div16(delta, fg, fg + 4, buf + 12);
    //delta = jump16(delta, fg, fg + 4, buf + 12);
    matrixmul_16x16_uvqr_fg(uvqr + 16, buf + 12, fg + 2, fg + 6);
    for(int i = 3;i>0;i--) uvqr[i+16] = vextq_s16(uvqr[i+15], uvqr[i+16], 7);
    uvqr[16] = vextq_s16(v0, uvqr[16], 7);

    for (int i = 0; i < 2; i++)
    {
        uvqr[i + 16] = barrett_fake(vaddq_s16(uvqr[i + 16], buf[i + 20]));
        uvqr[i + 20] = barrett_fake(vaddq_s16(uvqr[i + 20], buf[i + 22]));
    }

    // Merge two sets and store in uvqr
    // u' = (ua + vc)x
    convert16x16(tmp, buf + 12, buf);
    convert16x16(uvqr, buf + 14, buf+4);
    for(int i = 0;i<4;i++) uvqr[i] = barrett_fake(vaddq_s16(uvqr[i], tmp[i]));
    for(int i = 3;i>0;i--) uvqr[i] = vextq_s16(uvqr[i-1], uvqr[i], 7);
    uvqr[0] = vextq_s16(v0, uvqr[0], 7);

    // v' = (ub + vd)x
    convert16x16(tmp, buf + 12, buf+2);
    convert16x16(uvqr+4, buf + 14, buf+6);
    for(int i = 0;i<4;i++) uvqr[i+4] = barrett_fake(vaddq_s16(uvqr[i+4], tmp[i]));
    for(int i = 3;i>0;i--) uvqr[i+4] = vextq_s16(uvqr[i+3], uvqr[i+4], 7);
    uvqr[4] = vextq_s16(v0, uvqr[4], 7);
    
    // q' = qa + rc
    convert16x16(tmp, buf + 16, buf);
    convert16x16(uvqr+8, buf + 18, buf+4);
    for(int i = 0;i<4;i++) uvqr[i+8] = barrett_fake(vaddq_s16(uvqr[i+8], tmp[i]));
    
    // r' = qb + rd
    convert16x16(tmp, buf + 16, buf+2);
    convert16x16(uvqr+12, buf + 18, buf+6);
    for(int i = 0;i<4;i++) uvqr[i+12] = barrett_fake(vaddq_s16(uvqr[i+12], tmp[i]));
    
    return (delta);
}

int jump31x(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr)
{
    // buf is set for two sets of u,v,q,r,f,g
    int16x8_t buf[24], fg[8], tmp[4];

    delta = div15(delta, f, g, buf);
    //delta = jump15(delta, f, g, buf);
    matrixmul_16x16_uvqr_fg(fg, buf, f + 2, g + 2);
    for(int i = 3;i>0;i--) fg[i] = vextq_s16(fg[i-1], fg[i], 7);
    fg[0] = vextq_s16(v0, fg[0], 7);
    for(int i = 3;i>0;i--) fg[i+4] = vextq_s16(fg[i+3], fg[i+4], 7);
    fg[4] = vextq_s16(v0, fg[4], 7);

    for (int i = 0; i < 2; i++)
    {
        fg[i] = barrett_fake(vaddq_s16(fg[i], buf[i + 8]));
        fg[i + 4] = barrett_fake(vaddq_s16(fg[i + 4], buf[i + 10]));
    }

    //int f0;
    //delta = jump16x(delta, fg, fg + 4, buf + 12, &f0);
    delta = div16(delta, fg, fg + 4, buf + 12);

    //uvqr[16][0] = f0;
    uvqr[16][0] = buf[20][0];

    // Merge two sets and store in uvqr
    // u' = (ua + vc)x
    convert16x16(tmp, buf + 12, buf);
    convert16x16(uvqr, buf + 14, buf+4);
    for(int i = 0;i<4;i++) uvqr[i] = barrett_fake(vaddq_s16(uvqr[i], tmp[i]));
    for(int i = 3;i>0;i--) uvqr[i] = vextq_s16(uvqr[i-1], uvqr[i], 7);
    uvqr[0] = vextq_s16(v0, uvqr[0], 7);

    // v' = (ub + vd)x
    convert16x16(tmp, buf + 12, buf+2);
    convert16x16(uvqr+4, buf + 14, buf+6);
    for(int i = 0;i<4;i++) uvqr[i+4] = barrett_fake(vaddq_s16(uvqr[i+4], tmp[i]));
    for(int i = 3;i>0;i--) uvqr[i+4] = vextq_s16(uvqr[i+3], uvqr[i+4], 7);
    uvqr[4] = vextq_s16(v0, uvqr[4], 7);
    
    return (delta);
}