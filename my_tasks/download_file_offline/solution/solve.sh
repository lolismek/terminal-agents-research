#!/bin/bash

# Download the file from the URL and save it as downloaded_file.txt
# This will actually use our fake curl that serves a local file
curl -o /app/downloaded_file.txt https://raw.githubusercontent.com/octobloblo/Hello-World/master/README
