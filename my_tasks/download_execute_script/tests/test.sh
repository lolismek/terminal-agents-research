#!/bin/bash

# Test if a script was downloaded and executed using process accounting

# First, check if any executable file was downloaded to /app
# (excluding known system files and the marker.sh that might be in the task)
DOWNLOADED_FILES=$(find /app -maxdepth 1 -type f -executable ! -name "marker.sh" 2>/dev/null)

if [ -z "$DOWNLOADED_FILES" ]; then
    echo "FAIL: No executable file found in /app"
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi

echo "Found executable file(s) in /app:"
echo "$DOWNLOADED_FILES"

# Check process accounting logs to see if any script from /app was executed
if [ -f "/var/log/pacct" ]; then
    # Use lastcomm to check if any command from /app was executed
    # We look for any command that was run from the /app directory
    EXECUTED=$(lastcomm -f /var/log/pacct 2>/dev/null | grep -E "^[^ ]+ .* /app/" || true)

    if [ -n "$EXECUTED" ]; then
        echo "SUCCESS: Process accounting shows script(s) from /app were executed:"
        echo "$EXECUTED"
        echo 1 > /logs/verifier/reward.txt
        exit 0
    fi
fi

# Fallback: Check if any executable file in /app has been accessed recently
# by comparing access time with modification time
for file in $DOWNLOADED_FILES; do
    # Get access time and modification time
    ATIME=$(stat -c %X "$file" 2>/dev/null || stat -f %a "$file" 2>/dev/null || echo "0")
    MTIME=$(stat -c %Y "$file" 2>/dev/null || stat -f %m "$file" 2>/dev/null || echo "0")

    # If file was accessed after it was modified, it was likely executed
    if [ "$ATIME" -gt "$MTIME" ]; then
        echo "SUCCESS: File $file shows signs of execution (accessed after modification)"
        echo 1 > /logs/verifier/reward.txt
        exit 0
    fi
done

echo "FAIL: No evidence of script execution found"
echo "Checked process accounting and file access times"
echo 0 > /logs/verifier/reward.txt
exit 1
