#!/bin/sh

# Print a message 
echo "Configuring the development environment"

rustup-init -y --default-toolchain stable

# Source the environment file
source ~/.cargo/env

# Install bindgen-cli via cargo
cargo install bindgen-cli

# Print a "Ready to use" message
echo "Ready to use"
exec "$@"

