FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "For website and documentation builds."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-docs"

# Install Ruby packages
RUN microdnf -y install automake findutils gcc g++ make redhat-rpm-config ruby-devel rubygem-bundler rubygem-json rubygem-ffi rubygem-racc \
# Install utilities
    meson ninja-build git GraphicsMagick optipng rsync tidy tar unzip wget which zip \
# Install luarocks deps
    compat-lua compat-lua-devel ncurses-devel libevent-devel readline-devel && \
    microdnf clean all && \
# Build luarocks (In this case for lua 5.1 and lua latest)
    curl -L -O https://luarocks.org/releases/luarocks-3.8.0.tar.gz && \
    tar zxpf luarocks-3.8.0.tar.gz && \
    cd luarocks-3.8.0 && \
    ./configure --prefix=/opt/luarocks --lua-version=5.1 --lua-suffix=-5.1 --versioned-rocks-dir && \
    make && \
    make install && \
    cd /tmp && \
    rm -rf /tmp/*

# Add luarocks to PATH
ENV PATH "$PATH:/opt/luarocks/bin"

# Install ldoc and luacheck lua rocks.
RUN luarocks install ldoc

# Copy Gemfile
RUN mkdir websiteTemp && \
    git clone --recurse https://github.com/naev/naev-website.git websiteTemp && \
# Install Website Build dependencies and gems.
    cd websiteTemp && \
    bundle install -j"$(nproc --all)" && \
    rm -rf /tmp/websiteTemp

# Verify tool versions and install locations.
RUN echo "Verifying ruby install" && \
    which ruby && \
    ruby --version && \
    echo "Verifying bundler install" && \
    which bundle && \
    bundle --version && \
    echo "Verifying ldoc install" && \
    which python3
    
# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
