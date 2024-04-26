#ifndef _MACROS_NEON_H_
#define _MACROS_NEON_H_

#include <arm_neon.h>

#define v0 vdupq_n_s16(0)
#define v0_32x4 vdupq_n_s32(0)
#define v01 vsetq_lane_s16(1, v0, 0)
#define v7_16 vdupq_n_s16(7)
#define v4591_16 vdupq_n_s16(4591)
#define v15631_16 vdupq_n_s16(15631)
#define v4158_16 vdupq_n_s16(-433)
#define v47522_16 vdupq_n_s16(-18015)
#define v311_t vdupq_n_s16(311)
#define v2220_t vdupq_n_s16(2220)
#define v2957_t vdupq_n_s16(2957)
#define v21105_t vdupq_n_s16(21105)
#define v3164_t vdupq_n_s16(3164)
#define v22583_t vdupq_n_s16(22583)
#define v310_t vdupq_n_s16(310)
#define v2213_t vdupq_n_s16(2213)
#define v467759_32x4 vdupq_n_s32(467759)

// Toom 64
#define v1230_t vdupq_n_s16(1230)
#define v8779_t vdupq_n_s16(8779)
#define v3363_t vdupq_n_s16(3363)
#define v24003_t vdupq_n_s16(24003)
#define v2115_t vdupq_n_s16(2115)
#define v15096_t vdupq_n_s16(15096)
#define v57_t vdupq_n_s16(57)
#define v407_t vdupq_n_s16(407)
#define v4532_t vdupq_n_s16(4532)
#define v32347_t vdupq_n_s16(32347)
#define v2474_t vdupq_n_s16(2474)
#define v17658_t vdupq_n_s16(17658)
#define v2910_t vdupq_n_s16(2910)
#define v20770_t vdupq_n_s16(20770)
#define v1087_t vdupq_n_s16(1087)
#define v7758_t vdupq_n_s16(7758)
#define v1029_t vdupq_n_s16(1029)
#define v7344_t vdupq_n_s16(7344)
#define v3562_t vdupq_n_s16(3562)
#define v25424_t vdupq_n_s16(25424)
#define v2749_t vdupq_n_s16(2749)
#define v19621_t vdupq_n_s16(19621)
#define v2662_t vdupq_n_s16(2662)
#define v19000_t vdupq_n_s16(19000)
#define v2207_t vdupq_n_s16(2207)
#define v15752_t vdupq_n_s16(15752)
#define v3627_t vdupq_n_s16(3627)
#define v25888_t vdupq_n_s16(25888)
#define v3085_t vdupq_n_s16(3085)
#define v22019_t vdupq_n_s16(22019)
#define v3204_t vdupq_n_s16(3204)
#define v22868_t vdupq_n_s16(22868)
#define v4447_t vdupq_n_s16(4447)
#define v31740_t vdupq_n_s16(31740)
#define v686_t vdupq_n_s16(686)
#define v4896_t vdupq_n_s16(4896)
#define v310_t vdupq_n_s16(310)
#define v2213_t vdupq_n_s16(2213)
#define v311_t vdupq_n_s16(311)
#define v2220_t vdupq_n_s16(2220)
#define v3164_t vdupq_n_s16(3164)
#define v22583_t vdupq_n_s16(22583)
#define v2957_t vdupq_n_s16(2957)
#define v21105_t vdupq_n_s16(21105)
#define v3443_t vdupq_n_s16(3443)
#define v24574_t vdupq_n_s16(24574)
#define v511_t vdupq_n_s16(511)
#define v3647_t vdupq_n_s16(3647)
#define v765_t vdupq_n_s16(765)
#define v5460_t vdupq_n_s16(5460)
#define v4575_t vdupq_n_s16(4575)
#define v32653_t vdupq_n_s16(32653)
#define v2448_t vdupq_n_s16(2448)
#define v17472_t vdupq_n_s16(17472)
#define v4336_t vdupq_n_s16(4336)
#define v30947_t vdupq_n_s16(30947)
#define v2270_t vdupq_n_s16(2270)
#define v16201_t vdupq_n_s16(16201)
#define v3442_t vdupq_n_s16(3442)
#define v24567_t vdupq_n_s16(24567)
#define v1531_t vdupq_n_s16(1531)
#define v10927_t vdupq_n_s16(10927)
#define v1339_t vdupq_n_s16(1339)
#define v9557_t vdupq_n_s16(9557)
#define v4_t vdupq_n_s16(4)
#define v28_t vdupq_n_s16(28)
#define v1435_t vdupq_n_s16(1435)
#define v10242_t vdupq_n_s16(10242)
#define v2040_t vdupq_n_s16(2040)
#define v14560_t vdupq_n_s16(14560)
#define v861_t vdupq_n_s16(861)
#define v6145_t vdupq_n_s16(6145)
#define v20_t vdupq_n_s16(20)
#define v142_t vdupq_n_s16(142)
#define v0_t vdupq_n_s16(0)
#define v0_t vdupq_n_s16(0)
#define v797_t vdupq_n_s16(797)
#define v5688_t vdupq_n_s16(5688)
#define v4049_t vdupq_n_s16(4049)
#define v28899_t vdupq_n_s16(28899)
#define v1148_t vdupq_n_s16(1148)
#define v8193_t vdupq_n_s16(8193)
#define v765_t vdupq_n_s16(765)
#define v5460_t vdupq_n_s16(5460)
#define v3252_t vdupq_n_s16(3252)
#define v23210_t vdupq_n_s16(23210)
#define v4586_t vdupq_n_s16(4586)
#define v32732_t vdupq_n_s16(32732)
#define v4304_t vdupq_n_s16(4304)
#define v30719_t vdupq_n_s16(30719)
#define v2965_t vdupq_n_s16(2965)
#define v21162_t vdupq_n_s16(21162)
#define v4587_t vdupq_n_s16(4587)
#define v32739_t vdupq_n_s16(32739)
#define v4438_t vdupq_n_s16(4438)
#define v31675_t vdupq_n_s16(31675)
#define v2863_t vdupq_n_s16(2863)
#define v20434_t vdupq_n_s16(20434)
#define v2_t vdupq_n_s16(2)
#define v14_t vdupq_n_s16(14)
#define v8_t vdupq_n_s16(8)
#define v57_t vdupq_n_s16(57)
#define v16_t vdupq_n_s16(16)
#define v114_t vdupq_n_s16(114)
#define v64_t vdupq_n_s16(64)
#define v456_t vdupq_n_s16(456)
#define v16388_t vdupq_n_s16(16388)
#define v2296_t vdupq_n_s16(2296)

