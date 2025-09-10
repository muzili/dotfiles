#!/usr/bin/env bash
set -e

mkdir -p "$HOME/.local/bin"

echo "🚀 Installing chezmoi..."
sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$HOME/.local/bin"

echo "📥 Initializing dotfiles..."
chezmoi init --apply https://xiu.lzg.cc/gh/muzili/dotfiles.git

echo "🧰 Installing mise tools..."
mise install --missing 2>/dev/null || true

echo "✅ Done! Your dotfiles are ready."
