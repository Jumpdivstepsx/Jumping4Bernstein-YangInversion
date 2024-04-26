#include "jump_neon.h"
#include "macros_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>
#include <stdio.h>

int jump1521(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *v, int* f0)
{
    int16x8_t buf[576], NTT_res[2][96];
    delta = jump762(delta, f, g, buf);
    delta = jump759(delta, buf+192, buf+288, buf+384, f0);  
    polymul_768x768_rader_16x16(NTT_res[0], buf+384, buf);
    polymul_768x768_rader_16x16(NTT_res[1], buf+480, buf+96);
    for(int i = 0; i < 96;i++) NTT_res[0][i] = barrett_fake(vaddq_s16(NTT_res[0][i], NTT_res[1][i]));
    polymul_768x768_rader_out(v, NTT_res[0]);
    return (delta);
}