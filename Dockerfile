FROM ubuntu:16.04

# Install packages
RUN apt update && \
    apt install -y vlc

# Add user
RUN adduser --disabled-password --gecos "user" user

# Copy files
WORKDIR /app
COPY download_video.sh .
