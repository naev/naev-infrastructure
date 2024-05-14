FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for building website and docs."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-docs"

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
