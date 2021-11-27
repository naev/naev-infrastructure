FROM registry.gitlab.steamos.cloud/steamrt/soldier/sdk:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Steam runtime (Soldier) build environment for Naev."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-steamruntime"

# Install pip from steam/debian repositories.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip \
# Naughty: we need libwebp, and libopenblas, not in the SDK.... Both are statically linked when building with the steamruntime option in meson set to true.
    libopenblas-dev libwebp-dev && \
    apt-get clean && \
# Upgrade meson via pip.
    python3 -m pip install meson --upgrade && \
    echo "Verifying python install" && \
    command -v python3 && \
    python3 --version && \
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version
    
# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
