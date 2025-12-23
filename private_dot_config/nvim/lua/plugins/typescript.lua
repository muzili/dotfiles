---@type LazySpec
return {
  -- TypeScript specific plugin for better development experience
  -- DISABLED: Using ts_ls from astrolsp.lua instead to avoid duplicate LSP servers
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  --   opts = {
  --     on_attach = function(client, bufnr)
  --       -- Disable tsserver formatting capabilities if you want to use null-ls or eslint
  --       client.server_capabilities.documentFormattingProvider = false
  --       client.server_capabilities.documentRangeFormattingProvider = false
  --     end,
  --     settings = {
  --       -- specify additional options that should be passed to the `tsserver` process
  --       separate_diagnostic_server = true,
  --       publish_diagnostic_on = "insert_leave",
  --       expose_as_code_action = "all",
  --       -- tsserver plugins
  --       tsserver_plugins = {},
  --       -- completion settings
  --       complete_function_calls = true,
  --       include_completions_with_insert_text = true,
  --       -- code lens
  --       code_lens = "off",
  --       -- inlay hints
  --       inlay_hints = {
  --         parameter_hints = { enabled = true },
  --         variable_types = { enabled = false },
  --         property_declaration_types = { enabled = true },
  --         function_like_return_types = { enabled = true },
  --         enum_member_values = { enabled = true },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("typescript-tools").setup(opts)
  --   end,
  -- },

  -- TypeScript testing support
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-jest",
    },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require("neotest-vitest"))
      table.insert(opts.adapters, require("neotest-jest"))
    end,
  },

  -- Package manager for npm/yarn/pnpm
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = { "json", "jsonc" },
    opts = {},
    event = "BufRead package.json",
  },

  -- Better import/export sorting
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {},
    config = function()
      require("ts-node-action").setup({})
    end,
  },
}
