# Pull base image
FROM jlesage/baseimage-gui:debian-9

# Define working directory
WORKDIR /tmp

# Set Version to install
ARG SIGNAL_VERSION=1.31.0

# Install required software
RUN \
	add-pkg software-properties-common apt-transport-https ca-certificates curl gnupg2 libgtk-3-0 && \
	curl -s 'https://updates.signal.org/desktop/apt/keys.asc' | apt-key add - && \
	add-apt-repository 'deb https://updates.signal.org/desktop/apt xenial main' && \
	add-pkg signal-desktop=${SIGNAL_VERSION} && \
	del-pkg software-properties-common apt-transport-https ca-certificates curl gnupg2

# Add files
COPY startapp.sh /startapp.sh

# Set environment variables
ENV APP_NAME="signal-desktop"

# Metadata.
LABEL \
      org.label-schema.name="signal-desktop" \
      org.label-schema.description="Docker container for Signal" \
      org.label-schema.version="unknown" \
      org.label-schema.vcs-url="https://github.com/c64bob/docker-signal" \
      org.label-schema.schema-version="1.0"
