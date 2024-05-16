# Build toolchain in build container to save space.
FROM registry.fedoraproject.org/fedora-minimal:latest AS build 

# Get cosmopolitan release
WORKDIR /tmp
RUN microdnf install -y git unzip
RUN curl -LO https://github.com/jart/cosmopolitan/releases/download/3.3.6/cosmocc-3.3.6.zip && \
    mkdir -p /usr/local/src/cosmocc-3.3.6 && \
    unzip cosmocc-3.3.6.zip -d /usr/local/src/cosmocc-3.3.6 

# TODO: Attempt building Naev libraries with cosmo toolchain.

# Build final container
FROM registry.fedoraproject.org/fedora-minimal:latest

WORKDIR /
COPY --from=build /usr/local/src/cosmocc-3.3.6 /usr/lib/cosmocc

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used to build using cosmopolitan libc project."

# Install dependencies for toolchain
RUN microdnf install -y gzip zip unzip

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-cosmopolitan"

# Add CosmoCC to path
ENV PATH "$PATH:/usr/lib/cosmocc/bin"

# Force appimages to extract to get around a lack of FUSE in docker. (without some ####ery at least.)
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Install build tools.
RUN mkdir -p /tmp/naevBuild
WORKDIR /tmp/naevBuild
