# Build dependencies in build container to save space.
FROM registry.gitlab.steamos.cloud/steamrt/sniper/sdk:latest AS build

WORKDIR /tmp
RUN mkdir -p /opt

# Install luarocks deps
RUN apt-get -y install lua5.4 liblua5.4-dev make libncurses-dev libevent-dev libreadline-dev && \
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

# Due to Debian packaging shenanigans, build libunibreak from source..
RUN curl -L -O https://github.com/adah1972/libunibreak/releases/download/libunibreak_5_0/libunibreak-5.0.tar.gz && \
    tar zxpf libunibreak-5.0.tar.gz && \
    cd libunibreak-5.0 && \
    ./configure --prefix=/opt/libs && \
    make -j"$(nproc --all)" && \
    make PREFIX=/opt install

# Due to age of the packaged version of physfs, build libphyfsfs from source..
RUN curl -L -O https://github.com/icculus/physfs/archive/refs/tags/release-3.2.0.tar.gz && \
    tar zxpf release-3.2.0.tar.gz && \
    cd physfs-release-3.2.0 && \
    cmake . -DCMAKE_INSTALL_PREFIX=/opt/libs && \
    make -j"$(nproc --all)" && \
    make install

# Debian's libenet-dev package doesn't provide static versions of enet, build libenet from source..
RUN curl -L -O http://enet.bespin.org/download/enet-1.3.17.tar.gz && \
    tar zxpf enet-1.3.17.tar.gz && \
    cd enet-1.3.17 && \
    ./configure --prefix=/opt/libs && \
    make -j"$(nproc --all)" && \
    make PREFIX=/opt install

FROM registry.gitlab.steamos.cloud/steamrt/sniper/sdk:latest

COPY --from=build /opt/libs /usr
COPY --from=build /opt/luarocks /opt/luarocks

# Add luarocks and friends to PATH
ENV PATH "$PATH:/opt/luarocks/bin"

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for testing linux steam builds in the steamruntime (sniper) environment"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-steamruntime"

# Install pip from steam/debian repositories.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip \
# Install runtime dependencies for luarocks
    lua5.4 \
# Install ffmpeg and python mutagen module for soundtrack generation
    ffmpeg \
# Naughty: we need libluajit-5.1-dev, libglpk-dev and libsuitesparse-dev, not in the SDK.... All are statically linked when building with the steamruntime option in meson set to true. Also, texinfo is an accidental build dependency for libbfd.
    libluajit-5.1-dev libglpk-dev libsuitesparse-dev texinfo && \
    apt-get clean && \
# Install mutagen module for soundtrack generation
    python3 -m pip install mutagen && \
# Need Meson >=1.2.0 for fancy wrap files.
    python3 -m pip install meson --upgrade && \
# Verify meson and python.
    echo "Verifying python install" && \
    command -v python3 && \
    python3 --version && \
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version && \
    echo "Verifying luacheck install" && \
    command -v luacheck && \
    luacheck --version && \
    echo "Verifying ffmpeg install" && \
    command -v ffmpeg && \
    ffmpeg -version

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
