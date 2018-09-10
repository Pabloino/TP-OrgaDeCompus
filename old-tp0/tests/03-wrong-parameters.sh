TP_NAME='tp0';

OUTPUT=`./$TP_NAME -b 2>&1`;
TEST_DESCRIPTION='Send unknown option';

if [ "$OUTPUT" == "Unknown option \`-b'." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`./$TP_NAME --action undecode 2>&1`;
TEST_DESCRIPTION='Send wrong action name';

if [ "$OUTPUT" == "Action Error: undecode is not a valid action." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
