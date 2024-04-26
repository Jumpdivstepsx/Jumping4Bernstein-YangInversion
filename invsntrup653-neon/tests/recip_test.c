#include "crypto_core.h"
//#include "params.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "rdtsc.h"

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

    int t1[TIMES], t2[TIMES], tmpT;
    unsigned char outbytes[1523], outbytes2[1523];
    unsigned char inbytes2[761] = {0};
    int check = 0;
    
    for(int z = 0;z<TIMES;z++){
      for(int i = 0;i<761;i++){
        inbytes2[i] = (rand()%128-48)+'0';
      }
      // ref test
      tmpT = rdtsc();
      crypto_core(outbytes, inbytes2, NULL, NULL);
      t1[z] = rdtsc()-tmpT;
      
      tmpT = rdtsc();
      crypto_core_jump(outbytes, inbytes2, NULL, NULL);
      t2[z] = rdtsc()-tmpT;
    }
    
    qsort(t1, TIMES, sizeof(int), cmpfunc);
    qsort(t2, TIMES, sizeof(int), cmpfunc);
    
    printf(" crypto_core_div   : %8d\n", t1[TIMES >> 1]);
    printf(" crypto_core_jump  : %8d\n\n\n", t2[TIMES >> 1]);
    return 0;
}