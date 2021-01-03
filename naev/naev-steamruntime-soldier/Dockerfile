FROM registry.gitlab.steamos.cloud/steamrt/soldier/sdk:latest

LABEL Description="Steam runtime (Soldier) development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."
LABEL Author="Jack Greiner <jack@emoss.org>"

# Add stable git PPA, deadsnakes ppa for python builds, and llvm apt repository (no building from source yay!)
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y software-properties-common curl apt-transport-https && \
    apt-add-repository ppa:git-core/ppa && add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update

# Install git, m4 macros (deprecated but still needed for 0.8.* releases), autopoint for autotools, and cpanminus to install the XML::Parser module
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --force-yes git autoconf-archive autopoint intltool

# Install Python 3.9.* from deadsnakes PPA.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3.9-dev python3.9-venv python3-pip
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1 && \
    python3 -m pip install --upgrade pip && \
    echo "Verifying python install" && \
    which python3 && \
    python3 --version && \
    echo "Verifying pip install" && \
    python3 -m pip --version
    
# Install Mutagen for soundtrack generation via pip.
RUN python3 -m pip install mutagen

# Install meson via pip.
RUN python3 -m pip install meson && \
    echo "Verifying meson install" && \
    which meson && \
    meson --version

# Cleanup apt cache and remove lists.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
