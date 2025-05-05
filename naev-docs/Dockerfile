FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for building website and docs."

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-docs"

COPY setup-devenv.sh /usr/bin

# Install utilities
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install make python3-pip ninja-build clang gawk gcc git GraphicsMagick gzip llvm libyaml openssl optipng rustup zlib \
    python3-pyyaml rsync tidy tar unzip xz zip \
# Install ldoc
    lua-ldoc \
# Install LaTeX packages
    latexmk texlive-luahbtex texlive-roboto texlive-preprint texlive-parskip texlive-sfmath \
    texlive-markdown texlive-csvsimple texlive-gobble texlive-microtype texlive-minted texlive-newunicodechar && \
    microdnf clean all && \
# Need Meson >=1.7.0 for rust_std=2024, but restrict to versions below 1.8.0.
    python3 -m pip install 'meson>=1.7.0,<1.8.0' --upgrade && \
# Verify tool versions and installation locations.
    echo "Verifying meson install" && \
    command -v meson && \
    meson --version && \
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
CMD [ "/usr/bin/setup-devenv.sh", "/bin/bash" ]
