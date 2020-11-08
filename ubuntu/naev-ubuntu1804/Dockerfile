FROM ubuntu:18.04

LABEL Description="Ubuntu development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."
LABEL Author="Jack Greiner <jack@emoss.org>"

RUN software-properties-common && apt-add-repository ppa:git-core/ppa && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autopoint binutils-dev \
    build-essential clang gettext git intltool libfreetype6-dev libgl1-mesa-dev \
    libiberty-dev libluajit-5.1-dev libopenal-dev libpng-dev libsdl2-dev \
    libsdl2-image-dev libsdl2-mixer-dev libsuitesparse-dev libvorbis-dev \
    libxml2-dev llvm ninja-build python3-pip python3-setuptools python3-wheel \
    lua-ldoc graphviz doxygen

RUN pip3 install meson

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
