require "nvchad.options"

-- add yours here!
local o = vim.o
local opt = vim.opt
local wo = vim.wo

wo.number = true

o.relativenumber = true
o.tabstop = 2
o.shiftwidth = 2
o.virtualedit = "block"
o.inccommand = "split"
o.ignorecase = true
o.termguicolors = true
o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim. (default: '')
o.undofile = true -- Save undo history (default: false)
--o.scrolloff = 999

opt.runtimepath:remove "/usr/share/vim/vimfiles" -- Separate Vim plugins from Neovim in case Vim still in use

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- cursor line
opt.cursorline = true
vim.opt.cursorlineopt = "number" -- Highlight only the line number
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fab6c7", bold = true }) -- Set line number color (e.g., red) and bold
vim.opt.numberwidth = 4
