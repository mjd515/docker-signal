# Pull base image
FROM jlesage/baseimage-gui:debian-10

# Define working directory
WORKDIR /tmp


# Install required software
RUN \
	add-pkg software-properties-common apt-transport-https ca-certificates curl gnupg2 libgtk-3-0 procps libgbm-dev && \
	wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor | tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null && \
	echo "deb https://updates.signal.org/desktop/apt xenial main" | tee -a /etc/apt/sources.list.d/signal-xenial.list > /dev/null && \
	add-apt-repository 'deb https://updates.signal.org/desktop/apt xenial main' && \
	add-pkg signal-desktop
	#&& \
	#del-pkg software-properties-common apt-transport-https ca-certificates curl gnupg2

# Add file
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
