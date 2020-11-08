FROM registry.gitlab.steamos.cloud/steamrt/scout/sdk:latest-steam-client-general-availability

LABEL Description="Steam runtime development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."
LABEL Author="Jack Greiner <jack@emoss.org>"

RUN apt-get update
RUN apt-get install -y software-properties-common && apt-add-repository ppa:git-core/ppa
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autopoint binutils-dev build-essential clang gettext git intltool libfreetype6-dev libgl1-mesa-dev libiberty-dev libluajit-5.1-dev libopenal-dev libpng-dev libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libvorbis-dev libxml2-dev ninja-build
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y lua-ldoc graphviz doxygen
RUN pip3 install meson

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
