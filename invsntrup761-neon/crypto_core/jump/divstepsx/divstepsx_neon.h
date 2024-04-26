#ifndef _DVSTEPSX_NEON_H_
#define _DVSTEPSX_NEON_H_

#include <arm_neon.h>

int div7(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div8(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div8x(int delta, int16x8_t* fi, int16x8_t* gi, int16x8_t *uvqr, int* f0);

int div15(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div16(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);

int div31(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div32(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);

int div62(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div63(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div64(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);

int div124(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div127(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);

int div251(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
int div254(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);

int div1521(int delta, int16x8_t *fi, int16x8_t *gi, int16x8_t *uvqr);
#endif