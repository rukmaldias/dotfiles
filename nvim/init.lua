require "core.options"
require "core.keymaps"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup {
  -- Themes
  require "themes.onedark",

  -- Other plugins
  require "plugins.nvim-tree",
  require "plugins.misc",
  require "plugins.alpha",
  require "plugins.crates",
  require "plugins.gitsigns",
  require "plugins.conform",
  require "plugins.treesitter",
  require "plugins.markdown",
  require "plugins.trouble",
  require "plugins.bufferline",
  require "plugins.indent-blankline",
  require "plugins.lspsaga",
  require "plugins.vim-airline",
  require "plugins.oil",
  require "plugins.yazi",
  require "plugins.telescope",
  require "plugins.nvim-cmp",
  require "plugins.mason",
  require "plugins.lspconfig",
  require "plugins.nvim-dap",
  require "plugins.nvim-dap-ui",
  require "plugins.nvim-dap-vt",
  require "plugins.rustaceanvim",
}

require "core.autocmds"

vim.cmd.colorscheme "onedark"
