FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used to cross compile for Windows."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-windows"

WORKDIR /tmp
# Install build requirements
# Add COPR repository for missing upstream UCRT64 packages.
COPY _copr:copr.fedorainfracloud.org:jackgreiner:ucrt64-libraries.repo /etc/yum.repos.d
COPY setup-devenv.sh /usr/bin

RUN microdnf update -y && \
    microdnf --nodocs --setopt=install_weak_deps=0 -y install clang gcc gettext git lld llvm meson ninja-build python3-pyyaml rustup tar texinfo xz unzip zip \
# OK, seems like the rust is a bit a of mess as it is trying to compile some things internally with hardcoded mingw64 paths
# We have to toss the dependencies here so that it works. In particular, mlua-sys seems to want to build luajit
# Would make sense to try to use either only ucrt64 or mingw64 stuff someday
    mingw64-binutils mingw64-gcc \
    mingw64-libvorbis mingw64-win-iconv mingw64-openal-soft \
    libvorbis-devel openal-soft-devel \
# Install mingw64 packages
    ucrt64-gcc ucrt64-gcc-c++ ucrt64-dlfcn ucrt64-enet ucrt64-freetype ucrt64-libvorbis ucrt64-libxml2 ucrt64-libtiff \
    ucrt64-openal-soft ucrt64-SDL2 ucrt64-SDL2_image ucrt64-libpng mingw32-nsis ucrt64-pcre2 ucrt64-physfs && \
    microdnf clean all && \
# Install openblas for mingw (building this from source is an option but probably painful)
    curl -L -O https://github.com/OpenMathLib/OpenBLAS/releases/download/v0.3.28/OpenBLAS-0.3.28-x64-64.zip && \
    unzip OpenBLAS-0.3.28-x64-64.zip -d /usr/x86_64-w64-mingw32ucrt/sys-root/mingw && \
    rm -rf OpenBLAS-0.3.28-x64-64.zip

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
CMD [ "/usr/bin/setup-devenv.sh", "/bin/bash" ]
