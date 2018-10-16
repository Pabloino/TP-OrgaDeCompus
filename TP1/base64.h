#ifndef BASE64_H
#define BASE64_H

int base64_encode(int infd, int outfd);
int base64_decode(int infd, int outfd);

char* errmsg[4] = {
    "OK",
    "I/O Error",
    "Error decodificando: tamanio de codificado incorrecto.",
    "Error de Decodificacion: no se puede decodificar #"
};

extern char base64chars[65];
extern unsigned char PADDING_CH;

#endif
