local cmp = require "cmp"
if not cmp then
  return
end

-- Utils
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local lsp_symbols = {
  Text = "   (Text) ",
  Method = "   (Method)",
  Function = "   (Function)",
  Constructor = "   (Constructor)",
  Field = " ﴲ  (Field)",
  Variable = "[] (Variable)",
  Class = "   (Class)",
  Interface = " ﰮ  (Interface)",
  Module = "   (Module)",
  Property = " 襁 (Property)",
  Unit = "   (Unit)",
  Value = "   (Value)",
  Enum = " 練 (Enum)",
  Keyword = "   (Keyword)",
  Snippet = "   (Snippet)",
  Color = "   (Color)",
  File = "   (File)",
  Reference = "   (Reference)",
  Folder = "   (Folder)",
  EnumMember = "   (EnumMember)",
  Constant = " ﲀ  (Constant)",
  Struct = " ﳤ  (Struct)",
  Event = "   (Event)",
  Operator = "   (Operator)",
  TypeParameter = "   (TypeParameter)",
}

cmp.setup {
  confirmation = { default_behaviour = cmp.ConfirmBehavior.Replace },
  sources = {
    { name = "nvim_lsp", priority = 8 },
    { name = "cmp_tabnine", priority = 8, max_item_count = 3 },
    { name = "treesitter", priority = 7 },
    { name = "buffer", priority = 7, keyword_length = 5 },
    { name = "nvim_lua", priority = 5 },
    { name = "luasnip", priority = 5 },
    { name = "path", priority = 4 },
    { name = "codeium", priority = 8, max_item_count = 3 },
  },

  sorting = {
    priority_weight = 1.0,
    comparators = {
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
      cmp.config.compare.offset,
      cmp.config.compare.order,
    },
  },

  mapping = {
    ["<C-l>"] = cmp.mapping(function(fallback)
          local luasnip = require "luasnip"
          if luasnip.expandable() then
            luasnip.expand()
          else
            local codeium_accept_key = vim.fn["codeium#Accept"]()
            if codeium_accept_key ~= "" then
              vim.api.nvim_feedkeys(codeium_accept_key, "i", false)
            elseif cmp.visible() then
              cmp.confirm {
                select = true,
                behavior = cmp.ConfirmBehavior.Replace,
              }
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end
        end, {
          "i",
          "s",
        }),
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      local luasnip = require "luasnip"
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      local luasnip = require "luasnip"
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  formatting = {
    format = function(entry, item)
      item.kind = lsp_symbols[item.kind]
      if entry.source.name == "cmp_tabnine" then
        item.kind = "   (TabNine)"
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          item.kind = "   (" .. entry.completion_item.data.detail .. ")"
        end
      end
      if entry.source.name == "cmp_tabnine" then
        item.kind = ""
      end
      item.menu = ({
        buffer = "[Buffer]",
        cmp_tabnine = "[T9]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[NLUA]",
        treesitter = "[TS]",
        path = "[Path]",
        luasnip = "[Snippet]",
        codeium = "[Codeium]",
      })[entry.source.name]
      return item
    end,
  },
  snippet = {
    expand = function(args)
      local luasnip = prequire "luasnip"
      if not luasnip then
        return
      end
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
      autocomplete = {
        require("cmp.types").cmp.TriggerEvent.InsertEnter,
        require("cmp.types").cmp.TriggerEvent.TextChanged,
      },
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      scrollbar = "║",
    },
  },
  experimental = {
    ghost_text = true,
  },
}

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = "..",
})
