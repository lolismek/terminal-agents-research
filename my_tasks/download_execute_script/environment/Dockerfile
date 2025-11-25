FROM ubuntu:22.04

# Install basic utilities including download tools and process accounting
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    bash \
    acct \
    && rm -rf /var/lib/apt/lists/*

# Enable process accounting
RUN mkdir -p /var/log && touch /var/log/pacct

# Set working directory
WORKDIR /app

# Start process accounting when container starts
RUN echo '#!/bin/bash\naccton /var/log/pacct 2>/dev/null || true\nexec "$@"' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
