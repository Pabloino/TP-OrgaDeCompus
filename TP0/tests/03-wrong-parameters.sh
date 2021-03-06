TP_NAME='tp0';

OUTPUT=`./$TP_NAME -b 2>&1`;
TEST_DESCRIPTION='El decoder rechaza opciones desconocidas';

if [ "$OUTPUT" == "opcion equivocada" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`./$TP_NAME --action undecode 2>&1`;
TEST_DESCRIPTION='El decoder rechaza acciones desconocidas';

if [ "$OUTPUT" == "Error: undecode no se puede realizar." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
