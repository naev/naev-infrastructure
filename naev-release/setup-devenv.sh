#!/bin/sh

# Print a message 
echo "Configuring the development environment"

rustup-init -y --default-toolchain stable

# Source the environment file
source ~/.cargo/env

# Install bindgen-cli via cargo
cargo install  bindgen-cli --git https://github.com/rust-lang/rust-bindgen.git#97ab915

# Print a "Ready to use" message
echo "Ready to use"
exec "$@"

