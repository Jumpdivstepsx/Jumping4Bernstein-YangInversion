#include <arm_neon.h>
#include "polymul_neon.h"
#include "macros_neon.h"
#include "string.h"

// toom 56x56
void polymul_56x56_Toom(int16x8_t *c, int16x8_t *a, int16x8_t *b)
{
    int16x8_t aIn[14], bIn[14];
    int16x8x4_t cIn[7];
    //Input
    polymul_56x56_Toom_InputTransform(aIn, a);
    polymul_56x56_Toom_InputTransform(bIn, b);
    //Mul
    polymul_56x56_Toom_Mul(cIn, aIn, bIn);
    //Mul + Out
    polymul_56x56_Toom_OutputTransform(c, cIn);
}