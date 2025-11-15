#!/usr/bin/env bash
set -e

mkdir -p "$HOME/.local/bin"

# Ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:.local/share/mise/shims/nvim:$PATH"
fi
if [[ ":$PATH:" != *":$HOME/.local/share/mise/shims:"* ]]; then
    export PATH="$HOME/.local/share/mise/shims:$PATH"
fi

export GH_PROXY=https://xiu.lzg.cc/gh

git config --global url."https://xiu.lzg.cc/gh/".insteadOf "https://github.com/"
git config --global url."https://xiu.lzg.cc/gl/".insteadOf "https://gitlab.com/"
git config --global url."https://xiu.lzg.cc/gitea/".insteadOf "https://gitea.com/"
git config --global url."https://xiu.lzg.cc/codeberg/".insteadOf "https://codeberg.org/"
git config --global url."https://xiu.lzg.cc/sf/".insteadOf "https://sourceforge.net/"
git config --global url."https://xiu.lzg.cc/aosp/".insteadOf "https://android.googlesource.com/"

# Detect OS distribution and version
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VERSION=$VERSION_ID
fi

# https://software.opensuse.org/download.html?project=shells%3Afish&package=fish
if [ ! -f /etc/apt/sources.list.d/fish.list ]; then
  if [[ "$OS" == *"Ubuntu"* ]]; then
    echo "🐧 Detected Ubuntu, adding fish shell PPA..."
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository ppa:fish-shell/release-4 -y
  elif [[ "$OS" == *"Debian"* ]]; then
    echo "🐧 Detected Debian, checking version..."
    if [[ "$VERSION" == "12" ]]; then
      echo "✅ Debian 12 supported"
      echo 'deb http://download.opensuse.org/repositories/shells:/fish/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/fish.list
      curl -fsSL https://download.opensuse.org/repositories/shells:fish/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish.gpg > /dev/null
    elif [[ "$VERSION" == "13" ]]; then
      echo "✅ Debian 13 supported"
      echo 'deb http://download.opensuse.org/repositories/shells:/fish/Debian_13/ /' | sudo tee /etc/apt/sources.list.d/fish.list
      curl -fsSL https://download.opensuse.org/repositories/shells:fish/Debian_13/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish.gpg > /dev/null
    else
      echo "❌ Error: Only Debian 12 and 13 are supported. Detected version: $VERSION"
      exit 1
    fi
  else
    echo "⚠️  Unsupported OS: $OS. You may need to install fish manually."
  fi

  if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
    sudo apt update
    sudo apt install fish
  fi
fi

echo "🔍 Checking required system dependencies..."
sudo apt install -y cmake ninja-build bison byacc libncurses-dev
echo "✅ All required dependencies are installed"

echo "🔍 Checking chezmoi version..."

# Get the latest chezmoi version from GitHub API
LATEST_VERSION=$(curl -fsSL https://api.github.com/repos/twpayne/chezmoi/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

if [ -z "$LATEST_VERSION" ]; then
    echo "⚠️  Failed to fetch latest chezmoi version, falling back to v2.65.1"
    LATEST_VERSION="2.65.1"
fi

echo "Latest chezmoi version: v$LATEST_VERSION"

# Check if chezmoi is already installed and get its version
if command -v chezmoi &> /dev/null; then
    CURRENT_VERSION=$(chezmoi --version | grep -oP 'version \K[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
    echo "Current chezmoi version: v$CURRENT_VERSION"
    
    if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
        echo "✅ chezmoi is already up to date"
        NEED_INSTALL=false
    else
        echo "🔄 Updating chezmoi from v$CURRENT_VERSION to v$LATEST_VERSION..."
        NEED_INSTALL=true
    fi
else
    echo "📦 chezmoi not found, installing..."
    NEED_INSTALL=true
fi

if [ "$NEED_INSTALL" = true ]; then
    echo "🚀 Installing chezmoi v$LATEST_VERSION..."
    curl -fsSL https://xiu.lzg.cc/gh/twpayne/chezmoi/releases/download/v${LATEST_VERSION}/chezmoi-linux-amd64-musl -o $HOME/.local/bin/chezmoi
    chmod +x $HOME/.local/bin/chezmoi
    echo "✅ chezmoi v$LATEST_VERSION installed successfully"
fi

echo "📥 Initializing dotfiles..."
chezmoi init --apply https://xiu.lzg.cc/gh/muzili/dotfiles.git

echo "🧰 Installing mise tools..."
mise install --missing 2>/dev/null || true

echo "✅ Done! Your dotfiles are ready."
