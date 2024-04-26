#ifndef _MACROS_NEON_H_
#define _MACROS_NEON_H_

#include <arm_neon.h>

#define v0_16 vdupq_n_s16(0)
#define v0_32x4 vdupq_n_s32(0)

#define v01_16 vsetq_lane_s16(1, v0_16, 0)

#define v7_16 vdupq_n_s16(7)           // (65536/4591) /2
#define v464722_32x4 vdupq_n_s32(464722)           // (65536^2/4591) /2
#define v4621_16 vdupq_n_s16(4621)
#define v36037_16 vdupq_n_s16(36037)   // 1/4621
#define v1951_16 vdupq_n_s16(1951)     // 65536^2
#define v53595_16 vdupq_n_s16(53595)   // 65536^2/4621

// ============================================================
/* Barrett reduction */  
// ============================================================
#define v1763_16 vdupq_n_s16(1763)
#define v12501_16 vdupq_n_s16(12501)
#define v1764_16 vdupq_n_s16(1764)
#define v12508_16 vdupq_n_s16(12508)
#define v3443_16 vdupq_n_s16(3443)
#define v24414_16 vdupq_n_s16(24414)
#define v511_16 vdupq_n_s16(511)
#define v3623_16 vdupq_n_s16(3623)
#define v765_16 vdupq_n_s16(765)
#define v5424_16 vdupq_n_s16(5424)
#define v4575_16 vdupq_n_s16(4575)
#define v32441_16 vdupq_n_s16(32441)
#define v2448_16 vdupq_n_s16(2448)
#define v17359_16 vdupq_n_s16(17359)
#define v4336_16 vdupq_n_s16(4336)
#define v30747_16 vdupq_n_s16(30747)
#define v2270_16 vdupq_n_s16(2270)
#define v16096_16 vdupq_n_s16(16096)
#define v3442_16 vdupq_n_s16(3442)
#define v24407_16 vdupq_n_s16(24407)
#define v1531_16 vdupq_n_s16(1531)
#define v10856_16 vdupq_n_s16(10856)
#define v1339_16 vdupq_n_s16(1339)
#define v9494_16 vdupq_n_s16(9494)
#define v4_16 vdupq_n_s16(4)
#define v28_16 vdupq_n_s16(28)
#define v1435_16 vdupq_n_s16(1435)
#define v10175_16 vdupq_n_s16(10175)
#define v2040_16 vdupq_n_s16(2040)
#define v14465_16 vdupq_n_s16(14465)
#define v861_16 vdupq_n_s16(861)
#define v6105_16 vdupq_n_s16(6105)
#define v20_16 vdupq_n_s16(20)
#define v141_16 vdupq_n_s16(141)
#define v797_16 vdupq_n_s16(797)
#define v5651_16 vdupq_n_s16(5651)
#define v4049_16 vdupq_n_s16(4049)
#define v28711_16 vdupq_n_s16(28711)
#define v1148_16 vdupq_n_s16(1148)
#define v8140_16 vdupq_n_s16(8140)
#define v765_16 vdupq_n_s16(765)
#define v5424_16 vdupq_n_s16(5424)
#define v3252_16 vdupq_n_s16(3252)
#define v23060_16 vdupq_n_s16(23060)
#define v4586_16 vdupq_n_s16(4586)
#define v32519_16 vdupq_n_s16(32519)
#define v4304_16 vdupq_n_s16(4304)
#define v30520_16 vdupq_n_s16(30520)
#define v4336_16 vdupq_n_s16(4336)
#define v30747_16 vdupq_n_s16(30747)
#define v2965_16 vdupq_n_s16(2965)
#define v21025_16 vdupq_n_s16(21025)
#define v4587_16 vdupq_n_s16(4587)
#define v32526_16 vdupq_n_s16(32526)
#define v4438_16 vdupq_n_s16(4438)
#define v31470_16 vdupq_n_s16(31470)
#define v4049_16 vdupq_n_s16(4049)
#define v28711_16 vdupq_n_s16(28711)
#define v2863_16 vdupq_n_s16(2863)
#define v20301_16 vdupq_n_s16(20301)
#define v2_16 vdupq_n_s16(2)
#define v14_16 vdupq_n_s16(14)
#define v8_16 vdupq_n_s16(8)
#define v56_16 vdupq_n_s16(56)
#define v16_16 vdupq_n_s16(16)
#define v113_16 vdupq_n_s16(113)
#define v64_16 vdupq_n_s16(64)
#define v453_16 vdupq_n_s16(453)
#define v4033_16 vdupq_n_s16(4033)
#define v28598_16 vdupq_n_s16(28598)
#define v2128_16 vdupq_n_s16(2128)
#define v15089_16 vdupq_n_s16(15089)
//----------------Toom-4---------------------
#define v1155_16 vdupq_n_s16(1155)  
#define v8190_16 vdupq_n_s16(8190)  
#define v3595_16 vdupq_n_s16(3595)  
#define v25492_16 vdupq_n_s16(25492)
#define v770_16 vdupq_n_s16(770)    
#define v5460_16 vdupq_n_s16(5460)  
#define v4605_16 vdupq_n_s16(4605)  
#define v32654_16 vdupq_n_s16(32654)
#define v2464_16 vdupq_n_s16(2464)  
#define v17472_16 vdupq_n_s16(17472)
#define v2824_16 vdupq_n_s16(2824)  
#define v20025_16 vdupq_n_s16(20025)
#define v3055_16 vdupq_n_s16(3055)  
#define v21663_16 vdupq_n_s16(21663)
#define v1154_16 vdupq_n_s16(1154)
#define v8183_16 vdupq_n_s16(8183)
#define v1541_16 vdupq_n_s16(1541)
#define v10927_16 vdupq_n_s16(10927)
#define v2503_16 vdupq_n_s16(2503)
#define v17749_16 vdupq_n_s16(17749)
#define v2022_16 vdupq_n_s16(2022)
#define v14338_16 vdupq_n_s16(14338)
#define v513_16 vdupq_n_s16(513)
#define v3637_16 vdupq_n_s16(3637)
#define v289_16 vdupq_n_s16(289)
#define v2049_16 vdupq_n_s16(2049)
#define v2150_16 vdupq_n_s16(2150)
#define v15245_16 vdupq_n_s16(15245)
#define v4268_16 vdupq_n_s16(4268)
#define v30264_16 vdupq_n_s16(30264)
#define v3466_16 vdupq_n_s16(3466)
#define v24577_16 vdupq_n_s16(24577)
#define v2118_16 vdupq_n_s16(2118)
#define v15018_16 vdupq_n_s16(15018)
#define v4616_16 vdupq_n_s16(4616)
#define v32732_16 vdupq_n_s16(32732)
#define v1444_16 vdupq_n_s16(1444)
#define v10239_16 vdupq_n_s16(10239)
#define v3562_16 vdupq_n_s16(3562)
#define v25258_16 vdupq_n_s16(25258)
#define v4617_16 vdupq_n_s16(4617)
#define v32739_16 vdupq_n_s16(32739)
#define v4467_16 vdupq_n_s16(4467)
#define v31675_16 vdupq_n_s16(31675)
#define v1919_16 vdupq_n_s16(1919)
#define v13607_16 vdupq_n_s16(13607)


