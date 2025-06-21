return {
  "nvim-tree/nvim-tree.lua",

  lazy = true,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeFocus" },

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
    { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
  },

  config = function()
    require("nvim-tree").setup {

      view = {
        width = 32,
      },

      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
      },

      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings (you can keep these or remove)
        api.config.mappings.default_on_attach(bufnr)

        -- Custom keymaps for setting root
        vim.keymap.set("n", "<leader>r", api.tree.change_root_to_node, opts "Set as root")
        vim.keymap.set("n", "<leader>u", api.tree.change_root_to_parent, opts "Up to parent")
        vim.keymap.set("n", ".", api.tree.change_root_to_node, opts "Set as root")
      end,
    }
  end,
}
