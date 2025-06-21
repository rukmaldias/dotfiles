return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- uncomment for format on save

  cmd = { "ConformInfo" },

  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      python = { "isort", "black" },
      go = { "gofmt", "goimports" },
      rust = { "rustfmt", lsp_format = "fallback" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      java = { "google-java-format" },

      -- css = { "prettier" },
      -- html = { "prettier" },
    },

    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true, go = true, rust = true, java = true }
    --
    --   return {
    --     timeout_ms = 500,
    --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --   }
    -- end,

    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },

    formatters = {
      stylua = { command = vim.fn.stdpath("data") .. "/mason/bin/stylua" },
      gofmt = { command = "gofmt" },
      goimports = { command = vim.fn.stdpath("data") .. "/mason/bin/goimports" },
      black = { command = vim.fn.stdpath("data") .. "/mason/bin/black" },
      isort = { command = vim.fn.stdpath("data") .. "/mason/bin/isort" },
      ["google-java-format"] = { command = vim.fn.stdpath("data") .. "/mason/bin/google-java-format" },
      rustfmt = { command = "rustfmt" },
      clang_format = {
        command = vim.fn.stdpath("data") .. "/mason/bin/clang-format",
        prepend_args = { "--style=file", "--fallback-style=LLVM" },
      },
      shfmt = { prepend_args = { "-i", "4" }, },
    },

  }
}
