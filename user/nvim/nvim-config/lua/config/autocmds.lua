-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local autocmd = vim.api.nvim_create_autocmd

-- IM switch
local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})
autocmd("InsertLeave", {
  group = myAutoGroup,
  callback = require("utils.macism").macInsertLeave,
})
autocmd("InsertEnter", {
  group = myAutoGroup,
  callback = require("utils.macism").macInsertEnter,
})

-- toggle markdown conceal
autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal conceallevel=0",
})

-- close markdown spellcheck
autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal nospell",
})

-- close markdown diagnostic
local function disable_diagnostics()
  vim.diagnostic.enable(false)
end
autocmd("FileType", {
  pattern = "markdown",
  callback = disable_diagnostics,
})

-- set markdown color theme
-- vim.cmd([[
-- augroup MarkdownSettings
-- autocmd!
-- autocmd FileType markdown colorscheme catppuccin-latte
-- augroup END
-- ]])

-- remove IM switch Focus
-- autocmd("FocusGained", {
--   group = myAutoGroup,
--   callback = require("utils.macism").macFocusGained,
-- })
-- autocmd("FocusLost", {
--   group = myAutoGroup,
--   callback = require("utils.macism").macFocusLost,
-- })
