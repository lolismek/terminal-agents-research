FROM ubuntu:22.04

# Install basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    python3 \
    python3-pip \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# Copy mock AWS CLI wrapper
COPY mock_tools/aws /usr/local/bin/aws-mock
RUN chmod +x /usr/local/bin/aws-mock

# Move real AWS CLI and replace with mock
RUN mv /usr/local/bin/aws /usr/local/bin/aws-real && \
    ln -s /usr/local/bin/aws-mock /usr/local/bin/aws

# Copy mock cloud data
COPY mock_cloud/aws /mock_cloud/aws

# Create logs directory
RUN mkdir -p /sandbox/logs

# Set AWS credentials (fake but realistic)
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
ENV AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
ENV AWS_DEFAULT_REGION="us-east-1"

# Set working directory
WORKDIR /app

# Default command
CMD ["/bin/bash"]
