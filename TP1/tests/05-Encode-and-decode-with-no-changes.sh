TP_NAME='tp1';

TEST_DESCRIPTION='Sending a word, encoding, then decoding and the word must be de same';

ENCODING_WORD='Man';

OUTPUT=`echo -n $ENCODING_WORD | ./$TP_NAME`;
DECODING_OUTPUT=`echo -n $OUTPUT | ./$TP_NAME -a decode`

echo "$DECODING_OUTPUT" > tmp1
echo "$ENCODING_WORD" > tmp2

VALIDATE_STR=`diff tmp1 tmp2`;

if [ !$VALIDATE_STR ]; then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
