FROM ubuntu:20.04

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Windows cross-compile development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."

# Enable i386 arch in dpkg
RUN dpkg --add-architecture i386 

# Add stable git PPA, deadsnakes ppa for python builds, mxe apt repo for prebuilt binary packages, winehq builds for ubuntu 20.04
RUN apt-get update && apt-get install -y software-properties-common curl apt-transport-https && \
    apt-add-repository ppa:git-core/ppa && add-apt-repository ppa:deadsnakes/ppa && \
    curl -sL https://pkg.mxe.cc/repos/apt/client-conf/mxeapt.gpg 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/mxeapt.gpg >/dev/null && \
    add-apt-repository 'deb https://pkg.mxe.cc/repos/apt focal main' && \
    curl -sL https://dl.winehq.org/wine-builds/winehq.key 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/winehq.gpg >/dev/null && \
    add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && \
    apt-get update

# Install Wine and friends
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --install-recommends winehq-stable nsis

# Set WINEPREFIX variable
ENV WINEPREFIX "/tmp/.wine"

# Configure Wine prefix
RUN mkdir -p /tmp/.wine && \
    winecfg

# Install MXE packages.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mxe-x86-64-w64-mingw32.shared-cmake \
    mxe-x86-64-w64-mingw32.shared-gcc mxe-x86-64-w64-mingw32.shared-freetype \
    mxe-x86-64-w64-mingw32.shared-glpk \
    mxe-x86-64-w64-mingw32.shared-vorbis mxe-x86-64-w64-mingw32.shared-libxml2 \
    mxe-x86-64-w64-mingw32.shared-openal mxe-x86-64-w64-mingw32.shared-pkgconf \
    mxe-x86-64-w64-mingw32.shared-physfs mxe-x86-64-w64-mingw32.shared-sdl2 \
    mxe-x86-64-w64-mingw32.shared-sdl2-image mxe-x86-64-w64-mingw32.shared-sdl2-mixer \
    mxe-x86-64-w64-mingw32.shared-mingw-w64 mxe-x86-64-w64-mingw32.shared-suitesparse

# Add MXE to PATH
ENV PATH "$PATH:/usr/lib/mxe/usr/bin"

# Install Python 3.9.* from deadsnakes PPA.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ninja-build python3.9-dev python3.9-venv python3-pip
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

# Cleanup apt cache and remove lists.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
