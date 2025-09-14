#!/bin/bash
set -e

echo "🔗 Setting up oh-my-tmux..."

# 确保 .tmux 目录存在（用于插件）
mkdir -p ~/.tmux/plugins

export TMUX_PLUGIN_MANAGER_PATH="${TMUX_PLUGIN_MANAGER_PATH:-$HOME/.tmux/plugins/}"

# 安装 TPM (Tmux Plugin Manager) —— 如果你使用插件
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "✅ TPM installed."
fi

# Step 4: Install plugins ONLY if config includes TPM line
if grep -q "plugins/tpm/tpm" ~/.tmux.conf ~/.tmux.conf.local 2>/dev/null; then
    echo "📦 Installing tmux plugins via TPM..."
    ~/.tmux/plugins/tpm/bin/install_plugins
else
    echo "⚠️ TPM not configured in tmux.conf — skipping plugin install."
    echo "💡 Add this to the END of your .tmux.conf.local:"
    echo "   run '~/.tmux/plugins/tpm/tpm'"
fi

echo "✅ oh-my-tmux setup complete!"
