return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = function()
    local config = require "nvchad.configs.nvimtree"

    -- Override the width setting
    -- config.view.width = 40
    config.view.side = "left"

    return config
  end,
}
