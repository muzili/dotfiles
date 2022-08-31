if not pcall(require, "gitsigns") then
  return
end

require('gitsigns').setup({
    signs = {
        add          = { text = '▍' },
        change       = { text = '▍' },
        changedelete = { text = '█' },
        delete       = { text = '▁' },
        topdelete    = { text = '▔' },
    },

    watch_gitdir = { interval = 1000 },
    preview_config = { border = 'rounded' },
    diff_opts = { internal = true, },

    on_attach = function(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = true }
        local opts_expr = { buffer = true, expr = true }

        map('n', '[c', "&diff ? '[c' : '<cmd>lua package.loaded.gitsigns.prev_hunk()<CR>'", opts_expr)
        map('n', ']c', "&diff ? ']c' : '<cmd>lua package.loaded.gitsigns.next_hunk()<CR>'", opts_expr)

        -- Actions
        map({'n', 'v'}, '<leader>hs', '<cmd>lua require("gitsigns").stage_hunk()<CR>', opts)
        map({'n', 'v'}, '<leader>hr', '<cmd>lua require("gitsigns").reset_hunk()<CR>', opts)
        map('n', '<leader>hS', '<cmd>lua require("gitsigns").stage_buffer()<CR>', opts)
        map('n', '<leader>hu', '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', opts)
        -- doesn't exist yet
        -- map('n', '<leader>hU', '<cmd>lua require("gitsigns").undo_stage_buffer()<CR>', opts)
        map('n', '<leader>hR', '<cmd>lua require("gitsigns").reset_buffer()<CR>', opts)
        map('n', '<leader>hp', '<cmd>lua require("gitsigns").preview_hunk()<CR>', opts)
        map('n', '<leader>hb', '<cmd>lua require("gitsigns").blame_line({full=true})<CR>', opts)
        map('n', '<leader>hB', '<cmd>lua require("gitsigns").toggle_current_line_blame()<CR>', opts)
        map('n', '<leader>hd', '<cmd>lua require("gitsigns").diffthis()<CR>', opts)
        map('n', '<leader>hD', '<cmd>lua require("gitsigns").diffthis("~1")<CR>', opts)
        map('n', '<leader>hx', '<cmd>lua require("gitsigns").toggle_deleted()<CR>', opts)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
    end
})

