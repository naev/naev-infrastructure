FROM ubuntu:20.04

LABEL org.opencontainers.image.authors "Jack Greiner <jack@emoss.org>" 
LABEL org.opencontainers.image.source "https://github.com/ProjectSynchro/synchros-sexy-docker-containers" 
LABEL org.opencontainers.image.description "MacOS cross-compile development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."

# Add stable git PPA, deadsnakes ppa for python builds, and llvm apt repository (no building from source yay!)
RUN apt-get update && apt-get install -y software-properties-common curl apt-transport-https && \
    apt-add-repository ppa:git-core/ppa && add-apt-repository ppa:deadsnakes/ppa && \
    curl -sL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    curl -sL https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    add-apt-repository -s 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal main' && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update

# Install Build dependencies and utilities.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autopoint autoconf autoconf-archive bash clang cmake git intltool patch libssl-dev llvm-dev lzma-dev libxml2-dev nano ninja-build wget pkg-config vim zip

# Install Python 3.9.* from deadsnakes PPA.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3.9-dev python3.9-venv python3-pip
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1 && \
    python3 -m pip install --upgrade pip && \
    echo "Verifying python install" && \
    which python3 && \
    python3 --version && \
    echo "Verifying pip install" && \
    python3 -m pip --version
    
# Install meson via pip.
RUN python3 -m pip install meson && \
    echo "Verifying meson install" && \
    which meson && \
    meson --version

# Git clone osxcross repo
WORKDIR /usr/local/src
RUN git clone https://github.com/tpoechtrager/osxcross.git

# Copy MacOS SDK tarball
COPY MacOSX10.13.sdk.tar.xz /usr/local/src/osxcross/tarballs

# Set MACOSX_DEPLOYMENT_TARGET
ENV MACOSX_DEPLOYMENT_TARGET "10.13"

# Build toolchain
WORKDIR /usr/local/src/osxcross
RUN TARGET_DIR=/usr/lib/osxcross UNATTENDED=1 ./build.sh

# Add osxcross to PATH
ENV PATH "$PATH:/usr/lib/osxcross/bin"

ENV OSXCROSS_MP_INC "1"

# Install required build dependencies
RUN UNATTENDED=1 osxcross-macports install binutils freetype libsdl2 libsdl2_image libsdl2_mixer libpng libvorbis openal-soft physfs SuiteSparse_CXSparse

# Horrible hack: ensure a hardcoded header file path resolves.  
RUN rmdir /opt && ln -s /usr/lib/osxcross/macports/pkgs/opt /opt 

# Set $HOST for use with bundle.py.
ENV HOST "x86_64-apple-darwin17"

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
