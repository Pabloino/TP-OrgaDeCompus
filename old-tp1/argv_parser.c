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

void print_help() {
  // The next function call is unindented, in order to preserve tabs and spaces
  // in STDOUT.
  printf(
"Usage:\n\
  tp1 -h\n\
  tp1 -V\n\
  tp1 [options]\n\
Options:\n\
  -V, --version   Print version and quit.\n\
  -h, --help      Print this information.\n\
  -i, --input     Location of the input file.\n\
  -o, --output    Location of the output file.\n\
  -a, --action    Program action: encode (default) or decode.\n\
Examples:\n\
  tp1 -a encode -i ~/input -o ~/output\n\
  tp1 -a decode\n"
  );
}

void print_version() {
  printf("66.20 - Organizacion de Computadoras \n\
    Team Members:\n\
      Battan, Manuel Victoriano\n\
      Israel, Pablo\n\
      Lazzari, Santiago\n\
    TP1 - Version 1.0\n\
    1Q2017\n"
  );
}

// Based on
// https://www.gnu.org/software/libc/manual/html_node/Example-of-Getopt.html
void parse_options(int argc, char** argv, option_t* options) {
  int seen_option;
  opterr = 0;

  while (true) {
    static struct option long_options[] = {
      {"version", no_argument,       NULL, 'V'},
      {"help",    no_argument,       NULL, 'h'},
      {"input",   required_argument, NULL, 'i'},
      {"output",  required_argument, NULL, 'o'},
      {"action",  required_argument, NULL, 'a'}
    };

    int option_index = 0;

    seen_option = getopt_long(
      argc,
      argv,
      "Vhi:o:a:",
      long_options,
      &option_index
    );

    /* Detect the end of the options. */
    if (seen_option == -1)
      break;

    switch (seen_option) {
      case 'V':
        print_version();
        break;

      case 'h':
        print_help();
        exit(0);

      case 'i':
        options->input_file_descriptor = open(optarg, O_RDONLY);
        if (options->input_file_descriptor == -1) {
          fprintf(stderr, "Filename Error: Cannot open %s to read.\n", optarg);
          close(options->output_file_descriptor);
          exit(1);
        }
        break;

      case 'o':
        options->output_file_descriptor = open(optarg, O_WRONLY | O_CREAT, 0640);
        if (options->output_file_descriptor == -1) {
          fprintf(stderr, "Filename Error: Cannot open %s to write.\n", optarg);
           close(options->input_file_descriptor);
          exit(2);
        }
        break;

      case 'a':
        if (strcmp(optarg, "encode") && strcmp(optarg, "decode")) {
          fprintf(stderr, "Action Error: %s is not a valid action.\n", optarg);
          close_files(options);
          exit(3);
        }
        options->should_decode = !!strcmp(optarg, "encode");
        break;

      case '?':
        if (optopt == 'i' || optopt == 'o')
          fprintf(stderr, "Option -%c requires an filename argument.\n", optopt);
        else if (optopt == 'a')
          fprintf(stderr,
            "Option -%c requires either 'decode' or 'encode' options.\n", optopt);
        else if (isprint (optopt))
          fprintf(stderr, "Unknown option `-%c'.\n", optopt);
        else
          fprintf(stderr, "Unknown option character `\\x%x'.\n", optopt);
        close_files(options);
        exit(4);
        break;

      default:
        abort();
    }
  }

  if (optind < argc) {
    printf("non-option ARGV-elements: ");
    while (optind < argc) printf("%s ", argv[optind++]);
    putchar('\n');
  }
}

void close_files(option_t* options) {
  int input_error = close(options->input_file_descriptor) == -1;
  if (input_error)
    fprintf(stderr, "Error encountered while closing input file\n");

  int output_error = close(options->output_file_descriptor) == -1;
  if (output_error) {
    fprintf(stderr, "Error encountered while closing output file\n");
    exit(input_error | output_error);
  }
}
