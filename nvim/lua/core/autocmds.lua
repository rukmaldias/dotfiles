vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = false -- use tabs, not spaces
  end,
})

-- augroup to be able to trigger the autocommand explicitly for the first time
vim.api.nvim_create_augroup("dap_colors", {})

-- autocmd to enforce colors settings on any color scheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "dap_colors",
  pattern = "*",
  desc = "Set DAP marker colors and prevent color theme from resetting them",
  callback = function()
    -- Reuse current SignColumn background (except for DapStoppedLine)
    local sign_column_hl = vim.api.nvim_get_hl(0, { name = "SignColumn" })
    -- if bg or ctermbg aren't found, use bg = 'bg' (which means current Normal) and ctermbg = 'Black'
    -- convert to 6 digit hex value starting with #
    local sign_column_bg = (sign_column_hl.bg ~= nil) and ("#%06x"):format(sign_column_hl.bg) or "bg"
    local sign_column_ctermbg = (sign_column_hl.ctermbg ~= nil) and sign_column_hl.ctermbg or "Black"

    vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00ff00", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e4d3d", ctermbg = "Green" })
    vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#c23127", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
    vim.api.nvim_set_hl(
      0,
      "DapBreakpointRejected",
      { fg = "#888ca6", bg = sign_column_bg, ctermbg = sign_column_ctermbg }
    )
    vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = sign_column_bg, ctermbg = sign_column_ctermbg })
  end,
})

-- executing the settings explicitly for the first time
vim.api.nvim_exec_autocmds("ColorScheme", { group = "dap_colors" })

function ToggleTheme()
  -- Get current colorscheme name instead of background
  local current_colorscheme = vim.g.colors_name or ""

  if current_colorscheme == "onedark" or vim.o.background == "dark" then
    vim.cmd "colorscheme onelight"
    vim.o.background = "light" -- Explicitly set background
  else
    vim.cmd "colorscheme onedark"
    vim.o.background = "dark" -- Explicitly set background
  end
end

-- Togggle theme
vim.keymap.set("n", "<leader>th", ToggleTheme, { desc = "Toggle theme" })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     print("LSP attached:", client.name, "to buffer", args.buf)
--   end,
-- })
