#!/bin/bash

# Test if hello.txt exists and has the correct content

if [ ! -f "/app/hello.txt" ]; then
    echo "FAIL: hello.txt does not exist"
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi

# Read the content
CONTENT=$(cat /app/hello.txt)

# Expected content
EXPECTED="Hello, World!"

if [ "$CONTENT" = "$EXPECTED" ]; then
    echo "SUCCESS: hello.txt has the correct content"
    echo 1 > /logs/verifier/reward.txt
    exit 0
else
    echo "FAIL: hello.txt content is incorrect"
    echo "Expected: $EXPECTED"
    echo "Got: $CONTENT"
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi
