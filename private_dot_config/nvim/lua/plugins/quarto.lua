---@type LazySpec
return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown", "qmd" },
    config = function()
      require("quarto").setup {
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "r", "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWrite" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "slime",
        },
      }

      -- 确保 .qmd 文件被 treesitter 正确解析为 markdown
      vim.treesitter.language.register("markdown", "quarto")
    end,
  },
  -- 配置 render-markdown.nvim 以支持 quarto 文件
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto" },
    opts = {
      file_types = { "markdown", "quarto" },
      -- 防止与 quarto-nvim 的 LSP 功能冲突
      anti_conceal = {
        enabled = true,
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
