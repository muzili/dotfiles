-- LSP setup
local lsp = require('lsp-zero')

lsp.preset('recommended')

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  })
})

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
  filetypes = { "c", "cpp", "cc", "objc", "objcpp"},
  flags = {
    debounce_text_changes = 500,
  },
})

lsp.on_attach(function(client, bufnr)
  local noremap = {buffer = bufnr, remap = false}
  local bind = vim.keymap.set

  bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', noremap)
  -- more code  ...
end)

lsp.set_preferences({
  set_lsp_keymaps = true,
  configure_diagnostics = true,
})


lsp.nvim_workspace()
lsp.setup()


