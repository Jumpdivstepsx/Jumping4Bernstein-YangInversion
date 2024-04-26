#include "jump_neon.h"
#include "divstepsx_neon.h"
#include "macros_neon.h"
#include <arm_neon.h>
#include <string.h>
#include <stdio.h>

#define p 653
#define q 4621

#define q14 4 /* closest integer to 2^14/q */
#define q18 57 /* closest integer to 2^18/q */
#define q27 29045 /* closest integer to 2^27/q */
#define q31 464722 /* floor(2^31/q) */

#include "crypto_core.h"

/* ----- masks */

/* return -1 if x!=0; else return 0 */
static int int16_nonzero_mask(int16_t x)
{
  uint16_t u = x; /* 0, else 1...65535 */
  uint32_t v = u; /* 0, else 1...65535 */
  v = -v; /* 0, else 2^32-65535...2^32-1 */
  v >>= 31; /* 0, else 1 */
  return -v; /* 0, else -1 */
}

/* return -1 if x<0; otherwise return 0 */
static int int16_negative_mask(int16_t x)
{
  uint16_t u = x;
  u >>= 15;
  return -(int) u;
}

static int16_t Fq_freeze(int32_t x)
{
  x -= q*((q18*x)>>18);
  x -= q*((q27*x+67108864)>>27);
  return x;
}

//mod 4621
static int16_t Fq_bigfreeze(int32_t x)
{
  x -= q*((q14*x)>>14);
  x -= q*((q18*x)>>18);
  x -= q*((q27*x+67108864)>>27);
  x -= q*((q27*x+67108864)>>27);
  return x;
}

/* nonnegative e */
static int16_t Fq_pow(int16_t a,int16_t e)
{
  if (e == 0) return 1;
  if (e == 1) return a;
  if (e & 1) return Fq_bigfreeze(a*(int32_t)Fq_pow(a,e-1));
  a = Fq_bigfreeze(a*(int32_t)a);
  return Fq_pow(a,e>>1);
}

static int16_t Fq_recip(int16_t a)
{ 
  return Fq_pow(a,q-2);
}

/* ----- polynomials mod q */
/* out = 1/(3*in) in Rq */
/* outbytes[2*p] is 0 if recip succeeded; else -1 */
int crypto_core_jump(unsigned char *outbytes,const unsigned char *inbytes,const unsigned char *kbytes,const unsigned char *cbytes)
{

  int8_t *in = (void *) inbytes;
  int16x8_t out[84],f[84],g[84],v[84];
  int delta = 1, res;
  cleanVec(out, 84);
  cleanVec(f, 84);
  cleanVec(g, 84);
  cleanVec(v, 84);
  f[0][0] = 1; f[81][4] = f[81][5] = -1;  
  for (int i = 0;i<653;++i) g[i/8][i%8] = in[652-i];

  // 1305
  delta = jump1305(delta, f, g, v, &res);
  int16x8_t scale = vdupq_n_s16(Fq_recip(Fq_freeze(res)));  
  int16x8_t mask3 = innerProduct(vdupq_n_s16(-1540), scale);
  for(int i = 0;i<84;i++) v[i] = innerProduct(v[i], mask3);
  for(int i = 0;i<p;++i) out[i/8][i%8] = Fq_bigfreeze(v[((p-i)/8)][(p-i)%8]);
  
  memcpy(outbytes, out, 1306);
  outbytes[2*p] = int16_nonzero_mask(delta);
  return 0;
}