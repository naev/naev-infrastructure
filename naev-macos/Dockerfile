# Build toolchain in build container to save space.
FROM registry.fedoraproject.org/fedora-minimal:41 AS build

# Install Build dependencies and utilities.
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install bzip2 clang-devel cmake gawk git gzip lld file findutils patch python3 \
    openssl openssl-devel xz-devel libxml2-devel uuid-devel unzip tar xz zlib-devel && \
    microdnf clean all && \
# Verify tool / language versions versions.
    echo "Verifying clang install" && \
    command -v clang && \
    clang --version && \
    echo "Verifying cmake install" && \
    command -v cmake && \
    cmake --version && \
    echo "Verifying python install" && \
    command -v python3 && \
    python3 --version

# Git clone libdmg-hfsplus repo
WORKDIR /usr/local/src
RUN git clone https://github.com/fanquake/libdmg-hfsplus.git
WORKDIR /usr/local/src/libdmg-hfsplus
RUN mkdir build && cd build && \
    cmake .. && \
    make && make install

# Git clone osxcross repo
WORKDIR /usr/local/src
RUN git clone https://github.com/tpoechtrager/osxcross.git && \
    cd osxcross && git checkout master

# Use my fork of OSXCross until https://github.com/tpoechtrager/osxcross/pull/459 is pulled upstream.
#RUN git clone https://github.com/ProjectSynchro/osxcross.git && \
#    cd osxcross && git checkout master

# Copy MacOS SDK tarball
COPY MacOSX14.sdk.tar.xz /usr/local/src/osxcross/tarballs

# Build toolchain
WORKDIR /usr/local/src/osxcross
RUN TARGET_DIR=/usr/lib/osxcross UNATTENDED=1 ./build.sh

# Add osxcross to PATH
ENV PATH "$PATH:/usr/lib/osxcross/bin"

ENV OSXCROSS_MP_INC "1"

# Set MACOSX_DEPLOYMENT_TARGET
ENV MACOSX_DEPLOYMENT_TARGET "10.13"

# Install required build dependencies
RUN UNATTENDED=1 osxcross-macports install freetype glpk libsdl2 libsdl2_image libpng \
    libvorbis luajit openal-soft OpenBLAS pcre2 physfs SuiteSparse_CHOLMOD SuiteSparse_CXSparse webp -v && \
    UNATTENDED=1 osxcross-macports clear-cache && \
    mv /usr/lib/osxcross/macports /usr/lib/osxcross/macports.x86_64

# Set MACOSX_DEPLOYMENT_TARGET for AARCH64
ENV MACOSX_DEPLOYMENT_TARGET "13.0"

# Install required build dependencies
RUN UNATTENDED=1 osxcross-macports install -arm64 freetype glpk libsdl2 libsdl2_image libpng \
    libvorbis luajit openal-soft OpenBLAS pcre2 physfs SuiteSparse_CHOLMOD SuiteSparse_CXSparse webp -v && \
    UNATTENDED=1 osxcross-macports clear-cache && \
    mv /usr/lib/osxcross/macports /usr/lib/osxcross/macports.aarch64

# Download and install rcodesign
RUN curl -L -O https://github.com/indygreg/apple-platform-rs/releases/download/apple-codesign%2F0.29.0/apple-codesign-0.29.0-x86_64-unknown-linux-musl.tar.gz && \
    mkdir -p /opt/apple-codesign && \
    tar --strip-components=1 -xvzf apple-codesign-0.29.0-x86_64-unknown-linux-musl.tar.gz -C /opt/apple-codesign && \
    rm apple-codesign-0.29.0-x86_64-unknown-linux-musl.tar.gz

# Build final container
FROM registry.fedoraproject.org/fedora-minimal:41

WORKDIR /
COPY --from=build /usr/lib/osxcross /usr/lib/osxcross
COPY --from=build /usr/local/bin/dmg /usr/bin
COPY --from=build /opt/apple-codesign/rcodesign /usr/bin
COPY setup-devenv.sh /usr/bin

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used to cross compile for macOS."

# Set deployment target for AARCH64 and x86_64 for use with entrypoint
# Make sure these follow the values in the build container above ^
ENV AARCH64_DEPLOYMENT_TARGET "13.0"
ENV X86_64_DEPLOYMENT_TARGET "10.13"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-macos"

# Add OSXCROSS to path
ENV PATH "$PATH:/usr/lib/osxcross/bin"

# Ensure macports includes are enabled by default
ENV OSXCROSS_MP_INC "1"

# Force appimages to extract to get around a lack of FUSE in docker. (without some ####ery at least.)
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Install build tools.
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install clang-devel cmake gettext genisoimage gawk git gzip lld ninja-build python3-pip python3-pyyaml rustup unzip tar texinfo xz zlib zip && \
    microdnf clean all && \
# Install xmltodict for outfit generation
    python3 -m pip install xmltodict && \
# Need Meson >=1.7.0 for rust_std=2024, but restrict to versions below 1.8.0.
    python3 -m pip install 'meson>=1.7.0,<1.8.0' --upgrade && \
# Verify tool versions and installation locations.
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version && \
    echo "Verifying dmg install" && \
    command -v dmg && \
# Horrible hack: ensure a hardcoded header file path resolves.
    rmdir /opt && ln -s /usr/lib/osxcross/macports/pkgs/opt /opt && \
# Set WORKDIR when you spin up the image.
    mkdir -p /tmp/naevBuild

WORKDIR /tmp/naevBuild
CMD [ "/usr/bin/setup-devenv.sh", "/bin/bash" ]
