FROM fedora:rawhide

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Naev Linux (Latest) development/testing environment for Naev (For CI, testing and website builds)"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-linux-latest"

# Enable RPMFusion for additional up-to-date tools.
RUN dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Install Build dependencies and utilities.
RUN dnf -y groupinstall "Development Tools"

RUN dnf -y install gettext-devel autoconf-archive binutils-devel \
    doxygen clang cmake ffmpeg git glpk-devel graphviz intltool lldb llvm freetype-devel luajit-devel \
    openal-soft-devel openblas-devel libpng-devel libwebp-devel lua-ldoc SDL2-devel SDL2_image-devel \
    SDL2_mixer-devel libunibreak-devel libvorbis-devel libxml2-devel meson mesa-libGLU-devel nano ninja-build \
    physfs-devel python-mutagen suitesparse-devel tidy optipng nodejs ImageMagick rsync vim wget xorg-x11-server-Xvfb

# Install SteamCMD and friends
RUN dnf -y install glibc.i686 libstdc++.i686 SDL2.i686

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

# Install Ruby and Rubygems packages
RUN dnf -y install redhat-rpm-config ruby-devel rubygem-bundler rubygem-json rubygem-ffi rubygem-racc

# Verify python version and install location.
RUN echo "Verifying python install" && \
    which python3 && \
    python3 --version

# Verify ruby version and install location.
RUN echo "Verifying ruby install" && \
    which ruby && \
    ruby --version

# Verify bundler version and install location.
RUN echo "Verifying bundler install" && \
    which bundle && \
    bundle --version

# Verify meson version and installation.
RUN echo "Verifying meson install" && \
    which meson && \
    meson --version

# Verify SteamCMD version and installation.
RUN echo "Verifying steamcmd install" && \
    which steamcmd && \
    steamcmd +quit

# Verify Butler version and installation.
RUN echo "Verifying butler install" && \
    which butler && \
    butler -V

# Copy Gemfile
WORKDIR /tmp
RUN mkdir websiteTemp

COPY Gemfile /tmp/websiteTemp

# Install Website Build dependencies and gems.
WORKDIR /tmp/websiteTemp
RUN bundle install -j"$(nproc --all)"

# Cleanup dnf cache
RUN dnf clean all && \
    rm -rf /tmp/websiteTemp && \
    rm /tmp/butler.zip && \
    rm /tmp/steamcmd_linux.tar.gz

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
