#!/bin/bash

# Dotfiles installation script for devcontainers
# This script installs opencode using the official install script

set -eo pipefail

echo "Starting dotfiles installation..."

# Install opencode using the official install script
echo "Installing opencode..."
curl -fsSL https://opencode.ai/install | bash
echo "opencode installed successfully"

# Function to copy opencode configuration files
copy_opencode_config() {
    local source_dir="$(dirname "$0")/opencode"
    local target_dir="${HOME}/.config/opencode"
    
    if [ -d "$source_dir" ]; then
        # Copy all contents including hidden files
        if cp -r "$source_dir/." "$target_dir/" 2>/dev/null; then
            echo "opencode configuration files copied successfully"
        else
            echo "Warning: Failed to copy some opencode configuration files"
        fi
    else
        echo "No opencode configuration files found in dotfiles repository"
    fi
}

# Copy opencode configuration files to ~/.config/opencode
echo "Copying opencode configuration files..."
mkdir -p "${HOME}/.config/opencode"
copy_opencode_config

echo "Dotfiles installation complete!"
