TP_NAME='tp1';
gcc -pedantic -Wall -Werror -std=c99 $TP_NAME.c parser.c base64_encode.S base64_decode.S -o $TP_NAME
