# AstroNvim v6 Migration Design

Date: 2026-04-17
Status: Approved

## Overview

Migrate existing AstroNvim configuration from v5 to v6 API, focusing on:
1. LSP configuration using new `vim.lsp.config` API
2. Fixing clangd integration with system-installed version (via mise)
3. Bug fixes in existing plugin configurations

## Context

- Neovim: 0.12.1
- AstroNvim: 6.0.4
- clangd: installed via mise (system-level)
- Current `lazy_setup.lua` already set to `version = "^6"`

## Changes

### 1. astrolsp.lua - LSP Migration

**Priority: High**

#### servers List
Add `clangd` to servers list to declare it as ready for use:
```lua
servers = {
  "clangd",
}
```

#### config Updates
Replace `require("lspconfig.util").root_pattern(...)` with `vim.fs.root(0, {...})`:

```lua
config = {
  ["clangd"] = {
    cmd = {
      "clangd",
      "--enable-config",
      "--background-index",
      "--clang-tidy",
      "--log=verbose",
      "--completion-style=detailed",
      "--header-insertion=never",
      "--query-driver=/usr/bin/clang++,/usr/bin/g++,**",
      "--all-scopes-completion",
      "--cross-file-rename",
      "--suggest-missing-includes",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cc", "hpp" },
    root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
    capabilities = { offsetEncoding = "utf-8" },
  },
  ["ts_ls"] = {
    root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }),
    -- existing settings unchanged
  },
  ["eslint"] = {
    root_dir = vim.fs.root(0, { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".git" }),
    -- existing settings unchanged
  },
}
```

### 2. blink.lua - Syntax Fix

**Priority: High**

Current issue: missing `return opts` at end of opts function.

Fix:
```lua
opts = function(_, opts)
  opts.appearance = {
    nerd_font_variant = "SauceCodePro Nerd Font Mono"
  }
  opts.keymap = opts.keymap or {}
  table.insert(opts.sources.default, 1, "codecompanion")
  return opts  -- ADD THIS LINE
end,
```

### 3. treesitter.lua - Simplification

**Priority: Medium**

AstroNvim v6 has built-in treesitter management. AstroCommunity packs already include parsers for common languages.

Simplify to:
```lua
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ignore_install = { "jsonc" }
  end,
}
```

Or delete the file entirely if no custom parser configuration needed.

### 4. Files Not Modified

- `community.lua` - cpp pack already present
- `lazy_setup.lua` - already v6 format
- `mason.lua` - no clangd needed (using system version)
- Other plugin configs - no changes required

## Testing Plan

1. Open a C++ file in a project with `compile_commands.json` or `.git`
2. Run `:checkhealth vim.lsp` to verify clangd status
3. Verify completion with `:lua vim.lsp.get_clients()`
4. Test blink.cmp completion still works
5. Verify treesitter highlighting for TypeScript/JavaScript files

## Rollback

If issues occur:
1. Revert individual files using git
2. Neovim 0.12.1 supports both old and new APIs during transition

## References

- https://docs.astronvim.com/configuration/v6_migration/
- https://neovim.io/doc/user/news-0.12/