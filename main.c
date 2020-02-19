#include <stdio.h>
#include <stdlib.h>

#include "append.h"

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "\033[31mERROR\033[0m Need loop count\n");
        exit(EXIT_FAILURE);
    }
    int loop_count = atoi(argv[1]);
    char* string = (char*) malloc(sizeof(char));
    string[0] = '\0';
    for (int i = 0; i < loop_count; ++i) {
        string = append_free(string, 'a');
    }
    free(string);
}
