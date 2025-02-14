#!/bin/bash

# Print a message 
echo "Configuring the development environment"

# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source the environment file
source ~/.cargo/env

# Install Rust
rustup install stable

# Install bindgen-cli via cargo
cargo install bindgen-cli

# Print a "Ready to use" message
echo "Ready to use"
exec "$@"