#ifndef _JUMP_NEON_H_
#define _JUMP_NEON_H_

#include <arm_neon.h>

//jump112
int jump110(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump95(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0);

//jump224
int jump220(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump205(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0);

//jump672
int jump660(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump645(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0);

//jump1305
int jump1305(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *v, int* f0);
#endif 