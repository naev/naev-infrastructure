# Build dependencies in build container to save space.
FROM registry.gitlab.steamos.cloud/steamrt/scout/sdk:latest AS build 

WORKDIR /tmp
RUN mkdir -p /opt

# Prep builder for building tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gfortran-4.8 liblzma-dev

# Grab and compile Python 3.6 (Why 3.6 you might ask?: OpenSSL requirements changed with Python 3.7 and we are in an A N C I E N T environment, so one can connect the dots.)
RUN curl -L -O https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tgz && \
    tar zxpf Python-3.6.15.tgz && \
    cd Python-3.6.15 && \
    ./configure --prefix=/opt && \
    make -j"$(nproc --all)" && \
    make altinstall

# Unfortunately we have to compile OpenBLAS from source..
RUN curl -L -O https://github.com/xianyi/OpenBLAS/releases/download/v0.3.23/OpenBLAS-0.3.23.tar.gz && \
    tar zxpf OpenBLAS-0.3.23.tar.gz && \
    cd OpenBLAS-0.3.23 && \
    DYNAMIC_ARCH=1 DYNAMIC_OLDER=1 FC=gfortran-4.8 TARGET=GENERIC USE_OPENMP=0 make -j"$(nproc --all)" && \
    make PREFIX=/opt install

# Due to Debian packaging shenanigans, build libunibreak from source..
RUN curl -L -O https://github.com/adah1972/libunibreak/releases/download/libunibreak_5_0/libunibreak-5.0.tar.gz && \
    tar zxpf libunibreak-5.0.tar.gz && \
    cd libunibreak-5.0 && \
    ./configure --prefix=/opt && \
    make -j"$(nproc --all)" && \
    make PREFIX=/opt install

# Due to age of the image base, build libpcre2 from source..
RUN curl -L -O https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.gz && \
    tar zxpf pcre2-10.42.tar.gz && \
    cd pcre2-10.42 && \
    ./configure --prefix=/opt && \
    make -j"$(nproc --all)" && \
    make PREFIX=/opt install

# Due to age of the image base, build libenet from source..
RUN curl -L -O http://enet.bespin.org/download/enet-1.3.17.tar.gz && \
    tar zxpf enet-1.3.17.tar.gz && \
    cd enet-1.3.17 && \
    ./configure --prefix=/opt && \
    make -j"$(nproc --all)" && \
    make PREFIX=/opt install 

# Due to age of the image base, build libphyfsfs from source..
RUN curl -L -O https://github.com/icculus/physfs/archive/refs/tags/release-3.2.0.tar.gz && \
    tar zxpf release-3.2.0.tar.gz && \
    cd physfs-release-3.2.0 && \
    cmake . -DCMAKE_INSTALL_PREFIX=/opt && \
    make -j"$(nproc --all)" && \
    make install

FROM registry.gitlab.steamos.cloud/steamrt/scout/sdk:latest

COPY --from=build /opt /usr

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for linux steam builds in the steamruntime (scout) environment, lots of nasty hacks here.. don't look."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-steamfrankenruntime"

# Add official ppa repository that provides Git 2.19 and update
RUN echo "deb https://ppa.launchpadcontent.net/git-core/ppa/ubuntu precise main " | sudo tee -a /etc/apt/sources.list.d/git-core.list && \
    echo "deb-src https://ppa.launchpadcontent.net/git-core/ppa/ubuntu precise main " | sudo tee -a /etc/apt/sources.list.d/git-core.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24 && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --only-upgrade -y git && \
    DEBIAN_FRONTEND=noninteractive apt-get remove -y meson && \

# Install additional packaged deps from steamrt/debian repositories.
# Naughty: we need libluajit-5.1, and gfortran (extended dependency of OpenBLAS), not in the SDK.... All are statically linked when building with the steamruntime option in meson set to true. Also, texinfo is an accidental build dependency for libbfd.
    DEBIAN_FRONTEND=noninteractive apt-get install -y gfortran-4.8 libluajit-5.1-dev liblzma-dev texinfo && \
    apt-get clean && \
# Upgrade meson via pip.
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 10 && \
    python3 -m pip install meson --upgrade && \
# Install pyyaml
    python3 -m pip install pyyaml && \
    echo "Verifying python install" && \
    command -v python3 && \
    python3 --version && \
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version
    
# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
