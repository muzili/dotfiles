#!/bin/bash
set -e

echo "🚀 Setting up Fish shell..."

# 安装 Fisher（如果未安装）
if ! command -v fish &> /dev/null; then
    echo "❌ Fish shell not installed. Please install first:"
    echo "   macOS: brew install fish"
    echo "   Ubuntu: sudo apt install fish"
    exit 1
fi

# 检查 Fisher 是否已安装
if ! fish -c "functions -q fisher" 2>/dev/null; then
    echo "📦 Installing Fisher..."
    fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fi

# 安装插件（从 config.fish 中提取或硬编码）
echo "🔌 Installing Fish plugins..."
fish -c "
    fisher install jorgebucaran/fnm;
    fisher install oh-my-fish/theme-bobthefish;
    fisher install PatrickF1/fzf.fish;
"

echo "✅ Fish setup complete! Run 'fish' to start."
