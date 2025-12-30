#!/bin/bash

BACKEND_URL="${BACKEND_URL:-http://localhost:4000/log}"

COMMAND="$*"
START_TIME=$(date +%s)

# Detect if we are running a script file (GitHub Actions way) or a command string
if [ -f "$1" ]; then
  OUTPUT=$(bash "$@" 2>&1)
else
  OUTPUT=$($COMMAND 2>&1)
fi
EXIT_CODE=$?

END_TIME=$(date +%s)

curl -s -X POST "$BACKEND_URL" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"$COMMAND\",
    \"output\": \"$(echo "$OUTPUT" | sed 's/"/\\"/g')\",
    \"exitCode\": $EXIT_CODE,
    \"startTime\": $START_TIME,
    \"endTime\": $END_TIME
  }" >/dev/null

echo "$OUTPUT"
exit $EXIT_CODE
