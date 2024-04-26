#include "jump_neon.h"
#include "macros_neon.h"
#include "polymul_neon.h"
#include <arm_neon.h>
#include <stdio.h>

int jump1305(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *v, int* f0)
{
    int16x8_t buf[840];
    int16x8x4_t NTT_res[2][84];
    delta = jump660(delta, f, g, buf);
    delta = jump645(delta, buf+336, buf+420, buf+504, f0);
    polymul_672x672_GoodThomas_mul(NTT_res[0], buf+504, buf);
    polymul_672x672_GoodThomas_mul(NTT_res[1], buf+672, buf+168);
    for (int i = 0; i < 84; i++){
        for(int j = 0;j<4;j++){
            NTT_res[0][i].val[j] = barrett_fake(vaddq_s16(NTT_res[0][i].val[j], NTT_res[1][i].val[j]));
        }
    }
    polymul_672x672_GoodThomas_out(v, NTT_res[0]);
    return (delta);
}