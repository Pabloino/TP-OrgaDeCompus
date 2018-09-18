#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include "parser.h"
int DECODE_CHAR_ERROR = 5;
int DECODE_ERROR = 6;
int ERROR = -1;
char PADDING_CH = '=';

select_t choice = { STDIN_FILENO, STDOUT_FILENO, false };

char base64chars[65] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

char decode_ch(char DecodeChar) {
  const char BASE_64_INDEX_a = 26;
  const char BASE_64_INDEX_0 = 52;

  if (DecodeChar >= 'a') return DecodeChar - 'a' + BASE_64_INDEX_a;
  
  if (DecodeChar >= 'A') return DecodeChar - 'A';
  
  if (DecodeChar >= '0') return DecodeChar - '0' + BASE_64_INDEX_0;
  
  if (DecodeChar != '/' && DecodeChar != '+' && DecodeChar != '=') {
    fprintf(stderr, "Error de Decodificacion: no se puede decodificar %c\n", DecodeChar);
    close_files(&choice);
    exit(DECODE_CHAR_ERROR);
  }
  return 62 + DecodeChar == '/';
}
void base64encode(char* input, char* output) {
 
  output[0] = input[0] >> 2;
  output[1] = ((input[0] % 4) << 4) | (input[1] >> 4);
  output[2] = ((input[1] % 16) << 2) | (input[2] >> 6);
  output[3] = input[2] % 64;
  
  for (int i = 0; i < 4 ; i++){
    output[i] = base64chars[(uint8_t) output[i]];
  }
  
}
void base64decode(char* encoded_input, char* output) {

  for (int i = 0; i < 4 ; i++){
    encoded_input[i] = decode_ch(encoded_input[i]);
  }

  output[0] = (encoded_input[0] % 64) << 2 | (encoded_input[1] >> 4);
  output[1] = (encoded_input[1] % 16) << 4 | (encoded_input[2] >> 2);
  output[2] = (encoded_input[2] % 4) << 6 | (encoded_input[3] % 64);
}
int readB(int input, char* buf, int bytes) {
  while (read(input, buf, 1) && --bytes) buf++;
  return bytes;
}

void write_Bytes(int output, char* buf, int bytes) {
  if (write(output, buf, bytes) != bytes) {
    fprintf(stderr, "Error de escritura: faltaron bytes");
    close_files(&choice);
    exit(ERROR);
  }
}

int padding_count(char* input, int size) {
  int count = 0;
  for (int i = 0; i < size; i++)
  {
      count += input[i] == PADDING_CH;
  }
  return count;
}

void checkDecodingError(char* inputBuf) {
  if (inputBuf[0] == PADDING_CH || inputBuf[1] == PADDING_CH ||
    (inputBuf[2] == PADDING_CH && inputBuf[3] != PADDING_CH)) {
    fprintf(stderr, "Error de decodificacion: largo de mensaje incorrecto.\n");
    close_files(&choice);
    exit(DECODE_ERROR);
  }
}
int main (int argc, char** argv) {
    parseAnswer(argc, argv, &choice);
    int bytesToFinish = 0;
    int maxToRead = 3 + choice.decode;
    int maxToWrite = 3 + !choice.decode;
    bool stop;
    int writeLenght;

    while (!bytesToFinish) {
      char input[4] = {0};
      char output[4] = {0};

      bytesToFinish = readB(choice.inputFile, input, maxToRead);

      if (bytesToFinish == maxToRead) {
        bytesToFinish = 0;
        break;
      }

      if (bytesToFinish && choice.decode) {
        fprintf(stderr, "Error decodificando: tamanio de codificado incorrecto.\n");
        exit(DECODE_ERROR);
      }

      if (choice.decode) checkDecodingError(input);

      writeLenght = maxToWrite - bytesToFinish - choice.decode * padding_count(input, maxToRead);

      stop = input[3] == PADDING_CH;

      if (!choice.decode){
        base64encode(input, output);
      }
      else{
        base64decode(input, output);
      }
     
      write_Bytes(choice.outputFile, output, writeLenght);

      if (stop) break;
    }

    while (bytesToFinish--) write_Bytes(choice.outputFile, &PADDING_CH, 1);

    close_files(&choice);
    return 0;
}
