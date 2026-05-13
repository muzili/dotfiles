#!/bin/bash
set -e

# Install ble.sh (Bash Line Editor) - user-level installation
# ble.sh provides autosuggestions, syntax highlighting, and modern completion
if [[ ! -d ~/.local/share/blesh ]]; then
    echo "Installing ble.sh..."
    git clone --recursive https://github.com/akinomyoga/ble.sh.git ~/.local/share/blesh
    cd ~/.local/share/blesh
    make
    echo "ble.sh installed to ~/.local/share/blesh/out/ble.sh"
else
    echo "ble.sh already installed"
fi

# Install fzf-tab-completion - fuzzy tab completion for bash
if [[ ! -d ~/.local/share/fzf-tab-completion ]]; then
    echo "Installing fzf-tab-completion..."
    git clone https://github.com/lincheney/fzf-tab-completion ~/.local/share/fzf-tab-completion
    echo "fzf-tab-completion installed to ~/.local/share/fzf-tab-completion"
else
    echo "fzf-tab-completion already installed"
fi

echo "Bash enhancements installed successfully!"
echo ""
echo "Restart your shell or run: source ~/.bashrc"