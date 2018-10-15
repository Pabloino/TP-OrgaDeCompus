#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include "parser.h"
#include "base64.h"
unsigned char PADDING_CH = '=';

select_t choice = { STDIN_FILENO, STDOUT_FILENO, false };

char base64chars[65] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

int main(int argc, char** argv) {

    parseAnswer(argc, argv, &choice);

    int base64_output;

    if (choice.decode) {
        base64_output = base64_decode(
            choice.inputFile,
            choice.outputFile
        );
    } else {
        base64_output = base64_encode(
            choice.inputFile,
            choice.outputFile
        );
    }

    if (base64_output) {
        fprintf(stderr, "%s", errmsg[base64_output]);
    }

    close_files(&choice);
    return 0;
}
