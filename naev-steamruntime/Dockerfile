FROM registry.gitlab.steamos.cloud/steamrt/soldier/sdk:latest

LABEL org.opencontainers.image.authors "Jack Greiner <jack@emoss.org>" 
LABEL org.opencontainers.image.source "https://github.com/ProjectSynchro/synchros-sexy-docker-containers" 
LABEL org.opencontainers.image.description "Steam runtime (Soldier) development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."

# Install pip from steam/debian repositories.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip
RUN python3 -m pip install --upgrade pip && \
    echo "Verifying python install" && \
    which python3 && \
    python3 --version && \
    echo "Verifying pip install" && \
    python3 -m pip --version

# Install Mutagen for soundtrack generation via pip.
RUN python3 -m pip install mutagen

# Upgrade meson via pip.
RUN python3 -m pip install meson --upgrade && \
    echo "Verifying meson install" && \
    which meson && \
    meson --version

# Cleanup apt cache and remove lists.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
