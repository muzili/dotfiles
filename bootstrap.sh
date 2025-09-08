#!/usr/bin/env bash
set -e

echo "🚀 Installing chezmoi..."
mkdir -p "$HOME/.local/bin"
sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$HOME/.local/bin"

echo "📥 Initializing dotfiles..."
chezmoi init --apply https://github.com/yourusername/dotfiles.git

echo "🧰 Installing mise tools..."
mise install --missing 2>/dev/null || true

echo "✅ Done! Your dotfiles are ready."
