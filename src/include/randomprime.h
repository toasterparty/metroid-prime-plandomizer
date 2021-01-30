/*
 * Defines functions availible via randomprime's outward facing C API
 */
#ifndef _RANDOMPRIME_H_
#define _RANDOMPRIME_H_

typedef void(*callback_t)(void*, const char*);
void randomprime_patch_iso(const char* config_json, void *cb_data, callback_t cb);

#endif
