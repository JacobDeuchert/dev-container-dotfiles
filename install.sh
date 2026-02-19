#!/bin/bash

# Dotfiles installation script for devcontainers
# This script checks if npm is installed and installs opencode-ai as a global package

set -e

echo "Starting dotfiles installation..."

# Install Node.js LTS via nvm if npm/node is not found
if ! command -v npm &> /dev/null; then
    echo "npm/node not found, installing Node.js LTS via nvm..."

    # Install nvm
    export NVM_DIR="${HOME}/.nvm"
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    # Load nvm into the current shell session
    # shellcheck source=/dev/null
    [ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"

    # Install and use Node.js LTS
    nvm install --lts
    nvm use --lts

    echo "Node.js LTS installed via nvm successfully"
fi

# Check if npm is installed
if command -v npm &> /dev/null; then
    echo "npm is installed, proceeding with opencode-ai installation..."
    
    # Install opencode-ai globally
    npm install -g opencode-ai
    
    echo "opencode-ai installed successfully"
else
    echo "npm is not installed, skipping opencode-ai installation"
fi

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