// Schonhage 64
#define v61440_16 vdupq_n_s16(-4096)
#define v4096_16 vdupq_n_s16(4096)

// schonhage 128
#define v2048_16 vdupq_n_s16(2048)
#define v30720_16 vdupq_n_s16(30720)

// Bruun 128
#define v1558_16 vdupq_n_s16(1558)
#define v39242_16 vdupq_n_s16(-26294)
#define v3033_16 vdupq_n_s16(3033)
#define v26295_16 vdupq_n_s16(26295)
#define v4544_16 vdupq_n_s16(4544)
#define v51776_16 vdupq_n_s16(-13760)
#define v47_16 vdupq_n_s16(47)
#define v13761_16 vdupq_n_s16(13761)
#define v4489_16 vdupq_n_s16(4489)
#define v44039_16 vdupq_n_s16(-21497)
#define v102_16 vdupq_n_s16(102)
#define v21498_16 vdupq_n_s16(21498)
#define v2679_16 vdupq_n_s16(2679)
#define v63481_16 vdupq_n_s16(-2055)
#define v1912_16 vdupq_n_s16(1912)
#define v2056_16 vdupq_n_s16(2056)
#define v4211_16 vdupq_n_s16(4211)
#define v23997_16 vdupq_n_s16(23997)
#define v3676_16 vdupq_n_s16(3676)
#define v50020_16 vdupq_n_s16(-15516)
#define v655_16 vdupq_n_s16(655)
#define v14689_16 vdupq_n_s16(14689)
#define v4536_16 vdupq_n_s16(4536)
#define v57800_16 vdupq_n_s16(-7736)
#define v55_16 vdupq_n_s16(55)
#define v7737_16 vdupq_n_s16(7737)
#define v3470_16 vdupq_n_s16(3470)
#define v41298_16 vdupq_n_s16(-24238)
#define v1121_16 vdupq_n_s16(1121)
#define v24239_16 vdupq_n_s16(24239)
#define v3135_16 vdupq_n_s16(3135)
#define v47793_16 vdupq_n_s16(-17743)
#define v1456_16 vdupq_n_s16(1456)
#define v17744_16 vdupq_n_s16(17744)
#define v308_16 vdupq_n_s16(308)
#define v30220_16 vdupq_n_s16(30220)
#define v4331_16 vdupq_n_s16(4331)
#define v64709_16 vdupq_n_s16(-827)
#define v2022_16 vdupq_n_s16(2022)
#define v17530_16 vdupq_n_s16(17530)
#define v1865_16 vdupq_n_s16(1865)
#define v53831_16 vdupq_n_s16(-11705)
#define v2726_16 vdupq_n_s16(2726)
#define v11706_16 vdupq_n_s16(11706)
#define v3021_16 vdupq_n_s16(3021)
#define v35331_16 vdupq_n_s16(-30205)
#define v502_16 vdupq_n_s16(502)
#define v47978_16 vdupq_n_s16(-17558)
#define v3831_16 vdupq_n_s16(3831)
#define v47993_16 vdupq_n_s16(-17543)



