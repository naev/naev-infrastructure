FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used to cross compile for Windows."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-windows"

WORKDIR /tmp
# Install build requirements
# Add COPR repository for missing upstream mingw64 packages.
COPY _copr:copr.fedorainfracloud.org:jackgreiner:mingw64-packages.repo /etc/yum.repos.d
COPY setup-devenv.sh /usr/bin

RUN microdnf update -y && \
    microdnf --nodocs --setopt=install_weak_deps=0 -y install clang gawk gcc gettext git gzip lld llvm python3-pip ninja-build python3-pyyaml rustup tar texinfo xz unzip zip \
# OK, seems like the rust is a bit a of mess as it is trying to compile some things internally with hardcoded mingw64 paths
# We have to toss the dependencies here so that it works. In particular, mlua-sys seems to want to build luajit
    mingw64-binutils mingw64-gcc \
    mingw64-gcc-c++ \
    mingw64-win-iconv \
    libvorbis-devel openal-soft-devel \
# Install mingw64 packages
    mingw64-dlfcn mingw64-enet mingw64-freetype mingw64-libvorbis mingw64-libxml2 mingw64-libtiff mingw64-luajit \
    mingw64-openal-soft mingw64-SDL3 mingw64-libpng mingw32-nsis mingw64-pcre2 mingw64-physfs && \
    microdnf clean all && \
# Install openblas for mingw (building this from source is an option but probably painful)
    curl -L -O https://github.com/OpenMathLib/OpenBLAS/releases/download/v0.3.30/OpenBLAS-0.3.30-x64-64.zip  && \
    unzip OpenBLAS-0.3.30-x64-64.zip -d /usr/x86_64-w64-mingw32/sys-root/mingw && \
    rm -rf OpenBLAS-0.3.30-x64-64.zip && \
# Install windows-targets' windows_x86_64_gnu crate to fix link errors with rust
    curl -L https://crates.io/api/v1/crates/windows_x86_64_gnu/0.52.6/download | tar -xzf - && \
    cp windows_x86_64_gnu-0.52.6/lib/libwindows.0.52.0.a /usr/x86_64-w64-mingw32/sys-root/mingw/lib && \
    rm -rf windows_x86_64_gnu-0.52.6 && \
# Install xmltodict for outfit generation
    python3 -m pip install xmltodict && \
# Need Meson >=1.7.0 for rust_std=2024, but restrict to versions below 1.8.0.
    python3 -m pip install 'meson>=1.7.0,<1.8.0' --upgrade && \
# Verify tool versions and installation locations.
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version
# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
CMD [ "/usr/bin/setup-devenv.sh", "/bin/bash" ]
