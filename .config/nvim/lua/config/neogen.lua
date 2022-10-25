require('neogen').setup({
    enabled = true,
    input_after_comment = true,
})

opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>cg", ":lua require('neogen').generate()<CR>", opts)

