FROM registry.gitlab.steamos.cloud/steamrt/scout/sdk:latest-steam-client-general-availability

LABEL Description="Steam runtime development environment for Naev, various dependencies for testing meson and autotools as well as additional Naev functionality."
LABEL Author="Jack Greiner <jack@emoss.org>"

# Add stable git PPA to sources, as well as the signing key to silence warnings
RUN echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu precise main " | sudo tee -a /etc/apt/sources.list && \
    echo "deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu precise main" | sudo tee -a /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24

# Install m4 macros, autopoint for autotools, and cpanminus to install the XML::Parser module
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes git autoconf-archive autopoint cpanminus

# Install perl module XML::Parser (Installing this via the package libxml-parser-perl throws us into dependency hell.)
RUN cpanm XML::Parser --force

# Install intltool (ditto on the dependency hell).
WORKDIR /tmp
RUN curl "https://launchpadlibrarian.net/199705878/intltool-0.51.0.tar.gz" -o "intltool-0.51.0.tar.gz" && \
    tar -xvf intltool-0.51.0.tar.gz && rm intltool-0.51.0.tar.gz
WORKDIR /tmp/intltool-0.51.0
RUN ./configure --prefix=/usr && \
    make install -j"$(nproc --all)"

# Compile OpenSSL from source (required for Python >=3.7).
#WORKDIR /tmp
#RUN curl "https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz" -o "openssl-1.0.2u.tar.gz" && \
#    tar -xvf openssl-1.0.2u.tar.gz && rm openssl-1.0.2u.tar.gz
#WORKDIR /tmp/openssl-1.0.2u
#
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes build-essential checkinstall zlib1g-dev
#RUN ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && \
#    make -j"$(nproc --all)" && \
#    make install
#
#RUN echo '/usr/local/ssl/lib' | sudo tee -a /etc/ld.so.conf.d/openssl-1.0.2u.conf && ldconfig -v
#RUN export PATH=/usr/local/ssl/bin:$PATH
#
#RUN echo "Verifying openssl install" && \
#    which openssl && \
#    openssl version -a

# Compile Python 3.6.12 from source.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes build-essential \
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev

WORKDIR /tmp
RUN curl "https://www.python.org/ftp/python/3.6.12/Python-3.6.12.tgz" -o "Python-3.6.12.tgz" && \
    tar -xvf Python-3.6.12.tgz && rm Python-3.6.12.tgz
WORKDIR /tmp/Python-3.6.12
RUN ./configure --with-ensurepip=install && \
    make -j"$(nproc --all)" && \
    make altinstall

RUN echo "Verifying python install" && \
    which python3.6 && \
    python3.6 --version

# Install meson via pip.
RUN python3.6 -m pip install meson

RUN echo "Verifying meson install" && \
    which meson && \
    meson --version

# Cleanup apt cache and remove lists.
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Set WORKDIR when you spin up the image, and set CFLAGS so that autotools just works (tm).
RUN mkdir -p /tmp/naevBuild
RUN export CFLAGS="-std=gnu11"
WORKDIR /tmp/naevBuild