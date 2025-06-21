return {
  "olimorris/onedarkpro.nvim",

  priority = 1000,
  
  config = function()
    require("onedarkpro").setup {
      -- highlights
      highlights = {
        Comment = { italic = true },
        Directory = { bold = true },
        ErrorMsg = { italic = true, bold = true },
      },
      -- styles
      styles = {
        types = "NONE",
        methods = "NONE",
        numbers = "NONE",
        strings = "NONE",
        comments = "italic",
        keywords = "italic",
        constants = "NONE",
        functions = "italic",
        operators = "NONE",
        variables = "NONE",
        parameters = "NONE",
        conditionals = "italic",
        virtual_text = "NONE",
      },
      -- file types
      filetypes = {
        markdown = false,
      },
      -- inactive windows
      options = {
        highlight_inactive_windows = true,
      },
    }
  end,
}
