#!/usr/bin/env bash

# Install global npm packages.
# This script installs the globally installed npm packages currently in use.

echo "Installing global npm packages..."

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "Error: npm is not installed."
    echo "Please install Node.js first:"
    echo "  - Use nvm: brew install nvm (then follow setup instructions)"
    echo "  - Or install Node.js directly from https://nodejs.org/"
    exit 1
fi

# Check if nvm is being used
if [ -d "$HOME/.nvm" ]; then
    echo "Using nvm installation of Node.js"
    # Load nvm if it's not already loaded
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

echo "Current Node version: $(node --version)"
echo "Current npm version: $(npm --version)"
echo ""

# Update npm itself to latest version
echo "Updating npm to latest version..."
npm install -g npm

# Development Tools
echo ""
echo "Installing development tools..."
npm install -g @anthropic-ai/claude-code    # Claude AI CLI tool
npm install -g @fission-ai/openspec         # OpenAPI specification tool
npm install -g git-kit                       # Git utilities (used in .gitconfig)

echo ""
echo "Global npm package installation complete!"
echo ""
echo "Installed packages:"
npm list -g --depth=0
