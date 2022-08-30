local utils = require("utils")
local fn = vim.fn

vim.g.package_home = fn.stdpath("data") .. "/site/pack/packer/"
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim"

local packer_repo = "https://github.com/wbthomason/packer.nvim"
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")
local util = require("packer.util")

require("packer").startup({
  function(use)
    -- it is recommened to put impatient.nvim before any other plugins
    use({ "lewis6991/impatient.nvim", config = [[require('impatient')]] })

    use({ "wbthomason/packer.nvim", opt = true })

    -- LSP
    use({
      "VonHeikemen/lsp-zero.nvim",
      requires = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
      },
    })
    -- The missing auto-completion for cmdline!
    use({ "gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]] })

    -- A list of colorscheme plugin you may want to try. Find what suits you.
    use({ "lifepillar/vim-gruvbox8", opt = true })
    use({ "navarasu/onedark.nvim", opt = true })
    use({ "sainnhe/edge", opt = true })
    use({ "sainnhe/sonokai", opt = true })
    use({ "sainnhe/gruvbox-material", opt = true })
    use({ "shaunsingh/nord.nvim", opt = true })
    use({ "NTBBloodbath/doom-one.nvim", opt = true })
    use({ "sainnhe/everforest", opt = true })
    use({ "EdenEast/nightfox.nvim", opt = true })
    use({ "rebelot/kanagawa.nvim", opt = true })

    -- showing keybindings
    use { -- which key {{{
      'folke/which-key.nvim',
      config = 'require("config.which-key").config()',
    } -- }}}

    -- show and trim trailing whitespaces
    use { 'jdhao/whitespace.nvim', event = 'VimEnter' }

    use { -- telescope {{{
      'nvim-telescope/telescope.nvim',
      wants = { 'popup.nvim', 'plenary.nvim' },
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        {
          'nvim-telescope/telescope-symbols.nvim',
          opt = true,
          after = 'telescope.nvim',
        },
        {
          'nvim-telescope/telescope-file-browser.nvim',
          after = 'telescope.nvim',
          opt = true,
          -- config = 'require("plugin_settings.telescope_file_browser").config()',
        },
      },
      cmd = 'Telescope',
      module = 'telescope',
      setup = 'require("config.telescope").setup()',
      config = 'require("config.telescope").config()',
    } -- }}}

    use { -- {{{ telescope-repo
      'cljoly/telescope-repo.nvim',
      setup = 'require("config.telescope_repo").setup()',
    } -- }}}

    use({
      "lukas-reineke/indent-blankline.nvim",
      event = 'VimEnter',
      config = [[require('config.indent-blankline')]]
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      event = 'BufEnter',
      run = ":TSUpdate",
      config = require('config.treesitter').setup,
    })

    use({
      'simrat39/symbols-outline.nvim',
      cmd = "SymbolsOutline",
      config = function() 
        require("symbols-outline").setup()
      end
    })

  end,
  config = {
    max_jobs = 16,
    compile_path = util.join_paths(vim.fn.stdpath("config"), "lua", "packer_compiled.lua"),
  },
})

-- LSP setup
local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.configure('clangd', {
  cmd = { "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--completion-style=bundled",
    "--query-driver=/data/toolchains/arm-asr7200sdk-linux-gnueabi/usr/bin/arm-asr7200-linux-gnueabi/arm-asr7200-linux-gnueabi-g*",
    "--query-driver=/opt/gcc-linaro-6.2.1-2016.11-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-g*",
    "--query-driver=/opt/arm-histbv320-linux/bin/arm-histbv320-linux-g*",
    "--query-driver=/usr/bin/g*",
    "--query-driver=/usr/bin/clang*",
    "--pch-storage=memory",
    "--enable-config",
  },
  filetypes = { "c", "cpp", "cc", "objc", "objcpp" },
  flags = {
    debounce_text_changes = 500,
  },
})
lsp.set_preferences({
  set_lsp_keymaps = true
})


lsp.nvim_workspace()
lsp.setup()

local status, _ = pcall(require, "packer_compiled")
if not status then
  vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
