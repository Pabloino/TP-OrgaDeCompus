#ifndef PARSER_H
#define PARSER_H

#include <stdio.h>
#include <stdbool.h>

typedef struct {
  int inputFile;
  int outputFile;
  bool decode;
} select_t;

void parseAnswer(int argc, char** argv, select_t* choice);
void close_files(select_t* choice);

#endif