#include <arm_neon.h>
#include "crypto_core.h"
#include "macros_neon.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TIMES 1000
#define p 761

static inline uint64_t rdtsc()
{
    uint64_t val;
    __asm__ __volatile__("mrs %0, PMCCNTR_EL0" : "=r"(val));
    return val;
}

static inline int8_t F3_freeze(int16_t x)
{
    return x-3*((10923*x+16384)>>15);
}

int crypto_core_ans(unsigned char *outbytes,const unsigned char *inbytes)
{
  int8_t *out = (void *) outbytes;
  int8_t *in = (void *) inbytes;
  int8_t f[p+1],g[p+1],v[p+1],r[p+1];
  int i,loop,delta;
  int sign,swap,t;
  
  for (i = 0;i < p+1;++i) v[i] = 0;
  for (i = 0;i < p+1;++i) r[i] = 0;
  r[0] = 1;
  for (i = 0;i < p;++i) f[i] = 0;
  f[0] = 1; f[p-1] = f[p] = -1;
  for (i = 0;i < p;++i) {
    int8_t i1 = in[i]&1;
    g[p-1-i] = i1-(in[i]&(i1<<1));
  }
  g[p] = 0;

  delta = 1; 

  for (loop = 0;loop < 2*p-1;++loop) {
    for (i = p;i > 0;--i) v[i] = v[i-1];
    v[0] = 0;
    
    sign = -g[0]*f[0];
    swap = int16_negative_mask(-delta) & int16_nonzero_mask(g[0]);
    delta ^= swap&(delta^-delta);
    delta += 1;
    
    for (i = 0;i < p+1;++i) {
      t = swap&(f[i]^g[i]); f[i] ^= t; g[i] ^= t;
      t = swap&(v[i]^r[i]); v[i] ^= t; r[i] ^= t;
    }
  
    for (i = 0;i < p+1;++i) g[i] = F3_freeze(g[i]+sign*f[i]);
    for (i = 0;i < p+1;++i) r[i] = F3_freeze(r[i]+sign*v[i]);

    for (i = 0;i < p;++i) g[i] = g[i+1];
    g[p] = 0;
  }
  
  sign = f[0];
  for (i = 0;i < p;++i) out[i] = sign*v[p-1-i];
  
  out[p] = int16_nonzero_mask(delta);
  return 0;
}

void rand3(unsigned char *res, unsigned char *res2, int len){
    int tmp;
    for (int i = 0; i < len; i++)
    {
        tmp = rand()%3;
        if (tmp==0){
            res[i] = 0;
            res2[i] = 0;
        }else if (tmp == 1){
            res[i] = 1;
            res2[i] = 1;
        }else{
            res[i] = 255;
            res2[i] = 255;
        }
    }
}

int cmpfunc(const void *a, const void *b){
    return (*(int *)a - *(int *)b);
}

int main(){
    unsigned char inbytes[p+1] = {0}, outbytes[p+1] = {0}, ans[p+1] = {0};
    unsigned char in[p+1] = {0}, out[p+1] = {0};
    int check = 0, tmp, rd_ans, rd_bit, rd_jump, delta;
    int t1[TIMES], t2[TIMES], t3[TIMES];
    
    
    for (int z=0; z<TIMES; z++){


        rand3(inbytes, in, 761);
        tmp = rdtsc();
        rd_ans = crypto_core_ans(ans, inbytes);
        t1[z] = rdtsc() - tmp;

        //jump
        tmp = rdtsc();
        rd_jump = crypto_core_jump(out, in, NULL, NULL);
        t3[z] = rdtsc() - tmp;

        //div
        tmp = rdtsc();
        rd_bit = crypto_core(outbytes, inbytes, NULL, NULL);
        t2[z] = rdtsc() - tmp;

        //check
        for (int i=0; i<762; i++){
            if (outbytes[i]!=ans[i] || out[i]!=ans[i]){
                check = 1;
            }
        }
    }

    if (!check) printf("success!\n");
    qsort(t1, TIMES, sizeof(int), cmpfunc);
    qsort(t2, TIMES, sizeof(int), cmpfunc);
    qsort(t3, TIMES, sizeof(int), cmpfunc);
    printf("\nSupercop_inv3          : %8d\n", t1[TIMES >> 1]);
    printf("\nDivsteps_inv3          : %8d\n", t2[TIMES >> 1]);
    printf("\nJump_inv3              : %8d\n\n", t3[TIMES >> 1]);
    return 0;
}