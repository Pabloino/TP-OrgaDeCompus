#ifndef BASE64_H
#define BASE64_H

int base64_encode(int infd, int outfd);
int base64_decode(int infd, int outfd);

char* ERROR_MSG[4] = {
    "OK",
    "I/O Error",
    "Decoding Error: Wrong encoded message length.",
    "Decoding Error: Cannot decode symbol"
};

extern char encode_table[64];
extern char PADDING_SYMBOL;

#endif
