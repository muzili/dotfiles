# AI Provider Configuration for Neovim CodeCompanion

This configuration provides AI functionality in Neovim using CodeCompanion with support for multiple Chinese AI providers.

> 📖 **完整使用指南**: 查看 [CODECOMPANION_GUIDE.md](./CODECOMPANION_GUIDE.md) 获取详细的使用说明和最佳实践。

## Setup Instructions

### 1. Prerequisites

- GPG installed and configured with a key pair
- Neovim with the configured plugins

### 2. Run Setup Script

```bash
cd ~/.config/chezmoi/private_dot_config/nvim
./setup_ai.sh
```

The script will help you:
- Set up GPG-encrypted API keys
- Configure Zhipu AI (primary provider)
- Configure Bailian AI (backup provider)

### 3. Manual Setup (Alternative)

If you prefer manual setup:

#### Create Secrets Directory
```bash
mkdir -p ~/.config/chezmoi/private_dot_config/nvim/secrets
```

#### Encrypt API Keys
```bash
# Zhipu AI (Primary)
echo "your-zhipu-api-key" | gpg --armor --encrypt --recipient your-gpg-key-id --output ~/.config/chezmoi/private_dot_config/nvim/secrets/zhipu.gpg

# Bailian AI (Backup)
echo "your-bailian-api-key" | gpg --armor --encrypt --recipient your-gpg-key-id --output ~/.config/chezmoi/private_dot_config/nvim/secrets/bailian.gpg

# Bailian App ID (if required)
echo "your-bailian-app-id" | gpg --armor --encrypt --recipient your-gpg-key-id --output ~/.config/chezmoi/private_dot_config/nvim/secrets/bailian_app_id.gpg
```

### 4. Environment Variables (Optional)

You can also use environment variables instead of GPG:

```bash
export ZHIPU_API_KEY="your-zhipu-api-key"
export BAILIAN_API_KEY="your-bailian-api-key"
export BAILIAN_APP_ID="your-bailian-app-id"
```

## Provider Priority

The system uses providers in this order:
1. **Zhipu AI** (智谱清言) - Primary
2. **Bailian AI** (百炼) - Backup
3. OpenAI - Fallback
4. Other providers

## API Key Sources

1. Environment variables (highest priority)
2. GPG-encrypted files
3. Fallback to default

## Keymaps

All AI-related keymaps are under `<leader>c`:

### 主要功能
- `<leader>ca` - AI actions menu (动作面板)
- `<leader>cc` - Toggle AI chat (切换聊天窗口)
- `<leader>ci` - Inline AI assistant (行内助手)
- `<leader>cn` - New chat session (新建聊天)
- `<leader>cC` - Add selection to chat (添加选中内容到聊天)

### 快速操作
- `<leader>ce` - Explain code (解释代码)
- `<leader>cr` - Refactor code (重构代码)
- `<leader>cd` - Generate documentation (生成文档)
- `<leader>ct` - Generate tests (生成测试)
- `<leader>cf` - Fix code issues (修复代码)
- `<leader>co` - Optimize performance (性能优化)

### 工作流
- `<leader>cwr` - Code review workflow (代码审查流程)
- `<leader>cwb` - Bug analysis workflow (Bug 分析流程)

## Inline Completion

- AI suggestions appear automatically as you type
- Press `<Tab>` to accept the suggestion
- Press `<C-]>` to dismiss the suggestion

## Troubleshooting

### GPG Issues
```bash
# Check GPG installation
gpg --version

# List GPG keys
gpg --list-keys

# Test decryption
gpg --quiet --decrypt ~/.config/chezmoi/private_dot_config/nvim/secrets/zhipu.gpg
```

### API Key Issues
1. Verify your API keys are correct
2. Check your GPG key ID matches
3. Ensure the secrets files exist and are readable

### Neovim Issues
1. Check for error messages with `:messages`
2. Verify plugins are installed with `:Lazy`
3. Restart Neovim after configuration changes

## Security

- API keys are stored encrypted using GPG
- Keys are decrypted only when needed
- No plaintext keys are stored on disk
- Environment variables are supported for convenience

## Provider Documentation

### Zhipu AI (智谱清言)
- Website: https://open.bigmodel.cn/
- Model: glm-4-flash
- API Compatible with OpenAI format

### Bailian AI (百炼)
- Website: https://help.aliyun.com/zh/model-studio/
- Model: qwen-turbo
- Uses OpenAI-compatible endpoint via DashScope