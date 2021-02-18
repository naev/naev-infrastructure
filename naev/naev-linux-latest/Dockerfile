FROM fedora:rawhide

LABEL org.opencontainers.image.authors "Jack Greiner <jack@emoss.org>" 
LABEL org.opencontainers.image.source "https://github.com/ProjectSynchro/synchros-sexy-docker-containers" 
LABEL org.opencontainers.image.description "Naev Linux (Latest) development/testing environment for Naev (For CI and testing)"

# Enable RPMFusion for additional up-to-date tools.
RUN dnf -y --nogpgcheck install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Install Build dependencies and utilities.
RUN dnf -y --nogpgcheck groupinstall "Development Tools"

RUN dnf -y --nogpgcheck install gettext-devel autoconf-archive binutils-devel \
    doxygen clang cmake ffmpeg git graphviz intltool lldb llvm freetype-devel luajit-devel \
    openal-soft-devel libpng-devel lua-ldoc SDL2-devel SDL2_image-devel SDL2_mixer-devel libvorbis-devel \
    libxml2-devel meson nano ninja-build physfs-devel python-mutagen suitesparse-devel tidy vim wget xorg-x11-server-Xvfb

# Install Ruby and Rubygems packages
RUN dnf -y --nogpgcheck install redhat-rpm-config ruby-devel rubygem-bundler rubygem-json rubygem-ffi rubygem-racc

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

# Clone naev-website git repository
WORKDIR /tmp
RUN git clone https://github.com/naev/naev-website.git

# Install Website Build dependencies and gems.
WORKDIR /tmp/naev-website
RUN bundle install -j"$(nproc --all)"

# Cleanup dnf cache
RUN dnf clean all && \
    rm -rf /tmp/naev-website

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