// ============================================================
/* Mont reduction */  
// ============================================================
#define v1821_16 vdupq_n_s16(1821)        //cR%q
#define v21841_16 vdupq_n_s16(21841)    //cR%q * (1/q) % R
#define v3217_16 vdupq_n_s16(3217)
#define v63381_16 vdupq_n_s16(63381)
#define v4270_16 vdupq_n_s16(4270)
#define v64998_16 vdupq_n_s16(64998)
#define v2100_16 vdupq_n_s16(2100)
#define v49156_16 vdupq_n_s16(49156)
#define v421_16 vdupq_n_s16(421)
#define v32761_16 vdupq_n_s16(32761)
#define v2521_16 vdupq_n_s16(2521)
#define v16381_16 vdupq_n_s16(16381)

static inline void cleanVec(int16x8_t *a, int len)
{
    for (int i = 0; i < len; i++)
    {
        a[i] = v0_16;
    }
}

// x mod 4621 where x < 32768
static inline int16x8_t barrett_fake(int16x8_t x)
{
    int16x8_t d = vqrdmulhq_s16(x, v7_16);
    return vmlsq_s16(x,d,v4621_16);
}

static inline int16x8_t barrett_fake_32x4(int32x4_t x, int32x4_t y)
{
    int16x8_t a, b;
    a = vuzp1q_s16((int16x8_t)x, (int16x8_t)y);
    b = vuzp1q_s16((int16x8_t)vqrdmulhq_s32(x, v464722_32x4), (int16x8_t)vqrdmulhq_s32(y, v464722_32x4));
    
    return vmlsq_s16(a, v4621_16, b);
}

