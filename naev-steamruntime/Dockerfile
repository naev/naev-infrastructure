FROM registry.gitlab.steamos.cloud/steamrt/soldier/sdk:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Steam runtime (Soldier) development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-steamruntime"

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

# Naughty: we need libwebp, not in the SDK... though only at runtime, dynamically loaded by SDL2_mixer.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libopenblas-dev

# Cleanup apt cache and remove lists.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
