TP_NAME='tp0';

TEST_DESCRIPTION='Sending wrong decode message size';
n=1;
while [ $n -lt 100 ]; do
  head -c $n </dev/urandom >/tmp/in.bin;
  ./tp0 -a encode -i /tmp/in.bin  -o /tmp/out.b64;
  ./tp0 -a decode -i /tmp/out.b64 -o /tmp/out.bin;
  if diff /tmp/in.bin /tmp/out.bin; then :; else
    rm -f /tmp/in.bin /tmp/out.b64 /tmp/out.bin
    echo "ERROR: $n";
    break;
  fi
  echo "ok: $n";
  n=$((n + 1));
  rm -f /tmp/in.bin /tmp/out.b64 /tmp/out.bin
done
