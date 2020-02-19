#include <stdlib.h>
#include <string.h>
#include "append.h"

char* append(char* base, char c_to_append) {
    size_t len = strlen(base);
    char* new_string = (char*) malloc(len + 2);
    strcpy(new_string, base);
    new_string[len] = c_to_append;
    new_string[len + 1] = '\0';
    return new_string;
}

char* append_free(char* base, char c_to_append) {
    char* new_string = append(base, c_to_append);
    free(base);
    return new_string;
}
