if not pcall(require, "trouble") then
  return
end

require('trouble').setup()

local keymap = vim.keymap.set
local opt = {silent = true}

keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opt);
keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opt);
keymap("n", "<leader>xb", "<cmd>Trouble lsp_document_diagnostics<cr>", opt);
keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opt);
keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opt);
keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opt);
