TP_NAME='main';

OUTPUT=`echo -n TWFud | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='El decodificador verifica que el largo del input sea correcto';

if [ "$OUTPUT" == "Error decodificando: tamanio de codificado incorrecto." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n TWFu== | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='El decodificador verifica que no se envien mas de un padding al final';

if [ "$OUTPUT" == "Error decodificando: tamanio de codificado incorrecto." ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi

OUTPUT=`echo -n abc\# | ./$TP_NAME -a decode 2>&1 > /dev/null`;
TEST_DESCRIPTION='El decodificador muestra error si trata de decodificar un simbolo que no pertenece a la tabla';

if [ "$OUTPUT" == "Error de Decodificacion: no se puede decodificar #" ]
then
  echo "$TEST_DESCRIPTION: OK";
else
  echo "$TEST_DESCRIPTION: ERROR";
fi
