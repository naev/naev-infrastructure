# Build ruby in build container to save space.
FROM registry.fedoraproject.org/fedora-minimal:latest AS build 

# Install ruby deps
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install findutils gcc git gzip \
    libyaml libyaml-devel make openssl openssl-devel tar unzip automake findutils g++ zlib-devel && \
    microdnf clean all

# Build ruby download URL
# Update these to update the version of ruby we bundle.
ENV RUBY_MAJOR 3.2
ENV RUBY_MINOR 2
ENV RUBY_VERSION "$RUBY_MAJOR.$RUBY_MINOR"
ENV RUBY_TGZ_URL "https://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz"

# Build Ruby
RUN curl -L -O "$RUBY_TGZ_URL" && \
    tar zxpf ruby-"$RUBY_VERSION".tar.gz && \
    cd ruby-"$RUBY_VERSION" && \
    ./configure --prefix=/opt/ruby --disable-install-rdoc --disable-install-capi && \
    make -j"$(nproc --all)" && \
    make install

# Add ruby to PATH and install bundler
ENV PATH "$PATH:/opt/ruby/bin"
RUN gem install bundler

RUN mkdir websiteTemp && \
    git clone --recurse https://github.com/naev/naev-website.git websiteTemp && \
# Install Website Build gems.
    cd websiteTemp && \
    git checkout upcoming && \
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
COPY --from=build /opt/ruby /opt/ruby

# Add ruby to PATH
ENV PATH "$PATH:/opt/ruby/bin"

# Install utilities
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install make meson ninja-build gcc git GraphicsMagick libyaml openssl optipng zlib \
    python3-pyyaml rsync tidy tar unzip xz zip \
# Install ldoc
    lua-ldoc \
# Install LaTeX packages
    latexmk texlive-luahbtex texlive-roboto texlive-preprint texlive-parskip texlive-sfmath \
    texlive-markdown texlive-csvsimple texlive-gobble texlive-microtype texlive-minted texlive-newunicodechar && \
    microdnf clean all && \
# Verify tool versions and install locations.
    echo "Verifying ruby install" && \
    command -v ruby && \
    ruby --version && \
    echo "Verifying bundler install" && \
    command -v bundle && \
    bundle --version && \
    echo "Verifying latexmk install" && \
    command -v latexmk && \
    latexmk -v && \
    echo "Verifying lualatex install" && \
    command -v lualatex && \
    lualatex -v && \
    echo "Verifying ldoc install" && \
    command -v ldoc
    
# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
