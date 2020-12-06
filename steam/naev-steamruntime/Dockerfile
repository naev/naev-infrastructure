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
WORKDIR /usr/src
RUN curl "https://launchpadlibrarian.net/199705878/intltool-0.51.0.tar.gz" -o "intltool-0.51.0.tar.gz" && \
    tar -xvf intltool-0.51.0.tar.gz && rm intltool-0.51.0.tar.gz
WORKDIR /usr/src/intltool-0.51.0
RUN ./configure --prefix=/usr && \
    make install -j"$(nproc --all)"

# Compile OpenSSL from source (required for Python >=3.7).
WORKDIR /usr/local/src
RUN curl "https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz" -o "openssl-1.0.2u.tar.gz" && \
    tar -xvf openssl-1.0.2u.tar.gz && rm openssl-1.0.2u.tar.gz
WORKDIR /usr/local/src/openssl-1.0.2u

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes build-essential checkinstall zlib1g-dev
RUN ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && \
    make -j"$(nproc --all)" && \
    make install

RUN echo "Verifying openssl install" && \
    which /usr/local/ssl/bin/openssl && \
    /usr/local/ssl/bin/openssl version -a

# Compile Python 3.9.0 from source.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes build-essential \
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev
WORKDIR /usr/local/src
RUN curl "https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz" -o "Python-3.9.0.tgz" && \
    tar -xvf Python-3.9.0.tgz && rm Python-3.9.0.tgz
WORKDIR /usr/local/src/Python-3.9.0
RUN PATH="/usr/local/ssl:$PATH"  CPPFLAGS="-I/usr/local/ssl/include" CFLAGS="-I/usr/local/ssl/include/" \
    LDFLAGS="-L/usr/local/ssl/lib -Wl,-rpath,/usr/local/ssl/lib" LD_LIBRARY_PATH=/usr/local/ssl/lib:$LD_LIBRARY_PATH \
    LD_RUN_PATH="/usr/local/ssl/lib" CONFIGURE_OPTS="--with-openssl=/usr/local/ssl" PYTHON_CONFIGURE_OPTS="--enable-shared" \
    ./configure --with-ensurepip=install && \
    make -j"$(nproc --all)" && \
    make altinstall

RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.9 1

RUN echo "Verifying python install" && \
    which python3 && \
    python3 --version

# Install meson via pip.
RUN python3 -m pip install meson

RUN echo "Verifying meson install" && \
    which meson && \
    meson --version

# Cleanup apt cache and remove lists.
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild