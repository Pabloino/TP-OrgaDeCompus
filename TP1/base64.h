#ifndef BASE64_H
#define BASE64_H

int base64_encode(int infd, int outfd);
int base64_decode(int infd, int outfd);

char* errmsg[4] = {
    "OK",
    "I/O Error",
    "Decoding Error: Wrong encoded message length.",
    "Decoding Error: Cannot decode symbol"
};

extern char base64chars[65];
extern unsigned char PADDING_CH;

#endif
