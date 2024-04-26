#ifndef _JUMP_NEON_H_
#define _JUMP_NEON_H_

#include <arm_neon.h>

#define jump64 jump64_16
#define jump63 jump63_16
#define jump62 jump62_16
#define jump62x jump62_16x

//jump16
int jump16(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump15(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump16x(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0);

//jump32
int jump32(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump31(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump31x(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);

//jump64
int jump64_16(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump63_16(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump62_16(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump62_16x(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);

int jump64_32(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump63_32(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump62_32(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);

//jump128
int jump127(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump124(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);

//jump256
int jump254(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump251(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);

//jump768
int jump762(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr);
int jump759(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *uvqr, int* f0);

//jump1521
int jump1521(int delta, int16x8_t *f, int16x8_t *g, int16x8_t *v, int* f0);
#endif 