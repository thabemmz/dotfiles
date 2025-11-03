#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# This script installs the packages currently in use on this system.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure we're using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Development Tools
echo "Installing development tools..."
brew install gh                  # GitHub CLI
brew install git-crypt          # Transparent file encryption in git
brew install gnupg              # GNU Privacy Guard
brew install pinentry-mac       # PIN entry dialog for macOS
brew install rbenv              # Ruby version manager
brew install nvm                # Node version manager
brew install yarn               # JavaScript package manager

# Kubernetes Tools
echo "Installing Kubernetes tools..."
brew install k9s                # Terminal-based Kubernetes UI
brew install kubeseal           # Sealed Secrets CLI

# Database & Caching
echo "Installing database and caching tools..."
brew install postgresql@14      # PostgreSQL database (version 14)
brew install libpq              # PostgreSQL C API library
brew install memcached          # High-performance memory object caching

# Configuration & Dotfile Management
echo "Installing configuration tools..."
brew install chezmoi            # Manage dotfiles across machines
brew install pkl                # Pickle configuration language

# Image Processing
echo "Installing image processing tools..."
brew install imagemagick@6      # Image processing tools (version 6)

# Networking
echo "Installing networking tools..."
brew install dnsmasq            # Lightweight DNS forwarder

# System Utilities
echo "Installing system utilities..."
brew install shared-mime-info   # MIME type database

# GUI Applications (Casks)
echo "Installing GUI applications..."
brew install --cask altair-graphql-client    # GraphQL client
brew install --cask anythingllm              # LLM interface
brew install --cask appflowy                 # Notion alternative
brew install --cask warp                     # Modern terminal

# Remove outdated versions from the cellar.
brew cleanup

echo "Homebrew installation complete!"
echo ""
echo "Note: Don't forget to:"
echo "  - Add Homebrew bash to /etc/shells and set as default shell if desired"
echo "  - Initialize nvm (see .bash_profile for configuration)"
echo "  - Initialize rbenv (add 'eval \"\$(rbenv init -)\"' to your profile)"
