# Build dependencies in build container to save space.
FROM registry.gitlab.steamos.cloud/steamrt/sniper/sdk:latest AS build

WORKDIR /tmp
RUN mkdir -p /opt

# Install llvm and lld build tools
RUN apt-get -y install \
        lld llvm

ENV CC clang
ENV CXX clang++
ENV AR llvm-ar
ENV NM llvm-nm
ENV RANLIB llvm-ranlib
ENV STRIP llvm-strip
ENV LD ld.lld

ENV CFLAGS "-fPIC"
ENV CXXFLAGS "-fPIC"

# Install luarocks deps
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install lua5.4 liblua5.4-dev make libncurses-dev libevent-dev libreadline-dev && \
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
RUN curl -L -O https://github.com/adah1972/libunibreak/releases/download/libunibreak_6_1/libunibreak-6.1.tar.gz && \
    tar zxpf libunibreak-6.1.tar.gz && \
    cd libunibreak-6.1 && \
    ./configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu/ --disable-shared --enable-static && \
    make -j"$(nproc --all)" && \
    DESTDIR=/opt/libs make install

# Install ffmpeg build requirements
RUN apt-get -y install \
        autoconf \
        automake \
        build-essential \
        cmake \
        git-core \
        libass-dev \
        libfreetype6-dev \
        libgnutls28-dev \
        libmp3lame-dev \
        libsdl2-dev \
        libtool \
        libva-dev \
        libvdpau-dev \
        libvorbis-dev \
        libxcb1-dev \
        libxcb-shm0-dev \
        libxcb-xfixes0-dev \
        meson \
        ninja-build \
        pkg-config \
        texinfo \
        wget \
        yasm \
        zlib1g-dev && \
# Due to missing packaging shenanigans, build ffmpeg from source..
    curl -L -O https://www.ffmpeg.org/releases/ffmpeg-7.0.2.tar.gz && \
    tar zxpf ffmpeg-7.0.2.tar.gz && \
    cd ffmpeg-7.0.2 && \
    ./configure --prefix=/opt/ffmpeg \
        --pkg-config-flags="--static" \
        --extra-libs="-lpthread -lm -lz" \
        --extra-ldexeflags="-static" \
        --disable-shared \
        --enable-static \
        --disable-doc \
        --disable-ffplay \
        --disable-devices \
        --enable-libmp3lame \
        --enable-libvorbis && \
    make -j"$(nproc --all)" && \
    make install

# Due to age of the packaged version of physfs, build libphyfsfs from source..
RUN curl -L -O https://github.com/icculus/physfs/archive/refs/tags/release-3.2.0.tar.gz && \
    tar zxpf release-3.2.0.tar.gz && \
    cd physfs-release-3.2.0 && \
    cmake . -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu/ -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON && \
    make -j"$(nproc --all)" && \
    DESTDIR=/opt/libs make install

# Debian's libenet-dev package doesn't provide static versions of enet, build libenet from source..
RUN curl -L -O http://enet.bespin.org/download/enet-1.3.17.tar.gz && \
    tar zxpf enet-1.3.17.tar.gz && \
    cd enet-1.3.17 && \
    ./configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu/ --disable-shared --enable-static && \
    make -j"$(nproc --all)" && \
    DESTDIR=/opt/libs make install

# Due to age of the packaged version of openal, build libopenal from source..
RUN curl -L -O https://github.com/kcat/openal-soft/archive/refs/tags/1.24.2.tar.gz && \
    tar zxpf 1.24.2.tar.gz && \
    cd openal-soft-1.24.2 && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu/ -DALSOFT_UTILS=OFF -DALSOFT_EXAMPLES=OFF && \
    make -j"$(nproc --all)" && \
    DESTDIR=/opt/libs make install

FROM registry.gitlab.steamos.cloud/steamrt/sniper/sdk:latest

# Copy over the built dependencies from the build container
COPY --from=build /opt/luarocks /opt/luarocks
COPY --from=build /opt/ffmpeg /opt/ffmpeg
COPY setup-devenv.sh /usr/bin

# Add luarocks and friends to PATH
ENV PATH "$PATH:/opt/luarocks/bin:/opt/ffmpeg/bin"

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for testing linux steam builds in the steamruntime (sniper) environment"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-steamruntime"

# Remove libopenal-dev and libopenal1, as we want to use our own built version.
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get remove -y libopenal* && \
    apt-get clean
COPY --from=build /opt/libs/usr/ /usr

# Install pip from steam/debian repositories.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip \
# Install LLVM and LLD for clang and friends
    lld llvm \
# Install runtime dependencies for luarocks
    lua5.4 \
# Naughty: we need libluajit-5.1-dev, libglpk-dev and libsuitesparse-dev, not in the SDK.... All are statically linked when building with the steamruntime option in meson set to true. Also, texinfo is an accidental build dependency for libbfd.
    libluajit-5.1-dev libglpk-dev libsuitesparse-dev texinfo && \
    apt-get clean && \
# Install mutagen module for soundtrack generation
    python3 -m pip install mutagen && \
# Need Meson >=1.7.0 for rust_std=2024, which is obviously not up-to-date in steamOS
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
CMD [ "/usr/bin/setup-devenv.sh", "/bin/bash" ]
