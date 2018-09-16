#include <stdio.h>
#include <getopt.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

void print_help(){
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

void print_version(){
	printf(
"-------------------------------------\n\
66.20 - Organización de Computadoras\n\
-------------------------------------\n\
TP0 - 2do Cuatrimestre 2018\n\
\n\
Versión:\n\
  0.1 Beta\n\
Miembros del grupo:\n\
  Battan, Manuel Victoriano\n\
  Inoriza, Pablo\n\
  Zuretti, Agustín\n\
"
	);
}

void main(int argc, char **argv){
	int c;
	int input_file;
	int output_file;

	c = getopt(argc, argv, "Vhi:o:a:");

	switch(c){
		case 'V':
			print_version();
			break;
		case 'h':
			print_help();
			break;
		case 'i':
			input_file = open(optarg, O_RDONLY);
			if (input_file == -1) {
        		fprintf(stderr, "Filename Error: Cannot open %s to read.\n", optarg);
        		close(output_file);
        	}
			break;
		case 'o':
			output_file = open(optarg, O_WRONLY | O_CREAT);
			if (output_file == -1) {
        		fprintf(stderr, "Filename Error: Cannot open %s to write.\n", optarg);
      			close(input_file);
       		}
       		break;
	}
}