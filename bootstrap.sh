#!/usr/bin/env bash
set -e

mkdir -p "$HOME/.local/bin"

git config --global url."https://xiu.lzg.cc/gh/".insteadOf "https://github.com/"
git config --global url."https://xiu.lzg.cc/gl/".insteadOf "https://gitlab.com/"
git config --global url."https://xiu.lzg.cc/gitea/".insteadOf "https://gitea.com/"
git config --global url."https://xiu.lzg.cc/codeberg/".insteadOf "https://codeberg.org/"
git config --global url."https://xiu.lzg.cc/sf/".insteadOf "https://sourceforge.net/"
git config --global url."https://xiu.lzg.cc/aosp/".insteadOf "https://android.googlesource.com/"

echo "🚀 Installing chezmoi..."
curl https://xiu.lzg.cc/gh/twpayne/chezmoi/releases/download/v2.65.1/chezmoi-linux-amd64-musl -o $HOME/.local/bin/chezmoi
chmod +x $HOME/.local/bin/chezmoi

echo "📥 Initializing dotfiles..."
chezmoi init --apply https://xiu.lzg.cc/gh/muzili/dotfiles.git

echo "🧰 Installing mise tools..."
mise install --missing 2>/dev/null || true

echo "✅ Done! Your dotfiles are ready."
