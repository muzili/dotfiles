#!/bin/bash
set -e

echo "🚀 Installing mise..."

# 安装 mise（如果未安装）
if ! command -v mise &> /dev/null; then
    echo "📦 mise not found. Installing..."
    curl https://mise.jdx.dev/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"  # 确保 mise 在 PATH
fi

# 重新加载 shell 配置（可选）
# source ~/.bashrc 2>/dev/null || source ~/.zshrc 2>/dev/null

echo "⬇️  Installing tools from ~/.mise.toml..."
mise install

echo "✅ mise setup complete!"
