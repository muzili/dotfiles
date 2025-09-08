#!/bin/bash
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    ln -sf ~/.local/share/chezmoi/.oh-my-zsh $HOME/.oh-my-zsh
    cp ~/.local/share/chezmoi/dot_zshrc $HOME/.zshrc
fi
