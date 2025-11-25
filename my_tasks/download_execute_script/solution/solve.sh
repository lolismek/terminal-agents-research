#!/bin/bash

# Download the script from the GitHub URL
curl -o /app/downloaded_script.sh https://raw.githubusercontent.com/lolismek/terminal-agents-research/main/my_tasks/download_execute_script/marker.sh

# Check if download was successful
if [ ! -f /app/downloaded_script.sh ]; then
    echo "ERROR: Failed to download script"
    exit 1
fi

# Make it executable
chmod +x /app/downloaded_script.sh

# Execute the script
/app/downloaded_script.sh
