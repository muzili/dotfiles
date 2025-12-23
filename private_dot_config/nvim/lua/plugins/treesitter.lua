---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- 添加 TypeScript 相关的解析器
    if type(opts.ensure_installed) == "table" then
      -- 从 ensure_installed 删除 jsonc
      opts.ensure_installed = vim.tbl_filter(function(lang)
        return lang ~= "jsonc"
      end, opts.ensure_installed)

      -- 添加 TypeScript 相关解析器
      vim.list_extend(opts.ensure_installed, {
        "typescript",
        "tsx",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "html",
        "css",
        "scss",
        "go",
        "gomod",
      })
    end

    -- 启用 json5 而不是 jsonc
    opts.ignore_install = opts.ignore_install or {}
    table.insert(opts.ignore_install, "jsonc")

    -- 高亮配置
    opts.highlight = opts.highlight or {}
    opts.highlight.enable = true
    opts.highlight.additional_vim_regex_highlighting = false

    -- 增量选择配置
    opts.incremental_selection = opts.incremental_selection or {}
    opts.incremental_selection.enable = true

    -- 缩进配置
    opts.indent = opts.indent or {}
    opts.indent.enable = true
  end,
}
