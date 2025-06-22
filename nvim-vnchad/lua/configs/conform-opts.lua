local opts = {
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

  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true, go = true, rust = true, java = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,

  formatters = {
    clang_format = {
      prepend_args = { "--style=file", "--fallback-style=LLVM" },
    },

    shfmt = {
      prepend_args = { "-i", "4" },
    },
  },
}

return opts
