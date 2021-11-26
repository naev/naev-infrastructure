FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "For packaging releases."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-release"

WORKDIR /tmp
# Install GH CLI repository and utilities
RUN gpg --recv-keys C99B11DEB97541F0 && \
    gpg --export -a -o GH-RPM-GPG-KEY C99B11DEB97541F0 && \
    rpm --import GH-RPM-GPG-KEY && \
    curl -L -o /etc/yum.repos.d/gh-cli.repo https://cli.github.com/packages/rpm/gh-cli.repo && \
    microdnf --nodocs --setopt=install_weak_deps=1 -y install meson ninja-build gcc python3-pyyaml git gh tar xz unzip which zip \
# Install SteamCMD and friends
    glibc.i686 SDL2.i686 && \
    microdnf clean all && \
    rm GH-RPM-GPG-KEY

RUN curl -L -O http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    mkdir -p /opt/steamcmd && \
    tar -xvzf steamcmd_linux.tar.gz -C /opt/steamcmd && \
    mv /opt/steamcmd/steam.sh /opt/steamcmd/steam && \
    mv /opt/steamcmd/steamcmd.sh /opt/steamcmd/steamcmd && \
    rm steamcmd_linux.tar.gz

# Add SteamCMD to PATH
ENV PATH "$PATH:/opt/steamcmd"

# Install itch.io butler
RUN curl -L -o butler.zip https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default && \
    mkdir -p /opt/butler && \
    unzip butler.zip -d /opt/butler && \
    chmod +x /opt/butler && \
    rm butler.zip

# Add Butler to PATH
ENV PATH "$PATH:/opt/butler"

# Verify tool versions and installation locations.
RUN echo "Verifying steamcmd install" && \
    which steamcmd && \
    steamcmd +quit && \
    echo "Verifying butler install" && \
    which butler && \
    butler -V

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p naevBuild
WORKDIR /tmp/naevBuild
