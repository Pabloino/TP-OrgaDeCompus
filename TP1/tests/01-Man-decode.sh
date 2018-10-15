TP_NAME='tp1';

OUTPUT=`echo -n TWFu | ./$TP_NAME -a decode`;
TEST_DESCRIPTION='Decoding "TWFu"';

if [ $OUTPUT == "Man" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n TWE= | ./$TP_NAME -a decode`;
TEST_DESCRIPTION='Decoding "TWE="';

if [ $OUTPUT == "Ma" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n TQ== | ./$TP_NAME -a decode`;
TEST_DESCRIPTION='Decoding "TQ=="';

if [ $OUTPUT == "M" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
