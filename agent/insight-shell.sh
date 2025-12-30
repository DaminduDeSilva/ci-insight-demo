#!/bin/bash

BACKEND_URL="${BACKEND_URL:-http://localhost:4000/log}"

COMMAND="$*"
START_TIME=$(date +%s)

OUTPUT=$($COMMAND 2>&1)
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
