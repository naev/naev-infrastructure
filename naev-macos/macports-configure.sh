#!/bin/sh

# Set HOST and MACOSX_DEPLOYMENT_TARGET depending on which BUILD_ARCH is selected.
# Also configure the macports directory for the right libraries since we build for two different targets.

# Pass in either BUILDARCH=aarch64 or BUILDARCH=x86_64 when starting this image to configure it correctly.

if [[ "$BUILDARCH" == "aarch64" ]] then
    export HOST="aarch64-apple-darwin23"
    export MACOSX_DEPLOYMENT_TARGET="$AARCH64_DEPLOYMENT_TARGET"
    rm -f /usr/lib/osxcross/macports
    ln -s /usr/lib/osxcross/macports.aarch64 /usr/lib/osxcross/macports
elif [[ "$BUILDARCH" == "x86_64" ]] then
    export HOST="x86_64-apple-darwin23"
    export MACOSX_DEPLOYMENT_TARGET="$X86_64_DEPLOYMENT_TARGET"
    rm -f /usr/lib/osxcross/macports
    ln -s /usr/lib/osxcross/macports.x86_64 /usr/lib/osxcross/macports
# Fallback
else
    export HOST="x86_64-apple-darwin23"
    export MACOSX_DEPLOYMENT_TARGET="$X86_64_DEPLOYMENT_TARGET"
    rm -f /usr/lib/osxcross/macports
    ln -s /usr/lib/osxcross/macports.x86_64 /usr/lib/osxcross/macports
fi

exec "$@"
