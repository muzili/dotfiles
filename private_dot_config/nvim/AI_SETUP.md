# AI Provider Configuration for Neovim CodeCompanion

This configuration provides AI functionality in Neovim using CodeCompanion with support for multiple AI providers.

> 📖 **完整使用指南**: 查看 [CODECOMPANION_GUIDE.md](./CODECOMPANION_GUIDE.md) 获取详细的使用说明和最佳实践。

## Setup Instructions

### 1. Central API Key Management System

This configuration uses a centralized API key management system that:
- Stores all API keys in a single GPG-encrypted file (`~/.config/api-keys/keys.env.gpg`)
- Automatically loads keys into environment variables at shell startup
- Supports multiple AI providers with consistent management

### 2. First-Time Setup

Run the central setup script:

```bash
# Install and configure the API key management system
~/.local/bin/setup-api-keys
```

The script will:
1. Check GPG installation and configure encryption
2. Prompt for your primary AI provider keys
3. Set up automatic loading of API keys

### 3. Configure AI Providers

After setting up the central system, configure individual providers:

```bash
cd ~/.config/chezmoi/private_dot_config/nvim
./setup_ai.sh
```

This script will help you configure:
- **Zhipu AI** (智谱清言) - Primary Chinese provider
- **Bailian AI** (百炼) - Backup Chinese provider  
- **OpenAI** - International fallback
- **Anthropic Claude** - High-quality conversations

### 4. Manual Key Management (Advanced)

You can also manage keys manually using the load-api-keys command:

```bash
# Set individual API keys
~/.local/bin/load-api-keys set ZHIPU_API_KEY "your-zhipu-key"
~/.local/bin/load-api-keys set DASHSCOPE_API_KEY "your-bailian-key"
~/.local/bin/load-api-keys set BAILIAN_APP_ID "your-app-id"

# List available keys
~/.local/bin/load-api-keys list

# Test key loading
~/.local/bin/load-api-keys load
```

## Provider Priority

The system uses providers in this order:
1. **Zhipu AI** (智谱清言) - Primary Chinese provider, optimized for Chinese code
2. **Bailian AI** (百炼) - Backup Chinese provider, Alibaba Cloud service
3. **OpenAI** - International standard, highest quality but slower
4. **Anthropic Claude** - High-quality conversations and reasoning
5. **Ollama** - Local models for privacy-sensitive work

## API Key Management

API keys are managed through:
1. **Central encrypted storage**: All keys in `~/.config/api-keys/keys.env.gpg`
2. **Automatic loading**: Keys loaded into environment variables via shell configuration
3. **Environment variables**: CodeCompanion reads from standard environment variables:
   - `ZHIPU_API_KEY` - For Zhipu GLM models
   - `DASHSCOPE_API_KEY` - For Bailian/Qwen models  
   - `OPENAI_API_KEY` - For OpenAI models
   - `ANTHROPIC_API_KEY` - For Claude models
   - `BAILIAN_APP_ID` - For Bailian application ID (if required)

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

### API Key Issues

```bash
# Check if API keys are loaded in environment
echo $ZHIPU_API_KEY
echo $DASHSCOPE_API_KEY

# Test the central key management system
~/.local/bin/load-api-keys load
~/.local/bin/load-api-keys list

# Check if keys are properly encrypted and stored
ls -la ~/.config/api-keys/
```

### Common Problems

1. **Keys not loading**: Ensure your shell configuration includes the API key loader
2. **GPG errors**: Run `setup-api-keys` to reconfigure GPG encryption
3. **Provider not working**: Check the provider is configured in `ai_config.lua`

### Debug Commands in Neovim

```vim
" Check available AI providers
:lua print(vim.inspect(require("ai_config").list_providers()))

" Test provider configuration
:lua print(vim.inspect(require("ai_config").get_config("zhipu")))

" Check if provider is configured
:lua print(require("ai_config").is_configured("zhipu"))
```

## Security

- **Central encryption**: All API keys stored in a single GPG-encrypted file
- **Runtime only**: Keys only decrypted when needed and kept in memory
- **No plaintext storage**: No API keys stored in plaintext on disk
- **Automatic loading**: Keys loaded into environment variables automatically
- **Shell integration**: Integrated with shell startup for seamless operation

## Provider Documentation

### Zhipu AI (智谱清言)
- Website: https://open.bigmodel.cn/
- Model: glm-4-flash
- API Compatible with OpenAI format

### Bailian AI (百炼)
- Website: https://help.aliyun.com/zh/model-studio/
- Model: qwen-turbo
- Uses OpenAI-compatible endpoint via DashScope