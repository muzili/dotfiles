local M = {}

M.setup = function() -- {{{
    local opts = {silent=true, noremap=true}
    vim.api.nvim_set_keymap('n', '<C-p>', '<Cmd>Telescope find_files find_command=fd,--hidden,--type,f,--exclude,.git <CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-f>', '<Cmd>Telescope live_grep<CR>', opts)

    local keymap = {
        f = {
            name = '+find',
            -- f = {'<Cmd>lua require("telescope.builtin").builtin({include_extensions = true})<CR>', 'telescope'},
            f = {'<Cmd>Telescope find_files<CR>', 'find files'},
            l = {'<Cmd>Telescope live_grep<CR>', 'live grep'},
            b = {'<Cmd>Telescope buffers<CR>', 'buffers'},
            h = {'<Cmd>Telescope help_tags<CR>', 'help tags'},
            k = {'<Cmd>Telescope keymaps<CR>', 'keymaps'},
            o = {'<Cmd>Telescope oldfiles<CR>', 'old files'},
            s = {'<Cmd>Telescope colorscheme<CR>', 'colorscheme'},
            e = {'<Cmd>Telescope symbols<CR>', 'symbols'},
            n = {'<Cmd>lua require("telescope").extensions.file_browser.file_browser()<CR>', 'file browser'},
            -- m = {'<Cmd>Telescope bookmarks<CR>', 'marks'},
            c = {
                name = '+commands',
                c = {'<Cmd>Telescope commands<CR>', 'commands'},
                h = {'<Cmd>Telescope command_history<CR>', 'history'},
            },
            q = {'<Cmd>Telescope quickfix<CR>', 'quickfix'},
            g = {
                name = '+git',
                g = {'<Cmd>Telescope git_commits<CR>', 'commits'},
                c = {'<Cmd>Telescope git_bcommits<CR>', 'bcommits'},
                b = {'<Cmd>Telescope git_branches<CR>', 'branches'},
                s = {'<Cmd>Telescope git_status<CR>', 'status'},
            },
        },
        l = {
            name = '+lsp',
            e = {'<Cmd>Telescope diagnostics bufnr=0<CR>', 'lsp errors'},
            h = {'<Cmd>Telescope lsp_references<CR>', 'lsp references'},
        },
    }
    require('which-key').register(keymap, {prefix = '<leader>'})
end -- }}}

M.config = function()
    require('telescope').setup({
        defaults = {
            dynamic_preview_title = true,
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                -- "-g","'!.git/*'",
            },
        },
    })
end

return M
