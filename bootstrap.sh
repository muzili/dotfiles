#!/usr/bin/env bash
set -e

mkdir -p "$HOME/.local/bin"

echo "🚀 Installing chezmoi..."
curl https://xiu.lzg.cc/gh/twpayne/chezmoi/releases/download/v2.65.1/chezmoi-linux-amd64-musl -o $HOME/.local/bin/chezmoi
chmod +x $HOME/.local/bin/chezmoi

echo "📥 Initializing dotfiles..."
chezmoi init --apply https://xiu.lzg.cc/gh/muzili/dotfiles.git

echo "🧰 Installing mise tools..."
mise install --missing 2>/dev/null || true

echo "✅ Done! Your dotfiles are ready."
