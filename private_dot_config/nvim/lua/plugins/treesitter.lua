---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- 从 ensure_installed 删除 jsonc
    if type(opts.ensure_installed) == "table" then
      opts.ensure_installed = vim.tbl_filter(function(lang)
        return lang ~= "jsonc"
      end, opts.ensure_installed)
    end

    -- 显式禁用 jsonc 安装
    opts.ignore_install = opts.ignore_install or {}
    table.insert(opts.ignore_install, "jsonc")
  end,
}
