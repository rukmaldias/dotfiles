return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow", 
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
    
    local hooks = require "ibl.hooks"
    -- Create rainbow colors
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      -- vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      -- vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      -- vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      -- vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      -- vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      -- vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#66595a" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#6b6559" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#52606b" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#635445" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#464f3f" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#533e59" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#374f52" })

      
      -- Custom scope highlight
      vim.api.nvim_set_hl(0, "IblScopeChar", { fg = "#b5a37f", bold = false })
      
      -- Custom whitespace highlights
      vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#3B4048" })
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B4048" })
    end)
    
    require("ibl").setup({
      -- Basic configuration
      enabled = true,
      debounce = 200,
      viewport_buffer = {
        min = 30,
        max = 500,
      },
      
      -- Indent configuration
      indent = {
        --char = "│",
        --char = "▏",
        char = "┊",
        -- Alternative characters: "▏", "┊", "┆", "¦", "|", "⎸", "▎"
        tab_char = "│",
        highlight = highlight,
        smart_indent_cap = true,
        priority = 2,
      },
      
      -- Whitespace configuration
      whitespace = {
        highlight = { "IblWhitespace" },
        remove_blankline_trail = true,
      },
      
      -- Scope configuration (current context highlighting)
      scope = {
        enabled = true,
        --char = "▎",
        char = "▎",
        -- Alternative scope chars: "║", "┃", "█", "▌", "▎", "▍", "▋"
        highlight = "IblScopeChar",
        priority = 1024,
        include = {
          node_type = {
            ["*"] = {
              "class",
              "return_statement",
              "function",
              "method",
              "^if",
              "^while",
              "jsx_element",
              "^for",
              "^object",
              "^table",
              "block",
              "arguments",
              "if_statement",
              "else_clause",
              "jsx_element",
              "jsx_self_closing_element",
              "try_statement",
              "catch_clause",
              "import_statement",
              "operation_type",
            },
            lua = {
              "return_statement",
              "table_constructor",
            },
            typescript = {
              "statement_block",
              "function_declaration",
              "arrow_function",
              "generator_function_declaration",
              "method_definition",
            },
            python = {
              "function_definition",
              "class_definition",
              "for_statement",
              "while_statement",
              "if_statement",
              "with_statement",
              "try_statement",
            },
            rust = {
              "impl_item",
              "struct_item",
              "enum_item",
              "function_item",
              "closure_expression",
              "match_expression",
            },
            go = {
              "function_declaration",
              "method_declaration",
              "func_literal",
              "type_declaration",
              "if_statement",
              "for_statement",
            },
            java = {
              "class_declaration",
              "method_declaration",
              "constructor_declaration",
              "if_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
            },
            c = {
              "function_definition",
              "if_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
              "case_statement",
            },
            cpp = {
              "function_definition",
              "class_specifier",
              "if_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
              "namespace_definition",
            },
          },
        },
        exclude = {
          language = {},
          node_type = {
            ["*"] = {
              "source_file",
              "program",
            },
            lua = {
              "chunk",
            },
            python = {
              "module",
            },
          },
        },
      },
      
      -- Exclude certain filetypes and buftypes
      exclude = {
        filetypes = {
          "lspinfo",
          "packer",
          "checkhealth",
          "help",
          "man",
          "gitcommit",
          "TelescopePrompt",
          "TelescopeResults",
          "NvimTree",
          "neo-tree",
          "dashboard",
          "alpha",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "trouble",
          "Trouble",
          "",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    })
    
    -- Custom keymaps for toggling
    vim.keymap.set("n", "<leader>ti", function()
      require("ibl").setup_buffer(0, { enabled = not require("ibl.config").get_config(0).enabled })
    end, { desc = "Toggle indent-blankline" })
    
    vim.keymap.set("n", "<leader>ts", function()
      local config = require("ibl.config").get_config(0)
      require("ibl").setup_buffer(0, { 
        scope = { enabled = not config.scope.enabled }
      })
    end, { desc = "Toggle scope highlighting" })
    
    -- Auto-commands for specific behaviors
    local group = vim.api.nvim_create_augroup("IndentBlanklineCustom", { clear = true })
    
    -- Disable in certain contexts
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "markdown", "text", "rst" },
      callback = function()
        require("ibl").setup_buffer(0, { enabled = false })
      end,
    })
    
    -- Different styles for different languages
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "python", "yaml", "yml" },
      callback = function()
        require("ibl").setup_buffer(0, {
          indent = {
            char = "▏",
            highlight = { "RainbowBlue" },
          },
          scope = {
            char = "▍",
          },
        })
      end,
    })
    
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "javascript", "typescript", "jsx", "tsx" },
      callback = function()
        require("ibl").setup_buffer(0, {
          indent = {
            char = "┊",
            highlight = highlight,
          },
          scope = {
            char = "┃",
            highlight = "RainbowYellow",
          },
        })
      end,
    })
    
    -- Minimal style for specific files
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "json", "jsonc" },
      callback = function()
        require("ibl").setup_buffer(0, {
          indent = {
            char = "·",
            highlight = { "Comment" },
          },
          scope = {
            enabled = false,
          },
        })
      end,
    })
  end,
}
