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

echo "✅ Fish setup complete! Run 'fish' to start."
