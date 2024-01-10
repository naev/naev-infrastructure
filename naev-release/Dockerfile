# Build luarocks in build container to save space.
FROM registry.fedoraproject.org/fedora-minimal:latest AS build 

WORKDIR /tmp
# Install luarocks deps
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install git golang && \
    microdnf clean all && \
# Build luarocks
    git clone https://github.com/wangyoucao577/assets-uploader.git && \
    cd assets-uploader/cmd/github-assets-uploader && \
    go build  && \
    ./github-assets-uploader -version

# Build final container

FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for packaging releases"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-release"

WORKDIR /
COPY --from=build /tmp/assets-uploader/cmd/github-assets-uploader/github-assets-uploader /opt/github-assets-uploader/github-assets-uploader

# Add github-assets-uploader to PATH
ENV PATH "$PATH:/opt/github-assets-uploader"

# Add SteamCMD to PATH
ENV PATH "$PATH:/opt/steamcmd"

# Add Butler to PATH
ENV PATH "$PATH:/opt/butler"

# Add rcodesign to PATH
ENV PATH "$PATH:/opt/apple-codesign"

WORKDIR /tmp
# Install utilities
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install meson ninja-build gcc python3-pyyaml file git tar xz unzip zip \
# Install SteamCMD and friends
    glibc.i686 SDL2.i686 && \
    microdnf clean all && \
# Download and install SteamCMD
    curl -L -O http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    mkdir -p /opt/steamcmd && \
    tar -xvzf steamcmd_linux.tar.gz -C /opt/steamcmd && \
    mv /opt/steamcmd/steam.sh /opt/steamcmd/steam && \
    mv /opt/steamcmd/steamcmd.sh /opt/steamcmd/steamcmd && \
    rm steamcmd_linux.tar.gz && \
# Download and install itch.io butler
    curl -L -o butler.zip https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default && \
    mkdir -p /opt/butler && \
    unzip butler.zip -d /opt/butler && \
    chmod +x /opt/butler && \
    rm butler.zip && \
# Download and install rcodesign
    curl -L -O https://github.com/indygreg/apple-platform-rs/releases/download/apple-codesign%2F0.26.0/apple-codesign-0.26.0-x86_64-unknown-linux-musl.tar.gz && \
    mkdir -p /opt/apple-codesign && \
    tar --strip-components=1 -xvzf apple-codesign-0.26.0-x86_64-unknown-linux-musl.tar.gz -C /opt/apple-codesign && \
    rm apple-codesign-0.26.0-x86_64-unknown-linux-musl.tar.gz && \
# Verify tool versions and installation locations.
    echo "Verifying steamcmd install" && \
    command -v steamcmd && \
    steamcmd +quit && \
    echo "Verifying butler install" && \
    command -v butler && \
    butler -V && \
    echo "Verifying rcodesign install" && \
    command -v rcodesign && \
    rcodesign -V && \
    echo "Verifying github-assets-uploader install" && \
    command -v github-assets-uploader && \
    github-assets-uploader -version

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p naevBuild
WORKDIR /tmp/naevBuild
