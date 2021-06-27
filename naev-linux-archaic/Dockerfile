FROM ubuntu:14.04

LABEL org.opencontainers.image.authors "Jack Greiner <jack@emoss.org>"
LABEL org.opencontainers.image.source "https://github.com/ProjectSynchro/synchros-sexy-docker-containers"
LABEL org.opencontainers.image.description "Naev Linux (Archaic) build/testing environment for Naev (ancient releases.)"

# Update APT repositories
RUN apt-get update

# Install Build dependencies and utilities.
RUN apt-get -y install build-essential

# Install libararies and various development packages.
RUN apt-get -y install git libsdl1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev libsdl2-dev libsdl2-mixer-dev \
libsdl2-image-dev libxml2-dev libglu1-mesa libglu1-mesa-dev libfreetype6-dev libpng-dev libopenal-dev libvorbis-dev

# Verify git version and installation.
RUN echo "Verifying git install" && \
    which git && \
    git --version

# Cleanup yum cache and utility temp files
RUN apt-get clean

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
