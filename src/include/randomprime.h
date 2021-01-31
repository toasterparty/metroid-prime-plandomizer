/*
 * Defines functions availible via randomprime's outward facing C API
 */
#ifndef _RANDOMPRIME_H_
#define _RANDOMPRIME_H_

#ifdef __cplusplus
extern "C" {
#endif

typedef void(*randomprime_callback_t)(void*, const char*);
void randomprime_patch_iso(const char* config_json, void *cb_data, randomprime_callback_t cb);

#ifdef __cplusplus
}
#endif

#endif
