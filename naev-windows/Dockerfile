FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used to cross compile for Windows."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-windows"

WORKDIR /tmp
# Install build requirements
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install gcc gettext git meson ninja-build python3-pyyaml tar texinfo xz unzip zip \
# Install mingw64 packages
# Note to selves: mingw64-dlfcn is:
# - to be added with great caution in any case: Fedora's hardened build flags make it depend on libssp-0.dll,
#   and test-runs under Wine 7.12 showed a startup hang if libssp-0.dll was bundled (as our installer does).
    mingw64-gcc mingw64-dlfcn mingw64-freetype mingw64-libvorbis mingw64-libxml2 mingw64-openal-soft \
    mingw64-SDL2 mingw64-SDL2_image mingw64-libpng mingw32-nsis mingw64-pcre2 mingw64-physfs && \
    microdnf clean all && \
# Install openblas for mingw (building this from source is an option but probably painful)
    curl -L -O https://github.com/OpenMathLib/OpenBLAS/releases/download/v0.3.26/OpenBLAS-0.3.26-x64.zip && \
    unzip OpenBLAS-0.3.26-x64.zip -d /usr/x86_64-w64-mingw32/sys-root/mingw && \
    rm -rf OpenBLAS-0.3.26-x64.zip && \
# Install cross-build of enet
    curl -L -O http://enet.bespin.org/download/enet-1.3.17.tar.gz && \
    tar zxf enet-1.3.17.tar.gz && \
    cd enet-1.3.17 && \
    ./configure --prefix=/usr/x86_64-w64-mingw32/sys-root/mingw --host=x86_64-w64-mingw32 && \
    make -j && \
    make install && \
    sed -i 's/-lenet/-lenet -lws2_32 -lwinmm/' /usr/x86_64-w64-mingw32/sys-root/mingw/lib/pkgconfig/libenet.pc && \
    cd .. && \
    rm -rf enet-1.3.17 enet-1.3.17.tar.gz

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
