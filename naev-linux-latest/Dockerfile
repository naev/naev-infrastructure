FROM registry.fedoraproject.org/fedora-minimal:rawhide

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Naev Linux (Latest) development/testing environment for Naev (For CI, testing and website builds)"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-linux-latest"

# Enable RPMFusion for additional up-to-date tools.
WORKDIR /tmp
RUN curl -L -O https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm && \
    rpm -i rpmfusion-free-release-rawhide.noarch.rpm && \
    rm -rf /tmp/rpmfusion-free-release-rawhide.noarch.rpm && \
# Install Build dependencies.
    microdnf -y install make findutils meson ninja-build gcc clang binutils-devel fontconfig-devel freetype-devel gettext-devel glpk-devel \
    libpng12-devel libxml2-devel libvorbis-devel libwebp-devel libunibreak-devel luajit-devel openal-soft-devel \
    openblas-devel physfs-devel SDL2-devel SDL2_image-devel suitesparse-devel \
# Install utilities
    git ffmpeg nano python3-pyyaml python3-mutagen tar which xz unzip zip \
# Install luarocks deps
    lua-devel ncurses-devel libevent-devel readline-devel && \
    microdnf clean all && \
# Build luarocks (In this case for lua 5.1 and lua latest)
    curl -L -O https://luarocks.org/releases/luarocks-3.8.0.tar.gz && \
    tar zxpf luarocks-3.8.0.tar.gz && \
    cd luarocks-3.8.0 && \
    ./configure --prefix=/opt/luarocks --versioned-rocks-dir && \
    make && \
    make install && \
    rm -rf /tmp/luarocks-3.8.0 && \
    rm /tmp/luarocks-3.8.0.tar.gz && \
    cd /tmp

# Add luarocks to PATH
ENV PATH "$PATH:/opt/luarocks/bin"

# Install ldoc and luacheck lua rocks.
RUN luarocks install luacheck

# Verify tool versions and install locations.
RUN echo "Verifying python install" && \
    which python3 && \
    python3 --version && \
    echo "Verifying luacheck install" && \
    which luacheck && \
    luacheck --version && \
    echo "Verifying meson install" && \
    which meson && \
    meson --version

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
