-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- 自动选择 Python host program
local function detect_python()
  -- 1. 项目级 uv venv
  local venv = vim.fn.getcwd() .. "/.venv/bin/python"
  if vim.fn.executable(venv) == 1 then return venv end

  -- 2. mise 提供的 python
  local mise_python = vim.fn.system("mise which python"):gsub("\n", "")
  if vim.fn.executable(mise_python) == 1 then return mise_python end

  -- 3. 系统默认 python
  return vim.fn.exepath "python3"
end

vim.g.python3_host_prog = detect_python()

require "lazy_setup"
require "polish"
