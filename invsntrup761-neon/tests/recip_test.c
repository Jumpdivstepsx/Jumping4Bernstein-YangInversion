#include <arm_neon.h>
#include "crypto_core.h"
#include <stdio.h>
#include <stdlib.h>
#include <rdtsc.h>

#define TIMES 1000



int cmpfunc(const void *a, const void *b)
{
    return (*(int *)a - *(int *)b);
}

int main()
{
    #ifdef _MAC_
        #include <m1cycles.h>
        setup_rdtsc();
        printf("MAC!\n");
    #endif

    
    int t1[TIMES], t2[TIMES], tmp;
    unsigned char inbytes2[761] = {0}, outbytes[1523];

    for(int z = 0;z<TIMES;z++){
      for(int i = 0;i<761;i++){
        inbytes2[i] = (rand()%128-48)+'0';
      }
      tmp = rdtsc();
      crypto_core(outbytes, inbytes2, NULL, NULL);
      t1[z] = rdtsc()-tmp;
      
      tmp = rdtsc();
      crypto_core_jump(outbytes, inbytes2, NULL, NULL);
      t2[z] = rdtsc()-tmp;      
    }

    qsort(t1, TIMES, sizeof(int), cmpfunc);
    qsort(t2, TIMES, sizeof(int), cmpfunc);
    
    printf(" crypto_core_div   : %8d\n", t1[TIMES >> 1]);
    printf(" crypto_core_jump  : %8d\n\n\n", t2[TIMES >> 1]);
    return 0;
}