//Good-Thomas
#define v985_16 vdupq_n_s16(985)
#define v61111_16 vdupq_n_s16(-4425)

#define v2344_16 vdupq_n_s16(2344)
#define v4440_16 vdupq_n_s16(4440)

#define v1951_16 vdupq_n_s16(1951)
#define v21841_16 vdupq_n_s16(21841)

#define v3842_16 vdupq_n_s16(3842)
#define v23326_16 vdupq_n_s16(23326)

#define v3389_16 vdupq_n_s16(3389)
#define v20371_16 vdupq_n_s16(20371)

static inline void cleanVec(int16x8_t *a, int len)
{
    for (int i = 0; i < len; i++)
    {
        a[i] = v0;
    }
}

// mod 4591
static inline int16x8_t barrett_fake(int16x8_t x)
{
    int16x8_t d = vqrdmulhq_s16(x, v7_16);
    return vmlsq_s16(x,d,v4591_16);
}

static inline int16x8_t barrett_fake_32x4(int32x4_t x, int32x4_t y)
{
    int16x8_t a, b;
    a = vuzp1q_s16((int16x8_t)x, (int16x8_t)y);
    b = vuzp1q_s16((int16x8_t)vqrdmulhq_s32(x, v467759_32x4), (int16x8_t)vqrdmulhq_s32(y, v467759_32x4));
    
    return vmlsq_s16(a, v4591_16, b);
}

