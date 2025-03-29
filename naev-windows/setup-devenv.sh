#!/bin/sh

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
