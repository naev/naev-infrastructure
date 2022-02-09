# Build luarocks and ruby in build container to save space.
FROM registry.fedoraproject.org/fedora-minimal:latest AS build 

# Install luarocks deps
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install findutils gcc git gzip compat-lua \
    compat-lua-devel make ncurses-devel libevent-devel openssl openssl-devel readline-devel tar unzip automake findutils g++ && \
    microdnf clean all

# Build luarocks
RUN curl -L -O https://luarocks.org/releases/luarocks-3.8.0.tar.gz && \
    tar zxpf luarocks-3.8.0.tar.gz && \
    cd luarocks-3.8.0 && \
    ./configure --prefix=/opt/luarocks --lua-version=5.1 --lua-suffix=-5.1 --versioned-rocks-dir && \
    make -j"$(nproc --all)" && \
    make install

# Add luarocks to PATH and install luacheck
ENV PATH "$PATH:/opt/luarocks/bin"
RUN luarocks install ldoc

# Build Ruby
RUN curl -L -O https://cache.ruby-lang.org/pub/ruby/snapshot/snapshot-ruby_3_0.tar.gz && \
    tar zxpf snapshot-ruby_3_0.tar.gz && \
    cd snapshot-ruby_3_0 && \
    ./configure --prefix=/opt/ruby && \
    make -j"$(nproc --all)" && \
    make install

# Add ruby to PATH and install bundler
ENV PATH "$PATH:/opt/ruby/bin"
RUN gem install bundler

RUN mkdir websiteTemp && \
    git clone --recurse https://github.com/naev/naev-website.git websiteTemp && \
# Install Website Build gems.
    cd websiteTemp && \
    bundle install -j"$(nproc --all)" && \
    rm -rf /tmp/websiteTemp

# Build final container
FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for building website and docs."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-docs"

WORKDIR /
COPY --from=build /opt/luarocks /opt/luarocks 
COPY --from=build /opt/ruby /opt/ruby

# Add luarocks to PATH
ENV PATH "$PATH:/opt/luarocks/bin"

# Add ruby to PATH
ENV PATH "$PATH:/opt/ruby/bin"

# Install utilities
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install make meson ninja-build gcc git GraphicsMagick openssl optipng \
    python3-pyyaml rsync tidy tar unzip xz zip \
# Install luarocks deps
    compat-lua ncurses libevent readline && \
    microdnf clean all && \
# Verify tool versions and install locations.
    echo "Verifying ruby install" && \
    command -v ruby && \
    ruby --version && \
    echo "Verifying bundler install" && \
    command -v bundle && \
    bundle --version && \
    echo "Verifying ldoc install" && \
    command -v ldoc
    
# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