static inline int16x8_t montproduct(int16x8_t x, int16x8_t y)
{
    int16x8_t lo, hi, d, e;
    lo = vmulq_s16(x, y);
    hi = vqdmulhq_s16(x, y);
    d = vmulq_s16(lo, v15631_16);
    e = vqdmulhq_s16(d, v4591_16);
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct(int16x8_t a, int16x8_t b)
{
    int16x8_t lo, hi, d, e, xR;

    lo = vmulq_s16(a, v15631_16);
    hi = vqdmulhq_s16(a, b);
    d = vmulq_s16(lo, b);
    e = vqdmulhq_s16(d, v4591_16);

    xR = vhsubq_s16(hi, e);  //ab_overR
    
    hi = vqdmulhq_s16(xR, v4158_16);
    d = vmulq_s16(xR, v47522_16);
    e = vqdmulhq_s16(d, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t barrett_mla_310(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v2213_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v310_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mls_311(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v2220_t);
        int16x8_t d = vmlsq_laneq_s16(a,b,v311_t,0);
        return vmlaq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_2957(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v21105_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v2957_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t innerProduct_3061(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v1951_16);
    lo = vmulq_s16(a, v21841_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t barrett_mla_3164(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v22583_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v3164_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

// Schonhage 64
static inline int16x8_t innerProduct_287(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v4096_16);
    lo = vmulq_s16(a, v61440_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

// Toom 64
static inline int16x8_t barrett_mla_8(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v57_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v8_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_2(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v14_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v2_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_64(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v456_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v64_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_16(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v114_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v16_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_3443(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v24574_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v3443_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_511(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v3647_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v511_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_765(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v5460_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v765_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_4575(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v32653_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v4575_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_2448(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v17472_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v2448_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_4336(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v30947_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v4336_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_2270(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v16201_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v2270_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_3442(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v24567_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v3442_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_1531(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v10927_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v1531_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_1339(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v9557_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v1339_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_4(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v28_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v4_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_1435(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v10242_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v1435_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_2040(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v14560_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v2040_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_861(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v6145_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v861_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_20(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v142_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v20_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_797(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v5688_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v797_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_4049(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v28899_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v4049_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_1148(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v8193_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v1148_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_4586(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v32732_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v4586_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_3252(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v23210_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v3252_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_4304(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v30719_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v4304_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_2965(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v21162_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v2965_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_4587(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v32739_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v4587_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_4438(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v31675_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v4438_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_2863(int16x8_t a, int16x8_t b)
{
                int16x8_t t = vqrdmulhq_s16(b, v20434_t);
                int16x8_t d = vmlaq_laneq_s16(a,b,v2863_t,0);
                return vmlsq_laneq_s16(d,t,v4591_16,0);
}

// schonhage 128
static inline int16x8_t innerProduct_2439(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v2048_16);
    lo = vmulq_s16(a, v30720_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

// Bruun 128
static inline int16x8_t innerProduct_1229(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v3831_16);
    lo = vmulq_s16(a, v47993_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_1230(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v502_16);
    lo = vmulq_s16(a, v47978_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_2116(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v3021_16);
    lo = vmulq_s16(a, v35331_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_58(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v4331_16);
    lo = vmulq_s16(a, v64709_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_3363(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v2022_16);
    lo = vmulq_s16(a, v17530_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_820(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v1865_16);
    lo = vmulq_s16(a, v53831_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_3771(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v2726_16);
    lo = vmulq_s16(a, v11706_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_1243(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v3135_16);
    lo = vmulq_s16(a, v47793_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_3348(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v1456_16);
    lo = vmulq_s16(a, v17744_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_2474(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v308_16);
    lo = vmulq_s16(a, v30220_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_1698(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v3470_16);
    lo = vmulq_s16(a, v41298_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_2893(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v1121_16);
    lo = vmulq_s16(a, v24239_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_542(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v4536_16);
    lo = vmulq_s16(a, v57800_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_4049(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v55_16);
    lo = vmulq_s16(a, v7737_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_3562(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v655_16);
    lo = vmulq_s16(a, v14689_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}
static inline int16x8_t innerProduct_2910(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v4211_16);
    lo = vmulq_s16(a, v23997_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}
static inline int16x8_t innerProduct_1087(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v3676_16);
    lo = vmulq_s16(a, v50020_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_144(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v2679_16);
    lo = vmulq_s16(a, v63481_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_4447(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v1912_16);
    lo = vmulq_s16(a, v2056_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_1506(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v4489_16);
    lo = vmulq_s16(a, v44039_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_3085(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v102_16);
    lo = vmulq_s16(a, v21498_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_964(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v4544_16);
    lo = vmulq_s16(a, v51776_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_3627(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v47_16);
    lo = vmulq_s16(a, v13761_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}
static inline int16x8_t innerProduct_1842(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v1558_16);
    lo = vmulq_s16(a, v39242_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t innerProduct_2749(int16x8_t a)
{
    int16x8_t lo, hi, e;

    hi = vqdmulhq_s16(a, v3033_16);
    lo = vmulq_s16(a, v26295_16);
    e = vqdmulhq_s16(lo, v4591_16);
    
    return vhsubq_s16(hi, e);
}

static inline int16x8_t barrett_mla_1230(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v8779_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v1230_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_3363(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v24003_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v3363_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_2115(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v15096_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v2115_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_4447(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v31740_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v4447_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_686(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v4896_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v686_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_3085(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v22019_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v3085_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_3204(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v22868_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v3204_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_2207(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v15752_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v2207_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_3627(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v25888_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v3627_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_2749(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v19621_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v2749_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_2662(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v19000_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v2662_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_3562(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v25424_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v3562_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_1087(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v7758_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v1087_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_2474(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v17658_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v2474_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mla_57(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v407_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v57_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_4532(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v32347_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v4532_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mla_2910(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v20770_t);
        int16x8_t d = vmlaq_laneq_s16(a,b,v2910_t,0);
        return vmlsq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mls_1087(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v7758_t);
        int16x8_t d = vmlsq_laneq_s16(a,b,v1087_t,0);
        return vmlaq_laneq_s16(d,t,v4591_16,0);
}

static inline int16x8_t barrett_mls_1029(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v7344_t);
        int16x8_t d = vmlsq_laneq_s16(a,b,v1029_t,0);
        return vmlaq_laneq_s16(d,t,v4591_16,0);
}
static inline int16x8_t barrett_mls_2910(int16x8_t a, int16x8_t b)
{
        int16x8_t t = vqrdmulhq_s16(b, v20770_t);
        int16x8_t d = vmlsq_laneq_s16(a,b,v2910_t,0);
        return vmlaq_laneq_s16(d,t,v4591_16,0);
}

#endif