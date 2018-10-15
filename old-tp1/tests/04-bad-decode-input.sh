TP_NAME='tp1';

OUTPUT=`echo -n TWFud | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='Sending wrong decode message size';

if [ "$OUTPUT" == "Decoding Error: Wrong encoded message length." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n TWFu== | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='Sending wrong decode message size with trailing padding';

if [ "$OUTPUT" == "Decoding Error: Wrong encoded message length." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n Te=E | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='Sending wrong decode message size with wrong padding';

if [ "$OUTPUT" == "Decoding Error: Wrong encoded message length." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n abc\# | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='Cannot decode non-table symbols';

if [ "$OUTPUT" == "Decoding Error: Cannot decode symbol" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
