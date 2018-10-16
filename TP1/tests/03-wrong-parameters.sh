TP_NAME='main';

OUTPUT=`./$TP_NAME -b 2>&1`;
TEST_DESCRIPTION='envio opcion desconocida';

if [ "$OUTPUT" == "opcion equivocada" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`./$TP_NAME --action undecode 2>&1`;
TEST_DESCRIPTION='envio nombre de accion desconocido';

if [ "$OUTPUT" == "Error: undecode no se puede realizar." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
