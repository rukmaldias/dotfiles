return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup {
      diagnostic = {
        max_height = 0.8,
        keymaps = {
          quit = "<ESC>", --bPrimary quit key
          exec_action = "o",
          toggle_or_jump = "<CR>",
        },
      },
      code_action_prompt = {
        enable = false,
      },
      lightbulb = {
        enable = false, -- disables the lightbulb completely
      },
    }
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
