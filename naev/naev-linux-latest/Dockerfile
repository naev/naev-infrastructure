FROM ubuntu:20.04

LABEL org.opencontainers.image.authors "Jack Greiner <jack@emoss.org>" 
LABEL org.opencontainers.image.source "https://github.com/ProjectSynchro/synchros-sexy-docker-containers" 
LABEL org.opencontainers.image.description "Naev Linux (Latest) development/testing environment for Naev (For CI and testing)"

# Add stable git PPA, deadsnakes ppa for python builds, and llvm apt repository (no building from source yay!)
RUN apt-get update && apt-get install -y software-properties-common curl apt-transport-https && \
    apt-add-repository ppa:git-core/ppa && add-apt-repository ppa:deadsnakes/ppa && \
    curl -sL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    curl -sL https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    add-apt-repository -s 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal main' && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update

# Install Build dependencies and utilities.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autopoint autoconf-archive binutils-dev \
    build-essential doxygen clang cmake ffmpeg git graphviz intltool lldb lld libfreetype6-dev libluajit-5.1-dev \
    libopenal-dev libpng-dev libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsuitesparse-dev libvorbis-dev \
    libxml2-dev lua-ldoc nano ninja-build vim wget xvfb

# Install Python 3.9.* from deadsnakes PPA.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3.9-dev python3.9-venv python3-pip
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1 && \
    python3 -m pip install --upgrade pip && \
    echo "Verifying python install" && \
    which python3 && \
    python3 --version && \
    echo "Verifying pip install" && \
    python3 -m pip --version
    
# Install Mutagen for soundtrack generation via pip.
RUN python3 -m pip install mutagen

# Install meson via pip.
RUN python3 -m pip install meson && \
    echo "Verifying meson install" && \
    which meson && \
    meson --version

# Clone naev-website git repository
WORKDIR /tmp
RUN git clone https://github.com/naev/naev-website.git

# Install Website Build dependencies and gems.
WORKDIR /tmp/naev-website
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ruby ruby-dev tidy && \
    gem install bundler && bundle install -j"$(nproc --all)"

# Cleanup apt cache, remove APT lists, and temporary git repo.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/naev-website

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
