FROM ubuntu:20.04

LABEL Description="MacOS cross-compile development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."
LABEL Author="Jack Greiner <jack@emoss.org>"

# Add stable git PPA, deadsnakes ppa for python builds, and llvm apt repository (no building from source yay!)
RUN apt-get update && apt-get install -y software-properties-common curl apt-transport-https && \
    apt-add-repository ppa:git-core/ppa && add-apt-repository ppa:deadsnakes/ppa && \
    curl -sL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    curl -sL https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    add-apt-repository -s 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal main' && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update

# Install Build dependencies and utilities.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y bash clang cmake git patch libssl-dev llvm-dev lzma-dev libxml2-dev ninja-build

# Install Python 3.9.* from deadsnakes PPA.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3.9-dev python3.9-venv python3-pip
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1 && \
    python3 -m pip install --upgrade pip && \
    echo "Verifying python install" && \
    which python3 && \
    python3 --version && \
    echo "Verifying pip install" && \
    python3 -m pip --version
    
# Install meson via pip.
RUN python3 -m pip install meson && \
    echo "Verifying meson install" && \
    which meson && \
    meson --version

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
