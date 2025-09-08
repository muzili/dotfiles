#!/bin/bash
set -e

echo "🔗 Setting up oh-my-tmux..."

# 确保 .tmux 目录存在（用于插件）
mkdir -p ~/.tmux/plugins

# 安装 TPM (Tmux Plugin Manager) —— 如果你使用插件
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "✅ TPM installed."
fi

# 自动安装插件（如果配置了）
if command -v tmux &> /dev/null; then
    echo "📦 Installing tmux plugins..."
    ~/.tmux/plugins/tpm/bin/install_plugins
fi

echo "✅ oh-my-tmux setup complete!"
