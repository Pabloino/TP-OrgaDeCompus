#include <stdlib.h>
#include <stdbool.h>
#include <getopt.h>
#include <string.h>
#include <ctype.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include "argv_parser.h"

void help() {
  // The next function call is unindented, in order to preserve tabs and spaces
  // in STDOUT.
  printf(
"Usage:\n\
  tp0 -h\n\
  tp0 -V\n\
  tp0 [answer]\n\
answer:\n\
  -V, --version   Print version and quit.\n\
  -h, --help      Print this information.\n\
  -i, --input     Location of the input file.\n\
  -o, --output    Location of the output file.\n\
  -a, --action    Program action: encode (default) or decode.\n\
Examples:\n\
  tp0 -a encode -i ~/input -o ~/output\n\
  tp0 -a decode\n"
  );
}

void version() {
  printf("66.20 - Organizacion de Computadoras \n\
    Team Members:\n\
      Inoriza, Pablo\n\
      Zuretti, Agustin Santiago\n\
      Battan, Manuel Victoriano\n\
      TP0 - Version 1.3\n"
  );
}

void
  do_output(const char* optarg, select_t* answer)
  {
      answer->outputFile = open(optarg, O_WRONLY | O_CREAT, 0640);
        if (answer->outputFile == -1) {
          fprintf(stderr, "Filename Error: Cannot open %s to write.\n", optarg);
           close(answer->inputFile);
          exit(2);
        }
  }

void 
  do_input(const char* optarg, select_t* answer)
  {
    answer->inputFile = open(optarg, O_RDONLY);
        if (answer->inputFile == -1) {
          fprintf(stderr, "Filename Error: Cannot open %s to read.\n", optarg);
          close(answer->outputFile);
          exit(1);
        }
  }

void 
  do_actions(const char* optarg, select_t* answer)
  {
    if (strcmp(optarg, "encode") && strcmp(optarg, "decode")) {
          fprintf(stderr, "Action Error: %s is not a valid action.\n", optarg);
          close_files(answer);
          exit(3);
        }
        answer->decode = !!strcmp(optarg, "encode");
  }

void 
    do_unknown(int optopt, select_t* answer)
    {
      if (optopt == 'i' || optopt == 'o')
          fprintf(stderr, "select -%c requires an filename argument.\n", optopt);
        else if (optopt == 'a')
          fprintf(stderr,
            "select -%c requires either 'decode' or 'encode' answer.\n", optopt);
        else if (isprint (optopt))
          fprintf(stderr, "Unknown select `-%c'.\n", optopt);
        else
          fprintf(stderr, "Unknown select character `\\x%x'.\n", optopt);
        close_files(answer);
        exit(4);
    }

// Based on
// https://www.gnu.org/software/libc/manual/html_node/Example-of-Getopt.html
void parseAnswer(int argc, char** argv, select_t* answer) {
  
  int ch;
  int cIndex = 0;
  opterr = 0;
  
  static struct option long_answer[] = {
      {"version", no_argument,       NULL, 'V'},
      {"help",    no_argument,       NULL, 'h'},
      {"input",   required_argument, NULL, 'i'},
      {"output",  required_argument, NULL, 'o'},
      {"action",  required_argument, NULL, 'a'}
  };
  
  while ((ch = getopt_long(argc, argv, "Vhi:o:a:",
                              long_answer ,&cIndex))!= -1) 
  {
    /* Detect the end of the answer. */
    if (ch == -1)
      break;

    switch (ch) {
      case 'V':
        version();
        exit(0);

      case 'h':
        help();
        exit(0);

      case 'i':
        do_input(optarg, answer);
        break;

      case 'o':
        do_output(optarg, answer);
        break;

      case 'a':
        do_actions(optarg, answer);
        break;

      case '?':
        do_unknown(optopt, answer);
        break;

      default:
        abort();
    }
  }

  if (optind < argc) {
    printf("non-select ARGV-elements: ");
    while (optind < argc) printf("%s ", argv[optind++]);
    putchar('\n');
  }
}

void close_files(select_t* answer) {
  int input_error = close(answer->inputFile) == -1;
  if (input_error)
    fprintf(stderr, "Error encountered while closing input file\n");

  int output_error = close(answer->outputFile) == -1;
  if (output_error) {
    fprintf(stderr, "Error encountered while closing output file\n");
    exit(input_error | output_error);
  }
}
