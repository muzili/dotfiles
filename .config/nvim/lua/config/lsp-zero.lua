-- LSP setup
local lsp = require('lsp-zero')

lsp.preset({
  name = 'recommended',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  })
})

local clangd_exe = vim.fn.expand("~/.local/share/nvim/mason/bin/clangd")
lsp.configure('clangd', {
  cmd = { clangd_exe,
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
  filetypes = { "c", "cpp", "cc", "objc", "objcpp"},
  flags = {
    debounce_text_changes = 500,
  },
})

lsp.on_attach(function(client, bufnr)
  local noremap = {buffer = bufnr, remap = false}
  local bind = vim.keymap.set
  bind('n', '<space>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', noremap)
  bind("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  bind('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', norebind)
  bind('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', norebind)
  bind('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', norebind)
  bind('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', norebind)
  bind('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', norebind)
  bind('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', norebind)
  bind('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', norebind)
  bind('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', norebind)
  bind('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', norebind)
  bind('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<CR>', norebind)
  bind('n', 'gc', '<cmd>lua vim.lsp.buf.references()<CR>', norebind)
  bind('n', 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', norebind)
  bind('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', norebind)
end)

lsp.set_preferences({
  set_lsp_keymaps = true,
  configure_diagnostics = true,
})


lsp.nvim_workspace()
lsp.setup()


