---@type LazySpec
return {
  "williamboman/mason.nvim",
  opts = {
    -- Configure Mason to use GitHub proxy for faster downloads in China
    github = {
      download_url_template = "https://xiu.lzg.cc/gh/%s/releases/download/%s/%s",
    },
  },
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- install formatters
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
