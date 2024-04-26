#include <arm_neon.h>
#include "crypto_core.h"
#include "polymul_neon.h"
#include "matrixmul_neon.h"
#include "divstepsx_neon.h"
#include "macros_neon.h"
#include <string.h>

static inline void reverse761(int8x16_t* out, int8x8_t* a){
    int8x8_t b[96] = {0};
    for(int i = 0;i<96;i++){
        b[i] = vrev64_s8(a[95-i]);
    }
    for(int i = 0;i<47;i++){
        out[i] = vextq_s8(((int8x16_t*)b)[i], ((int8x16_t*)b)[i+1], 6);
    }
    out[47] = vextq_s8(((int8x16_t*)b)[47], v0_8x16, 6);
}

static inline void reverse761_2(int8x16_t* out, int8x8_t* a){
    int8x8_t b[96] = {0};
    for(int i = 0;i<96;i++){
        b[i] = vrev64_s8(a[95-i]);
    }
    for(int i = 0;i<47;i++){
        out[i] = vextq_s8(((int8x16_t*)b)[i], ((int8x16_t*)b)[i+1], 7);
    }
    out[47] = vextq_s8(((int8x16_t*)b)[47], v0_8x16, 7);
}

//-1
static inline void Tcompress_128(uint8x16_t* sign, uint8x16_t* low, int8x16_t *inbytes){
    uint8x16_t t[8];
    transposeCompress(t, (int8_t*) inbytes);
    for(int i = 7;i>=0;i--){
        low[0]  = vaddq_u8(vshlq_n_u8(low[0], 1), vandq_u8(t[i], uv1));
        sign[0] = vaddq_u8(vshrq_n_u8(sign[0], 1), vandq_u8(t[7-i], uv128));
    }
}

static inline void Tdecompress_128(uint8x16_t *outbytes, uint8x16_t sign, uint8x16_t low){
    uint8x16_t t[8] = {0};
    for(int i = 0;i<8;i++){
        t[i] = vsubq_u8(vandq_u8(low, uv1), vshlq_n_u8(vandq_u8(sign, uv1), 1));
        low = vshrq_n_u8(low,1);
        sign = vshrq_n_u8(sign,1);
    }
    itransposeCompress((int8x16_t*)outbytes, t);
}

static inline void bitAdd(uint8x16_t* fv, uint8x16_t* fs, uint8x16_t fvn, uint8x16_t fsn){
    uint8x16_t tmp = fv[0];
    fv[0] = vorrq_u8(veorq_u8(veorq_u8(fv[0], fs[0]), fsn), veorq_u8(veorq_u8(fvn, fs[0]), fsn));
    fs[0] = vandq_u8(veorq_u8(tmp, fsn), veorq_u8(fs[0], fvn));
}

//int8 -> [compress -> jump128 -> decompress] -> polymul(update)
int crypto_core_jump(unsigned char *outbytes,const unsigned char *inbytes,const unsigned char *kbytes,const unsigned char *cbytes)
{
    int16_t minusdelta = -1;
    int8_t *out = (void *) outbytes;
    int8_t *in = (void *) inbytes;

    int8x16_t f[48] = {0}, g[48] = {0};
    int8x16_t v[48] = {0}, r[48] = {0}, uvqr[12][32] = {0};
    uint8x16_t gs = {0}, gv = {0}, fs = {0}, fv = {0}, fsn = {0}, fvn = {0}, gsn = {0}, gvn = {0};
    fv[0] = 1;
    f[47][8] = 2;
    f[47][9] = 2;
    //reverse_g
    reverse761_2(g, (int8x8_t*)inbytes);
    for(int i = 8;i<48;i++) g[i] = reduce_15(vaddq_s8(g[i], v6_8x16));
    Tcompress_128(&gs, &gv, g);
    minusdelta = div127(uvqr[0], &fv, &fs, &gv, &gs, minusdelta);
    matrixmul_fg(uvqr[0], f, g, 6);
    
    for(int k=0; k<5; k++){        
        //Compress f, g        
        transposeCompress_2(&fsn, &fvn, f, &sm, &lm);
        transposeCompress_2(&gsn, &gvn, g, &sm, &lm);
        //add last turn's f,g
        bitAdd(&fv, &fs, fvn, fsn);
        bitAdd(&gv, &gs, gvn, gsn);
        minusdelta = div127(uvqr[k+1], &fv, &fs, &gv, &gs, minusdelta);
        //update fg and vr                   
        matrixmul_fg(uvqr[k+1], f, g, 6);
    }
    for(int k=0; k<5; k++){
        //Compress f, g
        transposeCompress_2(&fsn, &fvn, f, &sm, &lm);
        transposeCompress_2(&gsn, &gvn, g, &sm, &lm);
        //add last turn's f,g
        bitAdd(&fv, &fs, fvn, fsn);
        bitAdd(&gv, &gs, gvn, gsn);
        minusdelta = div127(uvqr[k+6], &fv, &fs, &gv, &gs, minusdelta);
        //update fg and vr                    
        matrixmul_fg(uvqr[k+6], f, g, 6-k); //5-k
    }
    //Compress f, g
    transposeCompress_2(&fsn, &fvn, f, &sm, &lm);
    transposeCompress_2(&gsn, &gvn, g, &sm, &lm);
    bitAdd(&fv, &fs, fvn, fsn);
    bitAdd(&gv, &gs, gvn, gsn);
    minusdelta = div124(uvqr[11], &fv, &fs, &gv, &gs, minusdelta);

    matrix_merge(v, (int8x16_t*)uvqr);

    //mul g[0]/f[0] = g[0]f[0] %3
    int8x16_t f0 = vdupq_n_s8(vceqq_s8((int8x16_t)vandq_u8(fs, uv01), v01_8x16)[0]);
    for(int i = 0;i<48;i++){
        r[i] = reduce_15_2(vaddq_s8(vbslq_s8(f0, -v[i], v[i]), v6_8x16));
    }
    //reverse_out
    reverse761((int8x16_t*)out, (int8x8_t*) r);
    out[761] = int16_nonzero_mask(minusdelta);

    return 0;
}