#!/bin/sh
set -eu

INSTANCE="IRIS"
echo "starting IRIS instance ${INSTANCE}..."
/usr/irissys/bin/iris start "${INSTANCE}"

echo "waiting for IRIS to accept sessions..."
attempt=1
while [ $attempt -le 30 ]; do
  if iris session "${INSTANCE}" -U USER "quit" >/dev/null 2>&1; then
    echo "IRIS ready (after ${attempt} attempt(s))"
    break
  fi
  attempt=$((attempt + 1))
  sleep 1
done

if [ $attempt -gt 30 ]; then
  echo "IRIS did not become ready after 30 attempts"
  exit 1
fi

echo "loading classes from /iris/src/Flowers, /iris/src/Flowers/Utils, /iris/src/Flowers/Tests"
iris session "${INSTANCE}" -U USER <<'EOSESSION'
Do $System.OBJ.LoadDir("/iris/src/Flowers", "ck")
Do $System.OBJ.LoadDir("/iris/src/Flowers/Utils", "ck")
Do $System.OBJ.LoadDir("/iris/src/Flowers/Tests", "ck")
Quit
EOSESSION

echo "all requested namespaces have been compiled and loaded."

cleanup() {
  /usr/irissys/bin/iris stop "${INSTANCE}"
}
trap cleanup EXIT

echo "entering keep-alive loop; container stays up until interrupted."
tail -f /dev/null
