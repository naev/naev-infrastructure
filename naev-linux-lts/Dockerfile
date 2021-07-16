FROM centos:7

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Naev Linux (LTS) development/testing environment for Naev (releases and testing)"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-linux-lts"

# Enable the EPEL repository
RUN yum -y install epel-release

# Enable RPMFusion, End Point repository for additional up-to-date tools.
RUN yum -y localinstall --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm

# Install Build dependencies and utilities.
RUN yum -y groupinstall "Development Tools"

RUN yum install -y gettext-devel autoconf-archive binutils-devel \
    doxygen clang cmake ffmpeg git glpk-devel graphviz intltool lldb llvm freetype-devel luajit-devel \
    openal-soft-devel libpng-devel libwebp-devel lua-devel luarocks SDL2-devel \
    SDL2_image-devel SDL2_mixer-devel libvorbis-devel libxml2-devel meson \
    mesa-libGL-devel mesa-libGLU-devel nano ninja-build openblas-devel python-mutagen suitesparse-devel tidy \
    optipng nodejs ImageMagick rsync vim wget xorg-x11-server-Xvfb

# Install ldoc from luarocks
RUN luarocks install ldoc

# Install SteamCMD and friends
RUN yum install -y glibc.i686 libstdc++.i686 SDL2.i686

WORKDIR /tmp
RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    mkdir -p /opt/steamcmd && \
    tar -xvzf steamcmd_linux.tar.gz -C /opt/steamcmd

WORKDIR /opt/steamcmd
RUN mv steam.sh steam && mv steamcmd.sh steamcmd

# Add SteamCMD to PATH
ENV PATH "$PATH:/opt/steamcmd"

# Install itch.io butler
WORKDIR /tmp
RUN wget https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default -O butler.zip && \
    mkdir -p /opt/butler && \
    unzip butler.zip -d /opt/butler

WORKDIR /opt/butler
RUN chmod +x butler

# Add Butler to PATH
ENV PATH "$PATH:/opt/butler"

# Verify python version and install location.
RUN echo "Verifying python install" && \
    which python3 && \
    python3 --version

# Verify meson version and installation.
RUN echo "Verifying meson install" && \
    which meson && \
    meson --version

# Verify git version and installation.
RUN echo "Verifying git install" && \
    which git && \
    git --version

# Verify SteamCMD version and installation.
RUN echo "Verifying steamcmd install" && \
    which steamcmd && \
    steamcmd +quit

# Verify Butler version and installation.
RUN echo "Verifying butler install" && \
    which butler && \
    butler -V
    
# Cleanup yum cache and utility temp files
RUN yum clean all && \
    rm /tmp/butler.zip && \
    rm /tmp/steamcmd_linux.tar.gz

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
