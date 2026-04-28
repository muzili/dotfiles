-- Markdown specific settings
---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        markdown_wrap = {
          {
            event = "FileType",
            pattern = "markdown",
            callback = function()
              vim.opt_local.wrap = true -- enable line wrap for viewing
              vim.opt_local.linebreak = true -- wrap at word boundaries, not mid-word
              vim.opt_local.breakindent = true -- preserve indentation on wrapped lines
              -- Optional: navigation mappings for wrapped lines
              vim.keymap.set("n", "j", "gj", { buffer = true, desc = "Move down (visual line)" })
              vim.keymap.set("n", "k", "gk", { buffer = true, desc = "Move up (visual line)" })
            end,
          },
        },
      },
    },
  },
}