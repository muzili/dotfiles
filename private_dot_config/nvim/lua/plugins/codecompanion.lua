-- CodeCompanion.nvim - AI Coding Assistant Configuration
-- 优化的 AI 编程助手配置，支持多种 AI 提供商和高级功能

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "coder/claudecode.nvim",  -- 添加 Claude Code 集成
    "Saghen/blink.cmp",
  },
  event = "VeryLazy",
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionAdd",
  },
  keys = {
    -- 主要快捷键
    { "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
    { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat Toggle" },
    { "<leader>ci", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "AI Inline" },
    
    -- 聊天相关
    { "<leader>cC", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat" },
    { "<leader>cn", "<cmd>CodeCompanionChat New<cr>", desc = "New Chat" },
    
    -- 快速操作
    { "<leader>ce", function() require("codecompanion").prompt("Explain") end, mode = { "n", "v" }, desc = "Explain Code" },
    { "<leader>cr", function() require("codecompanion").prompt("Refactor") end, mode = { "n", "v" }, desc = "Refactor Code" },
    { "<leader>cd", function() require("codecompanion").prompt("Document") end, mode = { "n", "v" }, desc = "Document Code" },
    { "<leader>ct", function() require("codecompanion").prompt("Tests") end, mode = { "n", "v" }, desc = "Generate Tests" },
    { "<leader>cf", function() require("codecompanion").prompt("Fix") end, mode = { "n", "v" }, desc = "Fix Code" },
    { "<leader>co", function() require("codecompanion").prompt("Optimize") end, mode = { "n", "v" }, desc = "Optimize Code" },

    -- 工作流
    { "<leader>cw", "<cmd>CodeCompanionActions workflow<cr>", mode = { "n", "v" }, desc = "AI Workflows" },
  },
  config = function()
    require("codecompanion").setup({
      -- 简化的全局配置
      display = {
        action_palette = {
          width = 80,
          height = 8,
          prompt = "AI Actions: ",
          border = "rounded",
        },
        chat = {
          window = {
            layout = "vertical",
            border = "rounded",
            height = 0.8,
            width = 0.45,
            relative = "editor",
          },
          intro_message = "AI 编程助手已就绪",
          separator = "---",
          show_settings = false,
          show_token_count = false,
        },
        inline = {
          diff = {
            enabled = true, -- 显示建议的 diff
          },
        },
      },

      -- 使用 zhipu 和 bailian 作为默认策略，启用 inline completion
      strategies = {
        chat = {
          adapter = "bailian",
        },
        inline = {
          adapter = "bailian",
        },
        inline_completion = {
          adapter = "bailian",
        },
      },

      -- completion = {
      --   blink = true, -- 🚀 开启 blink.cmp 集成
      -- },
      -- 使用 zhipu 和 bailian 作为默认适配器
      adapters = {
        http = {
          zhipu = require("codecompanion.adapters").extend("openai_compatible", {
            name = "zhipu",
            url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
            env = {
              api_key = "ZHIPU_API_KEY",
            },
            headers = {
              ["Content-Type"] = "application/json",
            },
            parameters = {
              model = "glm-4.5-flash",
              temperature = 0.1,
              max_tokens = 8192,
            },
            schema = {
              model = {
                default = "glm-4.5-flash",
              },
            },
          }),
          bailian = require("codecompanion.adapters").extend("openai_compatible", {
            name = "bailian",
            url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
            env = {
              api_key = "DASHSCOPE_API_KEY",
            },
            headers = {
              ["Content-Type"] = "application/json",
            },
            parameters = {
              model = "qwen-flash",
              temperature = 0.1,
              max_tokens = 8192,
            },
            schema = {
              model = {
                default = "qwen-flash",
              },
            },
          }),
          opts = {
            allow_insecure = false,
            cache_models_for = 1800,
            proxy = nil,
            show_defaults = false,  -- 不显示默认适配器
            show_model_choices = false,
            debug = true,  -- ✅ 关键项：记录完整 HTTP 请求信息
          },
        },
      },

      -- 简化的提示库配置（延迟加载）
      prompt_library = {
        ["Explain"] = {
          strategy = "chat",
          description = "解释代码",
          opts = { 
            auto_submit = true,
            modes = { "v" },
          },
          prompts = {
            { 
              role = "system", 
              content = "你是一个专业的代码分析师。请简洁地解释给定代码的功能、逻辑和关键点。" 
            },
            { 
              role = "user", 
              content = function(context)
                local code = context.lines and table.concat(context.lines, "\n") or "当前代码"
                return "请解释以下代码:\n\n```" .. (context.filetype or "") .. "\n" .. code .. "\n```"
              end
            },
          },
        },
        ["Refactor"] = {
          strategy = "inline",
          description = "重构代码",
          opts = { 
            auto_submit = false,
            modes = { "v" },
          },
          prompts = {
            { role = "system", content = "你是一个代码重构专家。请重构给定的代码，提高其可读性、性能和可维护性。" },
            { 
              role = "user", 
              content = function(context)
                local code = context.lines and table.concat(context.lines, "\n") or "当前代码"
                return "请重构以下代码:\n\n```" .. (context.filetype or "") .. "\n" .. code .. "\n```"
              end
            },
          },
        },
        ["Document"] = {
          strategy = "inline",
          description = "添加文档注释",
          opts = { 
            auto_submit = false,
            modes = { "v" },
          },
          prompts = {
            { role = "system", content = "你是一个文档专家。请为给定的代码添加清晰、详细的文档注释。" },
            { 
              role = "user", 
              content = function(context)
                local code = context.lines and table.concat(context.lines, "\n") or "当前代码"
                return "请为以下代码添加文档注释:\n\n```" .. (context.filetype or "") .. "\n" .. code .. "\n```"
              end
            },
          },
        },
        ["Tests"] = {
          strategy = "chat",
          description = "生成测试代码",
          opts = { 
            auto_submit = false,
            modes = { "v" },
          },
          prompts = {
            { role = "system", content = "你是一个测试专家。请为给定的代码生成完整、全面的单元测试。" },
            { 
              role = "user", 
              content = function(context)
                local code = context.lines and table.concat(context.lines, "\n") or "当前代码"
                return "请为以下代码生成测试:\n\n```" .. (context.filetype or "") .. "\n" .. code .. "\n```"
              end
            },
          },
        },
        ["Fix"] = {
          strategy = "inline",
          description = "修复代码问题",
          opts = { 
            auto_submit = false,
            modes = { "v" },
          },
          prompts = {
            { role = "system", content = "你是一个代码调试专家。请分析并修复给定代码中的问题和错误。" },
            { 
              role = "user", 
              content = function(context)
                local code = context.lines and table.concat(context.lines, "\n") or "当前代码"
                return "请修复以下代码中的问题:\n\n```" .. (context.filetype or "") .. "\n" .. code .. "\n```"
              end
            },
          },
        },
        ["Optimize"] = {
          strategy = "inline",
          description = "优化代码性能",
          opts = { 
            auto_submit = false,
            modes = { "v" },
          },
          prompts = {
            { role = "system", content = "你是一个性能优化专家。请优化给定代码的性能，同时保持功能不变。" },
            { 
              role = "user", 
              content = function(context)
                local code = context.lines and table.concat(context.lines, "\n") or "当前代码"
                return "请优化以下代码的性能:\n\n```" .. (context.filetype or "") .. "\n" .. code .. "\n```"
              end
            },
          },
        },
      },

      -- 简化的日志和其他配置
      log_level = "DEBUG",
      auto_adapters = false,  -- 禁用自动适配器检测
      opts = {
        system_prompt = "你是专业的 AI 编程助手，提供准确实用的编程建议。能够根据注释和上下文智能补全代码。",
        send_code = true,
        use_default_actions = false,
        use_default_prompt_library = false,
        temperature = 0.1,
        max_tokens = 2048,
      },
    })

    -- 配置 claudecode.nvim 集成
    require("claudecode").setup({
      terminal_cmd = "~/bin/claude",
    })

    pcall(function()
      require("codecompanion.integrations.blink")
    end)
    
    -- 设置独立的快捷键，避免与 CodeCompanion 冲突
    vim.keymap.set("n", "<leader>cL", "<cmd>ClaudeCode<cr>", { desc = "Claude Code Chat" })
    vim.keymap.set("n", "<leader>cK", "<cmd>ClaudeCodeFocus<cr>", { desc = "Claude Code Focus" })
    vim.keymap.set("n", "<leader>cS", "<cmd>ClaudeCodeStop<cr>", { desc = "Stop Claude Code" })
    vim.keymap.set("v", "<leader>cL", ":ClaudeCodeSend<cr>", { desc = "Claude Code Send Selection" })
    vim.keymap.set("n", "<leader>cT", "<cmd>ClaudeCodeTreeAdd<cr>", { desc = "Claude Code Add Tree Selection" })
  end,
}
