#!/bin/bash
set -e

# 检查 nvim 是否存在
if ! command -v nvim &> /dev/null; then
    echo "Neovim not installed. Skipping plugin install."
    exit 0
fi

echo "🚀 Installing Neovim plugins..."

# 确保配置目录存在
mkdir -p ~/.config/nvim

# 执行 :Lazy sync 自动安装插件
nvim --headless -c 'Lazy sync' -c 'qa'

echo "✅ Neovim plugins installed!"
