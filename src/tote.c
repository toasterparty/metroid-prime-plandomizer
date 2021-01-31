#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include "cJSON.h"
#include "randomprime.h"

#define DOORS_FILEPATH "doors.json"

#ifdef __cplusplus
extern "C" {
#endif

static size_t get_file_size(FILE* f_ptr)
{
    assert(f_ptr);
    fseek(f_ptr, 0, SEEK_END);
    size_t size = ftell(f_ptr);
    fseek(f_ptr, 0, SEEK_SET);
    return size;
}

/*
 * Reads the contents of the provided file as JSON. Returns pointer to
 * serialized json string in heap. Caller of this function is responsible
 * for freeing returned pointer.
 */
static char* read_doors_preset(const char* doors_filepath)
{
    FILE* doors_file = fopen(doors_filepath, "r");
    assert(doors_file != NULL && "Failed to open doors file for reading");
    
    size_t size = get_file_size(doors_file);
    char* doors_text = (char*) malloc(size+1);
    assert(doors_text && "Falid to allocate memory for doors file content");
    memset(doors_text, 0, size+1);

    assert(fread(doors_text, size, 1, doors_file) && "Failed to read doors file content");

    cJSON* doors_json = cJSON_Parse(doors_text);
    assert(doors_json && "Failed to parse door preset JSON");

    char* doors_parsed = cJSON_PrintUnformatted(doors_json);
    assert(doors_parsed && "Failed to serialize JSON");
    
    cJSON_Delete(doors_json);
    fclose(doors_file);

    return doors_parsed;
}

int main(void)
{
    char* doors_preset = read_doors_preset(DOORS_FILEPATH);
    printf("%s\n",doors_preset);
    free(doors_preset);
    return 0;
}

#ifdef __cplusplus
}
#endif
