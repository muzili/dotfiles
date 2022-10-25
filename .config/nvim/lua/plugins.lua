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
    use { "lewis6991/impatient.nvim", config = [[require('impatient')]] }

    use { "wbthomason/packer.nvim", opt = true }

    use {
      'kyazdani42/nvim-web-devicons',
      event = 'VimEnter',
    }

    use { 'nvim-lua/plenary.nvim', event = "BufRead", }


    -- LSP
    use {
      "VonHeikemen/lsp-zero.nvim",
      requires = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp", config = 'require("config.cmp")' },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' },
        { "zbirenbaum/copilot-cmp", module = "copilot_cmp", requires = "zbirenbaum/copilot.lua" },

        -- Snippets
        { "L3MON4D3/LuaSnip", config = 'require("config.snippets")' },
        { "rafamadriz/friendly-snippets" },
      },
      config = 'require("config.lsp-zero")',
    }

    -- github copilot
    -- use {'github/copilot.vim'}
    -- then:
    use {
      "zbirenbaum/copilot.lua",
      event = { "VimEnter" },
      config = function()
        vim.defer_fn(function()
          require("copilot").setup({
            cmp = {
              enabled = true,
              method = "getCompletionsCycle",
            },
            panel = {
              enabled = true,
            }
          })
        end, 100)
      end,
    }

    -- The missing auto-completion for cmdline!
    use { "gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]] }

    -- A list of colorscheme plugin you may want to try. Find what suits you.
    use { "lifepillar/vim-gruvbox8", opt = true }
    use { "navarasu/onedark.nvim", opt = true }
    use { "sainnhe/edge", opt = true }
    use { "sainnhe/sonokai", opt = true }
    use { "sainnhe/gruvbox-material", opt = true }
    use { "shaunsingh/nord.nvim", opt = true }
    use { "NTBBloodbath/doom-one.nvim", opt = true }
    use { "sainnhe/everforest", opt = true }
    use { "EdenEast/nightfox.nvim", opt = true }
    use { "rebelot/kanagawa.nvim", opt = true }

    -- showing keybindings
    use { -- which key {{{
      'folke/which-key.nvim',
      config = 'require("config.which-key").config()',
    } -- }}}

    -- show and trim trailing whitespaces
    use { 'jdhao/whitespace.nvim', event = 'VimEnter' }

    use { -- telescope {{{
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
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
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        }
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

    use {
      "lukas-reineke/indent-blankline.nvim",
      event = 'VimEnter',
      config = [[require('config.indent-blankline')]]
    }

    use {
      "nvim-treesitter/nvim-treesitter",
      event = 'BufEnter',
      run = ":TSUpdate",
      config = require('config.treesitter').setup,
    }

    use {
      'simrat39/symbols-outline.nvim',
      cmd = "SymbolsOutline",
      config = function()
        require("symbols-outline").setup()
      end
    }

    use {
      "terrortylor/nvim-comment",
      config = function()
        require('nvim_comment').setup()
      end
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup()
      end
    }

    use {
      'akinsho/bufferline.nvim',
      tag = "v2.*",
      requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      after = 'plenary.nvim',
      config = 'require("config.gitsigns")',
    }

    use {
      'danymat/neogen',
      config = 'require("config.neogen")',
      after = 'nvim-treesitter',
    }

    use {
      "folke/trouble.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = 'require("config.trouble")',
      after = 'nvim-web-devicons',
    }

    -- install without yarn or npm
    use {
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
      setup = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    }

    use {
      "lervag/vimtex",
      opt = true,
      config = function()
        vim.g.vimtex_view_general_viewer = 'okular'
        vim.g.vimtex_compiler_latexmk_engines = {
          _ = '-xelatex'
        }
        vim.g.tex_comment_nospell = 1
        vim.g.vimtex_compiler_progname = 'nvr'
        vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      end,
      ft = 'tex'
    }

    use { 'tyru/open-browser.vim', ft = { 'plantuml' }, event = 'BufEnter' }
    use { 'aklt/plantuml-syntax' }
    use { 'weirongxu/plantuml-previewer.vim', ft = { 'plantuml' }, event = 'BufEnter' }

  end,
  config = {
    max_jobs = 16,
    compile_path = util.join_paths(vim.fn.stdpath("config"), "lua", "packer_compiled.lua"),
  },
})

local status, _ = pcall(require, "packer_compiled")
if not status then
  vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
