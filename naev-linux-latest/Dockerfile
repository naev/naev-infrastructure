# Build luarocks in build container to save space.
FROM registry.fedoraproject.org/fedora-minimal:latest AS build 

WORKDIR /tmp
# Install luarocks deps
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install findutils gcc gzip lua lua-devel make ncurses-devel libevent-devel readline-devel tar xz unzip && \
    microdnf clean all && \
# Build luarocks
    curl -L -O https://luarocks.org/releases/luarocks-3.8.0.tar.gz && \
    tar zxpf luarocks-3.8.0.tar.gz && \
    cd luarocks-3.8.0 && \
    ./configure --prefix=/opt/luarocks && \
    make -j"$(nproc --all)" && \
    make install

# Add luarocks to PATH and install luacheck
ENV PATH "$PATH:/opt/luarocks/bin"
RUN luarocks install luacheck

# Build final container
FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for CI, testing and soundtrack builds."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-linux-latest"

WORKDIR /
COPY --from=build /opt/luarocks /opt/luarocks 

# Add luarocks to PATH
ENV PATH "$PATH:/opt/luarocks/bin"

# Install Build dependencies.
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install meson ninja-build gcc binutils-devel enet-devel fontconfig-devel freetype-devel \
    gettext-devel glpk-devel file ffmpeg-free libpng12-devel libxml2-devel libvorbis-devel libwebp-devel libunibreak-devel \
    luajit-devel openal-soft-devel openblas-devel pcre2-devel physfs-devel SDL2-devel SDL2_image-devel suitesparse-devel \
# Install utilities
    git libevent lua nano ncurses python3-pyyaml python3-mutagen readline tar texinfo xz unzip zip && \
    microdnf clean all && \
# Verify tool versions and install locations.
    echo "Verifying python install" && \
    command -v python3 && \
    python3 --version && \
    echo "Verifying luacheck install" && \
    command -v luacheck && \
    luacheck --version && \
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version && \
    echo "Verifying ffmpeg install" && \
    command -v ffmpeg && \
    ffmpeg -version

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
