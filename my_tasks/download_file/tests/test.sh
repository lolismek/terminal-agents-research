#!/bin/bash

# Test if the file was downloaded

# Check if downloaded_file.txt exists
if [ ! -f "/app/downloaded_file.txt" ]; then
    echo "FAIL: downloaded_file.txt does not exist"
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi

# Check if the file has content (is not empty)
if [ ! -s "/app/downloaded_file.txt" ]; then
    echo "FAIL: downloaded_file.txt is empty"
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi

echo "SUCCESS: File was successfully downloaded"
echo 1 > /logs/verifier/reward.txt
exit 0
