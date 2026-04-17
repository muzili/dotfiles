# AstroNvim v6 Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Migrate AstroNvim config to v6 API, fix clangd integration using system version, and repair broken plugin configs.

**Architecture:** Update three plugin config files to use Neovim 0.12's new `vim.lsp.config` API and fix syntax errors. Keep existing customizations intact while adopting new patterns.

**Tech Stack:** Neovim 0.12.1, AstroNvim 6.0.4, vim.lsp.config API, nvim-treesitter, blink.cmp

---

## File Structure

| File | Action | Responsibility |
|------|--------|----------------|
| `private_dot_config/nvim/lua/plugins/astrolsp.lua` | Modify | LSP server declarations and config using v6 API |
| `private_dot_config/nvim/lua/plugins/blink.lua` | Modify | Fix missing `return opts` in opts function |
| `private_dot_config/nvim/lua/plugins/treesitter.lua` | Modify | Simplify to v6 built-in management style |

---

### Task 1: Fix blink.lua Syntax Error

**Files:**
- Modify: `private_dot_config/nvim/lua/plugins/blink.lua:9-19`

- [ ] **Step 1: Add return opts to fix configuration**

Current file has `opts` function that doesn't return the modified opts table, causing blink.cmp to ignore configuration.

Replace the opts function:

```lua
opts = function(_, opts)
  opts.appearance = {
    nerd_font_variant = "SauceCodePro Nerd Font Mono"
  }
  opts.keymap = opts.keymap or {}
  table.insert(opts.sources.default, 1, "codecompanion")
  return opts
end,
```

- [ ] **Step 2: Verify fix by checking syntax**

Run: `luac -p private_dot_config/nvim/lua/plugins/blink.lua`
Expected: No syntax errors

- [ ] **Step 3: Commit the fix**

```bash
git add private_dot_config/nvim/lua/plugins/blink.lua
git commit -m "fix(blink): add missing return opts in configuration function"
```

---

### Task 2: Migrate astrolsp.lua to v6 API

**Files:**
- Modify: `private_dot_config/nvim/lua/plugins/astrolsp.lua`

- [ ] **Step 1: Add clangd to servers list**

Add `"clangd"` to the servers list at line 51-53:

```lua
servers = {
  "clangd",
},
```

- [ ] **Step 2: Update clangd config key to use bracket syntax**

Change `clangd =` to `["clangd"] =` at line 57:

```lua
config = {
  ["clangd"] = {
```

- [ ] **Step 3: Replace root_pattern with vim.fs.root for clangd**

Replace line 72:

```lua
root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
```

- [ ] **Step 4: Update ts_ls config key**

Change `ts_ls =` to `["ts_ls"] =` at line 76:

```lua
["ts_ls"] = {
```

- [ ] **Step 5: Replace root_pattern with vim.fs.root for ts_ls**

Replace line 77:

```lua
root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }),
```

- [ ] **Step 6: Update eslint config key**

Change `eslint =` to `["eslint"] =` at line 105:

```lua
["eslint"] = {
```

- [ ] **Step 7: Replace root_pattern with vim.fs.root for eslint**

Replace line 106:

```lua
root_dir = vim.fs.root(0, { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".git" }),
```

- [ ] **Step 8: Verify syntax**

Run: `luac -p private_dot_config/nvim/lua/plugins/astrolsp.lua`
Expected: No syntax errors

- [ ] **Step 9: Commit the LSP migration**

```bash
git add private_dot_config/nvim/lua/plugins/astrolsp.lua
git commit -m "feat(lsp): migrate to v6 vim.lsp.config API with vim.fs.root"
```

---

### Task 3: Simplify treesitter.lua

**Files:**
- Modify: `private_dot_config/nvim/lua/plugins/treesitter.lua`

- [ ] **Step 1: Simplify treesitter configuration**

Replace entire file content with simplified v6 version:

```lua
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ignore_install = { "jsonc" }
  end,
}
```

AstroNvim v6 and AstroCommunity packs handle parser installation automatically. Only keep custom ignore_install to use json5 instead of jsonc.

- [ ] **Step 2: Verify syntax**

Run: `luac -p private_dot_config/nvim/lua/plugins/treesitter.lua`
Expected: No syntax errors

- [ ] **Step 3: Commit treesitter simplification**

```bash
git add private_dot_config/nvim/lua/plugins/treesitter.lua
git commit -m "refactor(treesitter): simplify for v6 built-in management"
```

---

### Task 4: Apply Changes and Test

**Files:**
- None (testing only)

- [ ] **Step 1: Apply chezmoi changes to system**

Run: `chezmoi apply`
Expected: Changes applied successfully

- [ ] **Step 2: Open Neovim and verify plugins load**

Run: `nvim --headless -c "lua print('Plugins loaded')" -c "q" 2>&1`
Expected: "Plugins loaded" output, no errors

- [ ] **Step 3: Check LSP health in Neovim**

In Neovim, run: `:checkhealth vim.lsp`
Expected: Shows clangd as available/configured

- [ ] **Step 4: Verify clangd status**

In Neovim (inside a C++ project), run:
```vim
:lua vim.print(vim.lsp.get_clients())
```
Expected: Shows clangd client if in C++ project

- [ ] **Step 5: Test blink.cmp completion**

Open any file, type some text, verify completion popup appears.

- [ ] **Step 6: Verify treesitter highlighting**

Open a TypeScript/JavaScript file, verify syntax highlighting works.

---

## Self-Review Checklist

**Spec Coverage:**
- ✅ clangd in servers list (Task 2, Step 1)
- ✅ vim.fs.root migration (Task 2, Steps 3, 5, 7)
- ✅ bracket syntax for config keys (Task 2, Steps 2, 4, 6)
- ✅ blink.lua return opts fix (Task 1, Step 1)
- ✅ treesitter simplification (Task 3, Step 1)
- ✅ Testing plan (Task 4)

**Placeholder Scan:**
- ✅ No TBD, TODO, or vague descriptions
- ✅ All code blocks contain complete code
- ✅ All commands have expected output

**Type Consistency:**
- ✅ All config keys use bracket syntax consistently
- ✅ vim.fs.root used consistently across all LSP configs