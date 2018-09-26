TP_NAME='tp0';

OUTPUT=`yes | head -c 1024 | ./tp0 -a encode | ./tp0 -a decode | wc -c`;
TEST_DESCRIPTION='Codificar y decodificar preserva la cantidad de bytes';

if [ $OUTPUT == 1024 ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
