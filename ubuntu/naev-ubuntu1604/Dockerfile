FROM ubuntu:16.04

LABEL Jack Greiner <jack@emoss.org>

RUN apt-get update
RUN apt-get install -y software-properties-common && apt-add-repository ppa:git-core/ppa
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autopoint binutils-dev build-essential clang gettext git intltool libfreetype6-dev libgl1-mesa-dev libiberty-dev libluajit-5.1-dev libopenal-dev libpng-dev libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsuitesparse-dev libvorbis-dev libxml2-dev python3-pip python3-setuptools python3-wheel
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y lua-ldoc graphviz doxygen
RUN DEBIAN_FRONTEND=noninteractive apt-get -t xenial-backports install -y ninja-build
RUN pip3 install meson

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
