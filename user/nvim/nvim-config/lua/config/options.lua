-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- close spell check
opt.spelllang = { "en", "cjk" }

-- set encodings
opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"

-- set linebreak
opt.linebreak = true

-- So that `` is visible in markdown files (default: 1)
opt.conceallevel = 0
