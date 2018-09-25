TP_NAME='tp0';

OUTPUT=`echo -n TWFud | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='Sending wrong decode message size';

if [ "$OUTPUT" == "Error decodificando: tamanio de codificado incorrecto." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n TWFu== | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='Sending wrong decode message size with trailing padding';

if [ "$OUTPUT" == "Error decodificando: tamanio de codificado incorrecto." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n Te=E | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='Sending wrong decode message size with wrong padding';

if [ "$OUTPUT" == "Error de decodificacion: largo de mensaje incorrecto." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n abc\# | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='Cannot decode non-table symbols';

if [ "$OUTPUT" == "Error de Decodificacion: no se puede decodificar #" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