static inline int16x8_t barrett_mla(int16x8_t a, int16x8_t b, int16x8_t c, int16x8_t cR_over2)
{
    int16x8_t t = vqrdmulhq_s16(b, cR_over2);
    int16x8_t d = vmlaq_s16(a,b,c);
    return vmlsq_s16(d,t,v4621_16);
}

static inline int16x8_t barrett_mla_4033(int16x8_t a, int16x8_t b)
{
    int16x8_t t = vqrdmulhq_s16(b, v28598_16);
    int16x8_t d = vmlaq_s16(a, b, v4033_16);
    return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2128(int16x8_t a, int16x8_t b)
{
    int16x8_t t = vqrdmulhq_s16(b, v15089_16);
    int16x8_t d = vmlaq_s16(a, b, v2128_16);
    return vmlsq_s16(d, t, v4621_16);
}


static inline int16x8_t barrett_mla_1763(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v12501_16);
         int16x8_t d = vmlaq_s16(a, b, v1763_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mls_1764(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v12508_16);
         int16x8_t d = vmlsq_s16(a, b, v1764_16);
         return vmlaq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_3443(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v24414_16);
         int16x8_t d = vmlaq_s16(a, b, v3443_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_511(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v3623_16);
         int16x8_t d = vmlaq_s16(a, b, v511_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_765(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v5424_16);
         int16x8_t d = vmlaq_s16(a, b, v765_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4575(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v32441_16);
         int16x8_t d = vmlaq_s16(a, b, v4575_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2448(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v17359_16);
         int16x8_t d = vmlaq_s16(a, b, v2448_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4336(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v30747_16);
         int16x8_t d = vmlaq_s16(a, b, v4336_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2270(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v16096_16);
         int16x8_t d = vmlaq_s16(a, b, v2270_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_3442(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v24407_16);
         int16x8_t d = vmlaq_s16(a, b, v3442_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_1531(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v10856_16);
         int16x8_t d = vmlaq_s16(a, b, v1531_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_1339(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v9494_16);
         int16x8_t d = vmlaq_s16(a, b, v1339_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v28_16);
         int16x8_t d = vmlaq_s16(a, b, v4_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_1435(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v10175_16);
         int16x8_t d = vmlaq_s16(a, b, v1435_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2040(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v14465_16);
         int16x8_t d = vmlaq_s16(a, b, v2040_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_861(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v6105_16);
         int16x8_t d = vmlaq_s16(a, b, v861_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_20(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v141_16);
         int16x8_t d = vmlaq_s16(a, b, v20_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_797(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v5651_16);
         int16x8_t d = vmlaq_s16(a, b, v797_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4049(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v28711_16);
         int16x8_t d = vmlaq_s16(a, b, v4049_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_1148(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v8140_16);
         int16x8_t d = vmlaq_s16(a, b, v1148_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_3252(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v23060_16);
         int16x8_t d = vmlaq_s16(a, b, v3252_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4586(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v32519_16);
         int16x8_t d = vmlaq_s16(a, b, v4586_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4304(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v30520_16);
         int16x8_t d = vmlaq_s16(a, b, v4304_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2965(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v21025_16);
         int16x8_t d = vmlaq_s16(a, b, v2965_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4587(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v32526_16);
         int16x8_t d = vmlaq_s16(a, b, v4587_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4438(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v31470_16);
         int16x8_t d = vmlaq_s16(a, b, v4438_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2863(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v20301_16);
         int16x8_t d = vmlaq_s16(a, b, v2863_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v14_16);
         int16x8_t d = vmlaq_s16(a, b, v2_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_8(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v56_16);
         int16x8_t d = vmlaq_s16(a, b, v8_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_16(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v113_16);
         int16x8_t d = vmlaq_s16(a, b, v16_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_64(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v453_16);
         int16x8_t d = vmlaq_s16(a, b, v64_16);
         return vmlsq_s16(d, t, v4621_16);
}
//----------------------Toom-4----------------------------
static inline int16x8_t barrett_mla_1155(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v8190_16);
         int16x8_t d = vmlaq_s16(a, b, v1155_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_3595(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v25492_16);
         int16x8_t d = vmlaq_s16(a, b, v3595_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4605(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v32654_16);
         int16x8_t d = vmlaq_s16(a, b, v4605_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2464(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v17472_16);
         int16x8_t d = vmlaq_s16(a, b, v2464_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2824(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v20025_16);
         int16x8_t d = vmlaq_s16(a, b, v2824_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_3055(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v21663_16);
         int16x8_t d = vmlaq_s16(a, b, v3055_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_1154(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v8183_16);
         int16x8_t d = vmlaq_s16(a, b, v1154_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_1541(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v10927_16);
         int16x8_t d = vmlaq_s16(a, b, v1541_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2503(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v17749_16);
         int16x8_t d = vmlaq_s16(a, b, v2503_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2022(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v14338_16);
         int16x8_t d = vmlaq_s16(a, b, v2022_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_513(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v3637_16);
         int16x8_t d = vmlaq_s16(a, b, v513_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_289(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v2049_16);
         int16x8_t d = vmlaq_s16(a, b, v289_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2150(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v15245_16);
         int16x8_t d = vmlaq_s16(a, b, v2150_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_3466(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v24577_16);
         int16x8_t d = vmlaq_s16(a, b, v3466_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_770(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v5460_16);
         int16x8_t d = vmlaq_s16(a, b, v770_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_2118(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v15018_16);
         int16x8_t d = vmlaq_s16(a, b, v2118_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4616(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v32732_16);
         int16x8_t d = vmlaq_s16(a, b, v4616_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_1444(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v10239_16);
         int16x8_t d = vmlaq_s16(a, b, v1444_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_3562(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v25258_16);
         int16x8_t d = vmlaq_s16(a, b, v3562_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4617(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v32739_16);
         int16x8_t d = vmlaq_s16(a, b, v4617_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4467(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v31675_16);
         int16x8_t d = vmlaq_s16(a, b, v4467_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_4268(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v30264_16);
         int16x8_t d = vmlaq_s16(a, b, v4268_16);
         return vmlsq_s16(d, t, v4621_16);
}

static inline int16x8_t barrett_mla_1919(int16x8_t a, int16x8_t b)
{
         int16x8_t t = vqrdmulhq_s16(b, v13607_16);
         int16x8_t d = vmlaq_s16(a, b, v1919_16);
         return vmlsq_s16(d, t, v4621_16);
}

//-------------------------------------------------------------
static inline int16x8_t montproduct(int16x8_t x, int16x8_t y)
{
    int16x8_t lo, hi, d, e;
    lo = vmulq_s16(x, y);
    hi = vqdmulhq_s16(x, y);
    d = vmulq_s16(lo, v36037_16);
    e = vqdmulhq_s16(d, v4621_16);
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct(int16x8_t a, int16x8_t b)
{
    int16x8_t lo, hi, d, e, xR;

    lo = vmulq_s16(a, b);
    hi = vqdmulhq_s16(a, b);
    d = vmulq_s16(lo, v36037_16);
    e = vqdmulhq_s16(d, v4621_16);

    xR = vhsubq_s16(hi, e);
    
    hi = vqdmulhq_s16(xR, v1951_16);
    d = vmulq_s16(xR, v53595_16);
    e = vqdmulhq_s16(d, v4621_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_3081(int16x8_t a)
{
        int16x8_t lo, hi, e;
        hi = vqdmulhq_s16(a, v1821_16);
        lo = vmulq_s16(a, v21841_16);     
        e = vqdmulhq_s16(lo, v4621_16);
        return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_152(int16x8_t a)
{
    int16x8_t lo, hi, e;
    hi = vqdmulhq_s16(a, v3217_16);
    lo = vmulq_s16(a, v63381_16);
    e = vqdmulhq_s16(lo, v4621_16);
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_38(int16x8_t a)
{
    int16x8_t lo, hi, e;
    hi = vqdmulhq_s16(a, v4270_16);
    lo = vmulq_s16(a, v64998_16);
    e = vqdmulhq_s16(lo, v4621_16);
    return vhsubq_s16(hi, e);
}
static inline int16x8_t innerProduct_1155(int16x8_t a)
{
    int16x8_t lo, hi, e;
    hi = vqdmulhq_s16(a, v2100_16);
    lo = vmulq_s16(a, v49156_16);
    e = vqdmulhq_s16(lo, v4621_16);
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_2311(int16x8_t a)
{
        int16x8_t lo, hi, e;
        hi = vqdmulhq_s16(a, v421_16);
        lo = vmulq_s16(a, v32761_16);
        e = vqdmulhq_s16(lo, v4621_16);
        return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_3466(int16x8_t a)
{
        int16x8_t lo, hi, e;
        hi = vqdmulhq_s16(a, v2521_16);
        lo = vmulq_s16(a, v16381_16);
        e = vqdmulhq_s16(lo, v4621_16);
        return vhsubq_s16(hi, e);
}

#endif