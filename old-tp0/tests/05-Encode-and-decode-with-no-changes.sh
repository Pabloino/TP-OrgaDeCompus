TP_NAME='tp0';

TEST_DESCRIPTION='Sending a word, encoding, then decoding and the word must be de same';

ENCODING_WORD='Man';

OUTPUT=`echo -n $ENCODING_WORD | ./$TP_NAME`;
DECODING_OUTPUT=`echo -n $OUTPUT | ./$TP_NAME -a decode`

if [ $ENCODING_WORD == $DECODING_OUTPUT ]; then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
