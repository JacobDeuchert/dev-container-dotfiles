# dev-container-dotfiles

Repository containing dotfiles that get installed into devcontainers.

## Features

- **Installs Node.js LTS via nvm** if `npm`/`node` is not already present in the container
- **Checks if npm is installed** and automatically installs `opencode-ai` as a global package
- **Copies opencode configuration files** into `~/.config/opencode`

## Usage

This repository is designed to work with VS Code Dev Containers. To use these dotfiles:

1. In VS Code, go to Settings (Preferences > Settings)
2. Search for "dotfiles"
3. Set the **Dotfiles Repository** to: `JacobDeuchert/dev-container-dotfiles`
4. Set the **Dotfiles Install Command** to: `install.sh`

Alternatively, you can reference it in your `devcontainer.json`:

```json
{
  "dotfiles": {
    "repository": "JacobDeuchert/dev-container-dotfiles",
    "installCommand": "install.sh"
  }
}
```

## What Gets Installed

### Node.js LTS (via nvm)
If `npm`/`node` is **not** detected in your devcontainer, the script will automatically:
1. Download and install [nvm](https://github.com/nvm-sh/nvm)
2. Use nvm to install and activate the latest Node.js LTS release

### npm Package: opencode-ai
Once npm is available, the script will automatically install the `opencode-ai` package globally using:
```bash
npm install -g opencode-ai
```

### Configuration Files
The script copies configuration files from the `opencode/` directory in this repository to `~/.config/opencode/` in your devcontainer.

## Manual Installation

You can also manually run the installation script:

```bash
git clone https://github.com/JacobDeuchert/dev-container-dotfiles.git
cd dev-container-dotfiles
./install.sh
```

## Structure

- `install.sh` - Main installation script that runs when devcontainer is created
- `opencode/` - Directory containing opencode configuration files to be copied to `~/.config/opencode`