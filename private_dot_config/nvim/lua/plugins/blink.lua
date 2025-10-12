return { -- override blink.cmp plugin
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
  },
  event = "InsertEnter",
  opts = function(_, opts)
    opts.appearance = {
      nerd_font_variant = "SauceCodePro Nerd Font Mono"
    }

    if not opts.keymap then
      opts.keymap = {}
    end

    -- 添加 codecompanion 作为来源
    table.insert(opts.sources.default, 1, "codecompanion")
    end,
}
