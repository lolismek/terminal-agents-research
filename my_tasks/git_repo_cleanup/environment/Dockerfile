FROM ubuntu:22.04

# Install git and related tools
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy mock git wrapper
COPY mock_tools/git /usr/local/bin/git-mock
RUN chmod +x /usr/local/bin/git-mock

# Move real git and replace with mock
RUN mv /usr/bin/git /usr/bin/git-real && \
    ln -s /usr/local/bin/git-mock /usr/bin/git

# Create logs directory
RUN mkdir -p /sandbox/logs

# Copy repository initialization script
COPY init_repo.sh /tmp/init_repo.sh
RUN chmod +x /tmp/init_repo.sh

# Initialize the test repository with problematic history
RUN /tmp/init_repo.sh

# Configure git user for the container
RUN git config --global user.email "agent@test.com" && \
    git config --global user.name "Test Agent"

# Set working directory
WORKDIR /app

# Default command
CMD ["/bin/bash"]
