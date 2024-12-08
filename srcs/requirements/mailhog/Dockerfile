# Start from a minimal Debian image
FROM debian:bullseye-slim as builder

# Install Go and dependencies for building MailHog
RUN apt-get update && apt-get install -y \
    git \
    golang \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Clone the MailHog repository
RUN git clone https://github.com/mailhog/MailHog.git .

# Install Go dependencies
RUN go get -d -v

# Build the MailHog binary
RUN go build -o mailhog .

# Start a new stage to copy only the necessary files
FROM debian:bullseye-slim

# Install runtime dependencies (only the necessary ones)
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy the MailHog binary from the builder stage
COPY --from=builder /app/mailhog /usr/local/bin/mailhog

# Expose the necessary ports (Web UI and SMTP)
EXPOSE 8085 1025

# Set the command to run MailHog
CMD ["mailhog", "-ui-bind-addr", "0.0.0.0:8085", "-smtp-bind-addr", "0.0.0.0:1025"]
