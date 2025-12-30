#!/bin/bash

export SHELL="$(pwd)/agent/insight-shell.sh"

echo "Running pipeline..."

npm --version
node --version
echo "Build step"
sleep 2
echo "Test step"
sleep 1
echo "Deploy step"

echo "Pipeline finished"
