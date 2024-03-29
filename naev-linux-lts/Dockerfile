FROM centos:7

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for release builds. oldest targetted glibc platform"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-linux-lts"

WORKDIR /tmp
# Enable the EPEL and End Point repositories for additional up-to-date tools.
RUN yum -y install epel-release && \
    curl -L -O https://packages.endpointdev.com/endpoint-rpmsign-7.pub &&\
    rpm --import endpoint-rpmsign-7.pub && \
    curl -L -O https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm && \
    rpm -i endpoint-repo.x86_64.rpm && \
    rm -rf /tmp/endpoint-repo.x86_64.rpm endpoint-rpmsign-7.pub && \
# Install Build dependencies.
    yum -y install meson ninja-build gcc binutils-devel enet-devel fontconfig-devel freetype-devel \
    gettext-devel glpk-devel file libpng12-devel libxml2-devel libvorbis-devel libwebp-devel \
    libunibreak-devel luajit-devel openal-soft-devel openblas-devel pcre2-devel SDL2-devel \
    SDL2_image-devel \
# Install utilities
    git nano tar texinfo xz unzip zip && \
    yum clean all && \
# Install pyyaml
    python3 -m pip install PyYAML && \
# Verify python version and install location.
    echo "Verifying python install" && \
    command -v python3 && \
    python3 --version && \
# Verify meson version and installation.
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version && \
# Verify git version and installation.
    echo "Verifying git install" && \
    command -v git && \
    git --version

# Fix a missing pkgconfig file (that e.g. Fedora's version of the package would have installed).
COPY <<EOF /usr/lib64/pkgconfig/libenet.pc
prefix=/usr
exec_prefix=/usr
libdir=/usr/lib64
includedir=/usr/include

Name: libenet
Description: Low-latency UDP networking library supporting optional reliability
Version: 1.3.11
Cflags: -I\${includedir}
Libs: -L\${libdir} -lenet
EOF
    
# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
