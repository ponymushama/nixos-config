-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Normal Mode --
-- H 行首 L 行尾
map({ "n", "x" }, "H", "v:count == 0 ? '^' : 'H'", { expr = true, silent = true })
map({ "n", "x" }, "L", "v:count == 0 ? '$' : 'L'", { expr = true, silent = true })
-- Disable arrow keys in normal mode
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
-- delete single character without copying into register
map("n", "x", '"_x')
-- Vertical scroll and center
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- Find and center
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Insert Mode --
-- press jk fast to exit insert mode
map("i", "jk", "<ESC>", { remap = true })
map("i", "kj", "<ESC>", { remap = true })

-- Visual Mode --
-- Keep last yanked when pasting
map("v", "p", '"_dP', { remap = true })
