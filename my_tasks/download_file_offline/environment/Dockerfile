FROM ubuntu:22.04

# Install basic utilities including real curl and wget (but we'll override them)
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create directory for mock internet files
RUN mkdir -p /mock_internet

# Copy the local file that will be "downloaded"
COPY mock_internet/testfile.txt /mock_internet/testfile.txt

# Copy fake curl and wget scripts
COPY mock_internet/curl /usr/local/bin/curl
COPY mock_internet/wget /usr/local/bin/wget

# Make the fake scripts executable
RUN chmod +x /usr/local/bin/curl /usr/local/bin/wget

# /usr/local/bin is already in PATH and takes precedence over /usr/bin
# So our fake curl/wget will be used instead of the real ones

# Set working directory
WORKDIR /app

# Default command
CMD ["/bin/bash"]
