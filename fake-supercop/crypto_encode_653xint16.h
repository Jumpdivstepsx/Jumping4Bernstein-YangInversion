#ifndef crypto_encode_653xint16_H
#define crypto_encode_653xint16_H

#define crypto_encode_653xint16_ref_constbranchindex_STRBYTES 1306
#define crypto_encode_653xint16_ref_constbranchindex_ITEMS 653
#define crypto_encode_653xint16_ref_constbranchindex_ITEMBYTES 2

#include "string.h"

#ifdef __cplusplus
extern "C" {
#endif
//extern void crypto_encode_761xint16_ref_constbranchindex(unsigned char *,const void *);
static inline void crypto_encode_653xint16_ref_constbranchindex(unsigned char * output,const void * input)
{
  memcpy(output, input, 1306);
}
#ifdef __cplusplus
}
#endif

#define crypto_encode_653xint16 crypto_encode_653xint16_ref_constbranchindex
#define crypto_encode_653xint16_STRBYTES crypto_encode_653xint16_ref_constbranchindex_STRBYTES
#define crypto_encode_653xint16_ITEMBYTES crypto_encode_653xint16_ref_constbranchindex_ITEMBYTES
#define crypto_encode_653xint16_ITEMS crypto_encode_653xint16_ref_constbranchindex_ITEMS
#define crypto_encode_653xint16_IMPLEMENTATION "crypto_encode/653xint16/ref"
#ifndef crypto_encode_653xint16_ref_constbranchindex_VERSION
#define crypto_encode_653xint16_ref_constbranchindex_VERSION "-"
#endif
#define crypto_encode_653xint16_VERSION crypto_encode_653xint16_ref_constbranchindex_VERSION

#endif
