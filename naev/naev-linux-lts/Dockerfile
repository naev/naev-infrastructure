FROM centos:7

LABEL org.opencontainers.image.authors "Jack Greiner <jack@emoss.org>" 
LABEL org.opencontainers.image.source "https://github.com/ProjectSynchro/synchros-sexy-docker-containers" 
LABEL org.opencontainers.image.description "Naev Linux (LTS) development/testing environment for Naev (releases and testing)"

# Enable the EPEL repository
RUN yum -y install epel-release

# Enable RPMFusion, End Point repository for additional up-to-date tools.
RUN yum -y localinstall --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm

# Install Build dependencies and utilities.
RUN yum -y groupinstall "Development Tools"

RUN yum install -y gettext-devel autoconf-archive binutils-devel \
    doxygen clang cmake ffmpeg git graphviz intltool lldb llvm freetype-devel luajit-devel \
    openal-soft-devel libpng-devel lua-devel luarocks SDL2-devel SDL2_image-devel SDL2_mixer-devel libvorbis-devel \
    libxml2-devel meson nano ninja-build python-mutagen suitesparse-devel tidy vim wget xorg-x11-server-Xvfb

# Install ldoc from luarocks
RUN luarocks install ldoc

# Verify python version and install location.
RUN echo "Verifying python install" && \
    which python3 && \
    python3 --version

# Verify meson version and installation.
RUN echo "Verifying meson install" && \
    which meson && \
    meson --version

# Cleanup yum cache
RUN yum clean all

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
