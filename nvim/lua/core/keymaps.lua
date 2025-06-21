-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
vim.keymap.set("n", "<leader>w", "<cmd> w <CR>", opts)

-- Save file in insert mode
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>i", opts)

-- save file without auto-formatting
--vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)
vim.keymap.set("n", "<leader>nf", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<S-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<S-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts)   -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts)      -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts)      -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts)     -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts)   -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts)     --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts)     --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- lspsaga
vim.keymap.set("n", "<leader>ll", ":Lspsaga outline<CR>", opts)
--vim.keymap.set("n", "<C-a>", ":Lspsaga diagnostic_jump_next<CR>", opts)

-- whichkey
vim.keymap.set("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
vim.keymap.set("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })

-- delete a section without yanking
vim.keymap.set("v", "<C-q>", [["_di]], { desc = "Delete selection without yanking" })

-- Comment
vim.keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- dap
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "DAP: Continue" })
vim.keymap.set("n", "<leader>df", "<cmd>lua require'dap'.terminate()<CR>", { desc = "DAP: Terminate" })
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", { desc = "DAP: Step Over" })
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { desc = "DAP: Step Into" })
vim.keymap.set("n", "<leader>d0", "<cmd>lua require'dap'.step_out()<CR>", { desc = "DAP: Step Out" })
vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "DAP: Toggle Breakpoint" })
-- map("n", "<leader>db", function()
--   dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
-- end, { desc = "DAP: Set Conditional Breakpoint" })
