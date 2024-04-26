#ifndef _DVSTEPSX_NEON_H_
#define _DVSTEPSX_NEON_H_

#include <arm_neon.h>

int div55(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div40(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr, int* f0);


// 1521
int div1305(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr, int* res);
#endif