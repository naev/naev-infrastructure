# Build luarocks in build container to save space.
FROM registry.fedoraproject.org/fedora-minimal:latest AS build 

# Install luarocks deps
RUN microdnf --nodocs --setopt=install_weak_deps=1 -y install findutils gcc gzip lua-devel make ncurses-devel libevent-devel readline-devel tar unzip && \
    microdnf clean all && \
# Build luarocks
    curl -L -O https://luarocks.org/releases/luarocks-3.8.0.tar.gz && \
    tar zxpf luarocks-3.8.0.tar.gz && \
    cd luarocks-3.8.0 && \
    ./configure --prefix=/opt/luarocks --versioned-rocks-dir && \
    make -j"$(nproc --all)" && \
    make install

# Add luarocks to PATH and install luacheck
ENV PATH "$PATH:/opt/luarocks/bin"
RUN luarocks install luacheck

# Build final container
FROM registry.fedoraproject.org/fedora-minimal:rawhide

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Naev Linux (Latest) development/testing environment for Naev."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-linux-latest"

WORKDIR /
COPY --from=build /opt/luarocks /opt/luarocks 

# Enable RPMFusion for additional up-to-date tools.
RUN curl -L -O https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm && \
    rpm -i rpmfusion-free-release-rawhide.noarch.rpm && \
    rm -rf /tmp/rpmfusion-free-release-rawhide.noarch.rpm && \
# Install Build dependencies.
    microdnf --nodocs --setopt=install_weak_deps=1 -y install meson ninja-build gcc binutils-devel fontconfig-devel freetype-devel \
    gettext-devel glpk-devel libpng12-devel libxml2-devel libvorbis-devel libwebp-devel libunibreak-devel \
    luajit-devel openal-soft-devel openblas-devel physfs-devel SDL2-devel SDL2_image-devel suitesparse-devel \
# Install utilities
    git ffmpeg libevent lua nano ncurses python3-pyyaml python3-mutagen readline tar xz unzip zip && \
    microdnf clean all

# Add luarocks to PATH
ENV PATH "$PATH:/opt/luarocks/bin"

# Verify tool versions and install locations.
RUN echo "Verifying python install" && \
    command -v python3 && \
    python3 --version && \
    echo "Verifying luacheck install" && \
    command -v luacheck && \
    luacheck --version && \
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
