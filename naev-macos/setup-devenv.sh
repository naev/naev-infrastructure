#!/bin/sh

# Set HOST and MACOSX_DEPLOYMENT_TARGET depending on which BUILD_ARCH is selected.
# Also configure the macports directory for the right libraries since we build for two different targets.

# Pass in either BUILDARCH=aarch64 or BUILDARCH=x86_64 when starting this image to configure it correctly.

# Print a message 
echo "Configuring the development environment"


if [[ "$BUILDARCH" == "aarch64" ]] then
    export HOST="aarch64-apple-darwin23"
    export MACOSX_DEPLOYMENT_TARGET="$AARCH64_DEPLOYMENT_TARGET"
    rm -f /usr/lib/osxcross/macports
    ln -s /usr/lib/osxcross/macports.aarch64 /usr/lib/osxcross/macports
    rustup-init -y -t aarch64-apple-darwin
elif [[ "$BUILDARCH" == "x86_64" ]] then
    export HOST="x86_64-apple-darwin23"
    export MACOSX_DEPLOYMENT_TARGET="$X86_64_DEPLOYMENT_TARGET"
    rm -f /usr/lib/osxcross/macports
    ln -s /usr/lib/osxcross/macports.x86_64 /usr/lib/osxcross/macports
    rustup-init -y -t x86_64-apple-darwin
# Fallback
else
    export HOST="x86_64-apple-darwin23"
    export MACOSX_DEPLOYMENT_TARGET="$X86_64_DEPLOYMENT_TARGET"
    rm -f /usr/lib/osxcross/macports
    ln -s /usr/lib/osxcross/macports.x86_64 /usr/lib/osxcross/macports
    rustup-init -y -t x86_64-apple-darwin
fi

# Source the environment file
source ~/.cargo/env

# Install Rust
rustup install stable

# Install bindgen-cli via cargo
cargo install  bindgen-cli --git https://github.com/rust-lang/rust-bindgen.git#97ab915

# Print a "Ready to use" message
echo "Ready to use"
exec "$@"

