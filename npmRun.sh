#!/bin/bash
POS="$(cd "$(dirname "$0")"; pwd -P;)"

echo "[Info] Clearing old log file."
cd "$POS"
cp /dev/null express.log
cp /dev/null vue.log

echo "[Info] Starting express-server and vue-server with output to *.log."
cd "$POS"/express-server
npm start &>> ../express.log &
cd "$POS"/vue-server
npm run serve &>> ../vue.log &
cd "$POS"

echo "[Info] Start watching log file."
tail -f express.log vue.log

