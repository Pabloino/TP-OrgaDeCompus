TP_NAME='tp0';

OUTPUT=`echo -n TWFu | ./$TP_NAME -a decode`;
TEST_DESCRIPTION='Decodificar "TWFu"';

if [ $OUTPUT == "Man" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n TWE= | ./$TP_NAME -a decode`;
TEST_DESCRIPTION='Decodificar "TWE="';

if [ $OUTPUT == "Ma" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n TQ== | ./$TP_NAME -a decode`;
TEST_DESCRIPTION='Decodificar "TQ=="';

if [ $OUTPUT == "M" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
