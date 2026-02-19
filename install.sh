#!/bin/bash

# Dotfiles installation script for devcontainers
# This script checks if npm is installed and installs opencode-ai as a global package

set -e

echo "Starting dotfiles installation..."

# Check if npm is installed
if command -v npm &> /dev/null; then
    echo "npm is installed, proceeding with opencode-ai installation..."
    
    # Install opencode-ai globally
    npm install -g opencode-ai
    
    echo "opencode-ai installed successfully"
else
    echo "npm is not installed, skipping opencode-ai installation"
fi

# Copy opencode configuration files to ~/.config/opencode
if [ -d "${HOME}/.config" ]; then
    echo "Copying opencode configuration files..."
    
    # Create the opencode directory if it doesn't exist
    mkdir -p "${HOME}/.config/opencode"
    
    # Copy opencode files from the dotfiles repo to the config directory
    if [ -d "$(dirname "$0")/opencode" ]; then
        cp -r "$(dirname "$0")/opencode/"* "${HOME}/.config/opencode/" 2>/dev/null || true
        echo "opencode configuration files copied successfully"
    else
        echo "No opencode configuration files found in dotfiles repository"
    fi
else
    echo "~/.config directory does not exist, creating it..."
    mkdir -p "${HOME}/.config/opencode"
    if [ -d "$(dirname "$0")/opencode" ]; then
        cp -r "$(dirname "$0")/opencode/"* "${HOME}/.config/opencode/" 2>/dev/null || true
        echo "opencode configuration files copied successfully"
    fi
fi

echo "Dotfiles installation complete!"
