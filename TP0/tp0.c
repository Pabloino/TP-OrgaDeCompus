#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include "argv_parser.h"

select_t choice = { STDIN_FILENO, STDOUT_FILENO, false };
char PADDING_CH = '=';
char base64_table[64] = {
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
  'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
  'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
  'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
  'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
  'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
  'w', 'x', 'y', 'z', '0', '1', '2', '3',
  '4', '5', '6', '7', '8', '9', '+', '/'
};

char decode_ch(char DecodeChar) {
  const char BASE_64_INDEX_a = 26;
  const char BASE_64_INDEX_0 = 52;

  if (DecodeChar >= 'a') {
    return DecodeChar - 'a' + BASE_64_INDEX_a;
  }
  if (DecodeChar >= 'A') {
    return DecodeChar - 'A';
  }
  if (DecodeChar >= '0') {
    return DecodeChar - '0' + BASE_64_INDEX_0;
  }

  if (DecodeChar != '/' && DecodeChar != '+' && DecodeChar != '=') {
    fprintf(stderr, "Error de Decodificacion: no se puede decodificar %c\n", DecodeChar);
    close_files(&choice);
    exit(5);
  }
  return 62 + DecodeChar == '/';
}
void encode(char* input, char* output) {
 
  output[0] = input[0] >> 2;
  output[1] = ((input[0] % 4) << 4) | (input[1] >> 4);
  output[2] = ((input[1] % 16) << 2) | (input[2] >> 6);
  output[3] = input[2] % 64;

  output[0] = base64_table[(int) output[0]];
  output[1] = base64_table[(int) output[1]];
  output[2] = base64_table[(int) output[2]];
  output[3] = base64_table[(int) output[3]];
}
void decode(char* encoded_input, char* output) {

  encoded_input[0] = decode_ch(encoded_input[0]);
  encoded_input[1] = decode_ch(encoded_input[1]);
  encoded_input[2] = decode_ch(encoded_input[2]);
  encoded_input[3] = decode_ch(encoded_input[3]);

  output[0] = (encoded_input[0] % 64) << 2 | (encoded_input[1] >> 4);
  output[1] = (encoded_input[1] % 16) << 4 | (encoded_input[2] >> 2);
  output[2] = (encoded_input[2] % 4) << 6 | (encoded_input[3] % 64);
}
int read_bytes(int input_fd, char* buffer, int bytes) {
  while (read(input_fd, buffer, 1) && --bytes) buffer++;
  return bytes;
}

void write_bytes(int output_fd, char* buffer, int bytes) {
  if (write(output_fd, buffer, bytes) != bytes) {
    fprintf(stderr, "Write error: did not write de ammount of bytes that should");
    close_files(&choice);
    exit(-1);
  }
}

int padding_count(char* input, int buffer_size) {
  int count = 0;
  for (int i = 0; i < buffer_size; i++) count += input[i] == PADDING_CH;
  return count;
}

void assert_decoding_buffer(char* inputBuf) {
  if (inputBuf[0] == PADDING_CH || inputBuf[1] == PADDING_CH ||
    (inputBuf[2] == PADDING_CH && inputBuf[3] != PADDING_CH)) {
    fprintf(stderr, "Decoding Error: Wrong encoded message length.\n");
    close_files(&choice);
    exit(6);
  }
}
int main (int argc, char** argv) {
    parseAnswer(argc, argv, &choice);
    int bytesToFinish = 0;
    int maxToRead = 3 + choice.decode;
    int maxToWrite = 3 + !choice.decode;

    while (!bytesToFinish) {
      char input[4] = {0};
      char output[4] = {0};

      bytesToFinish = read_bytes(choice.inputFile, input, maxToRead);

      if (bytesToFinish == maxToRead) {
        bytesToFinish = 0;
        break;
      }

      if (bytesToFinish && choice.decode) {
        fprintf(stderr, "Error decodificando: tamanio de codificado incorrecto.\n");
        exit(6);
      }

      if (choice.decode) assert_decoding_buffer(input);

      int bytes_to_write = maxToWrite - bytesToFinish - choice.decode * padding_count(input, maxToRead);

      bool stop = input[3] == PADDING_CH;

      if (!choice.decode){
        encode(input, output);
      }
      else{
        decode(input, output);
      }
     
      write_bytes(choice.outputFile, output, bytes_to_write);

      if (stop) break;
    }

    while (bytesToFinish--) write_bytes(choice.outputFile, &PADDING_CH, 1);

    close_files(&choice);
    return 0;
}
