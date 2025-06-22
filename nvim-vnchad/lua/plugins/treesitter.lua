return {
  "nvim-treesitter/nvim-treesitter",
  -- version = "v0.10.0",

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  build = ":TSUpdate", -- Automatically update parsers
  event = { "BufReadPost", "BufNewFile" }, -- Lazily load on file open

  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "c",
        "lua",
        "java",
        "rust",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
      },

      highlight = {
        enable = true,
        --disable = { "lua", "c", "rust", "python" },
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
          node_incremental = "<leader>si",
          scope_incremental = "<leader>sc",
          node_decremental = "<leader>sd",
        },
      },

      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          },

          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_surrounding_whitespace = true,
        },
      },
    }
  end,
}
