TP_NAME='main';

OUTPUT=`yes | head -c 1024 | ./main -a encode | ./main -a decode | wc -c`;
TEST_DESCRIPTION='Conteo correcto';

if [ $OUTPUT == 1024 ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
