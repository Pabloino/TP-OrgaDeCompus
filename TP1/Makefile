TP_NAME=main

build:
	gcc -pedantic -Wall -Werror -std=c99 $(TP_NAME).c parser.c base64_encode.S base64_decode.S -o $(TP_NAME)
clean:
	rm -f $(TP_NAME)
	rm -f *.o
