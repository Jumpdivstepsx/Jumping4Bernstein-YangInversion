#ifndef crypto_core_invsntrup761_H
#define crypto_core_invsntrup761_H

#define crypto_core_invsntrup761_jumpdivsteps_constbranchindex_OUTPUTBYTES 1523
#define crypto_core_invsntrup761_jumpdivsteps_constbranchindex_INPUTBYTES 761
#define crypto_core_invsntrup761_jumpdivsteps_constbranchindex_KEYBYTES 0
#define crypto_core_invsntrup761_jumpdivsteps_constbranchindex_CONSTBYTES 0


#ifdef __cplusplus
extern "C" {
#endif
extern int crypto_core_invsntrup761_jumpdivsteps_constbranchindex(unsigned char *,const unsigned char *,const unsigned char *,const unsigned char *);
#ifdef __cplusplus
}
#endif

#define crypto_core_invsntrup761 crypto_core_invsntrup761_jumpdivsteps_constbranchindex
#define crypto_core_invsntrup761_OUTPUTBYTES crypto_core_invsntrup761_jumpdivsteps_constbranchindex_OUTPUTBYTES
#define crypto_core_invsntrup761_INPUTBYTES crypto_core_invsntrup761_jumpdivsteps_constbranchindex_INPUTBYTES
#define crypto_core_invsntrup761_KEYBYTES crypto_core_invsntrup761_jumpdivsteps_constbranchindex_KEYBYTES
#define crypto_core_invsntrup761_CONSTBYTES crypto_core_invsntrup761_jumpdivsteps_constbranchindex_CONSTBYTES
#define crypto_core_invsntrup761_IMPLEMENTATION "crypto_core/invsntrup761/jumpdivsteps"
#ifndef crypto_core_invsntrup761_jumpdivsteps_constbranchindex_VERSION
#define crypto_core_invsntrup761_jumpdivsteps_constbranchindex_VERSION "-"
#endif
#define crypto_core_invsntrup761_VERSION crypto_core_invsntrup761_jumpdivsteps_constbranchindex_VERSION

#endif
