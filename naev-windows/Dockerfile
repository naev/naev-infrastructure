FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Windows cross-compile development environment for Naev."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-windows"

WORKDIR /tmp
# Install build requirements
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install gcc git meson ninja-build python3-pyyaml tar xz unzip zip \
# Install mingw64 packages
    mingw64-gcc mingw64-freetype mingw64-libvorbis mingw64-libxml2 mingw64-openal-soft \
    mingw64-SDL2 mingw64-SDL2_image mingw64-libpng mingw32-nsis && \
    microdnf clean all && \
# Install openblas for mingw (building this from source is an option but probably painful)
    curl -L -O https://github.com/xianyi/OpenBLAS/releases/download/v0.3.18/OpenBLAS-0.3.18-x64.zip && \
    unzip /tmp/OpenBLAS-0.3.18-x64.zip -d /usr/x86_64-w64-mingw32/sys-root/mingw && \
    rm -rf /tmp/OpenBLAS-0.3.18-x64.zip

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
