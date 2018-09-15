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
  tp0 [options]\n\
Options:\n\
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
  do_output(const char* optarg, option_t* options)
  {
      options->output_file_descriptor = open(optarg, O_WRONLY | O_CREAT, 0640);
        if (options->output_file_descriptor == -1) {
          fprintf(stderr, "Filename Error: Cannot open %s to write.\n", optarg);
           close(options->input_file_descriptor);
          exit(2);
        }
  }

void 
  do_input(const char* optarg, option_t* options)
  {
    options->input_file_descriptor = open(optarg, O_RDONLY);
        if (options->input_file_descriptor == -1) {
          fprintf(stderr, "Filename Error: Cannot open %s to read.\n", optarg);
          close(options->output_file_descriptor);
          exit(1);
        }
  }

void 
  do_actions(const char* optarg, option_t* options)
  {
    if (strcmp(optarg, "encode") && strcmp(optarg, "decode")) {
          fprintf(stderr, "Action Error: %s is not a valid action.\n", optarg);
          close_files(options);
          exit(3);
        }
        options->should_decode = !!strcmp(optarg, "encode");
  }

void 
    do_unknown(int optopt, option_t* options)
    {
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
    }

// Based on
// https://www.gnu.org/software/libc/manual/html_node/Example-of-Getopt.html
void parse_options(int argc, char** argv, option_t* options) {
  
  int seen_option;
  int option_index = 0;
  opterr = 0;
  
  static struct option long_options[] = {
      {"version", no_argument,       NULL, 'V'},
      {"help",    no_argument,       NULL, 'h'},
      {"input",   required_argument, NULL, 'i'},
      {"output",  required_argument, NULL, 'o'},
      {"action",  required_argument, NULL, 'a'}
  };
  
  while ((seen_option = getopt_long(argc, argv, "Vhi:o:a:",
                              long_options ,&option_index))!= -1) 
  {
    /* Detect the end of the options. */
    if (seen_option == -1)
      break;

    switch (seen_option) {
      case 'V':
        version();
        exit(0);

      case 'h':
        help();
        exit(0);

      case 'i':
        do_input(optarg, options);
        break;

      case 'o':
        do_output(optarg, options);
        break;

      case 'a':
        do_actions(optarg, options);
        break;

      case '?':
        do_unknown(optopt, options);
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
