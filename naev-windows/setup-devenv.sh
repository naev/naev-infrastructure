#!/bin/sh

# Set HOST and MACOSX_DEPLOYMENT_TARGET depending on which BUILD_ARCH is selected.
# Also configure the macports directory for the right libraries since we build for two different targets.

# Pass in either BUILDARCH=aarch64 or BUILDARCH=x86_64 when starting this image to configure it correctly.

# Print a message 
echo "Configuring the development environment"


rustup-init -y -t x86_64-pc-windows-gnu


# Source the environment file
source ~/.cargo/env

# Install Rust
rustup install stable

# Install bindgen-cli via cargo
cargo install bindgen-cli

# Print a "Ready to use" message
echo "Ready to use"
exec "$@"

