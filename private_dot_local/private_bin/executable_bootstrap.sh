#!/usr/bin/env bash
set -e

mkdir -p "$HOME/.local/bin"

# Ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

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

echo "🚀 Installing chezmoi..."
curl https://xiu.lzg.cc/gh/twpayne/chezmoi/releases/download/v2.65.1/chezmoi-linux-amd64-musl -o $HOME/.local/bin/chezmoi
chmod +x $HOME/.local/bin/chezmoi

echo "📥 Initializing dotfiles..."
chezmoi init --apply https://xiu.lzg.cc/gh/muzili/dotfiles.git

echo "🔍 Checking required system dependencies..."
missing_deps=()
for dep in cmake ninja bison yacc; do
    if ! command -v "$dep" &> /dev/null; then
        missing_deps+=("$dep")
    fi
done

if [ ${#missing_deps[@]} -gt 0 ]; then
    echo "❌ Missing required dependencies: ${missing_deps[*]}"
    echo "Please install them first:"
    if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
        echo "  sudo apt install -y cmake ninja-build bison"
    else
        echo "  Install cmake, ninja-build, bison (yacc is usually included with bison)"
    fi
    exit 1
fi

echo "✅ All required dependencies are installed"

echo "🧰 Installing mise tools..."
mise install --missing 2>/dev/null || true

echo "✅ Done! Your dotfiles are ready."
