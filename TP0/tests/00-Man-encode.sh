TP_NAME='tp0';

OUTPUT=`echo -n Man | ./$TP_NAME`;
TEST_DESCRIPTION='Codificar "Man"';

if [ $OUTPUT == "TWFu" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n Ma | ./$TP_NAME`;
TEST_DESCRIPTION='Codificar "Ma"';

if [ $OUTPUT == "TWE=" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n M | ./$TP_NAME`;
TEST_DESCRIPTION='Codificar "M"';

if [ $OUTPUT == "TQ==" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
