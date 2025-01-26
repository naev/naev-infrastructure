FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL org.opencontainers.image.authors "Naev Dev Team"
LABEL org.opencontainers.image.source "https://github.com/naev/naev-infrastructure"
LABEL org.opencontainers.image.description "Used for rendering naev artwork"

# Allows for determining what container scripts are run in.
ENV IMAGE_NAME "naev-artwork"

# Build Blender download URL
ENV BLENDER_MAJOR 2.79
ENV BLENDER_VERSION b
ENV BLENDER_BZ2_URL https://download.blender.org/release/Blender$BLENDER_MAJOR/blender-$BLENDER_MAJOR$BLENDER_VERSION-linux-glibc219-x86_64.tar.bz2

# Add Blender to PATH
ENV PATH "$PATH:/opt/blender"

WORKDIR /tmp
# Install Blender runtime dependencies
RUN microdnf --nodocs --setopt=install_weak_deps=0 -y install bzip2 freetype git GraphicsMagick ImageMagick libXi make mesa-libGL mesa-libGLU tar && \
    microdnf clean all && \
# Download and install SteamCMD
    mkdir -p /opt/blender && \
	curl -SL "$BLENDER_BZ2_URL" -o blender.tar.bz2 && \
	tar -jxvf blender.tar.bz2 -C /opt/blender --strip-components=1 && \
	rm blender.tar.bz2 && \
# Verify tool versions and installation locations.
    echo "Verifying blender install" && \
    command -v blender && \
    blender -v

# Force appimages to run in extract mode since FUSE is not available
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Set WORKDIR when you spin up the image.
RUN mkdir -p naevBuild
WORKDIR /tmp/naevBuild
