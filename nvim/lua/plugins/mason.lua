return {

  "williamboman/mason.nvim",

  dependencies = {
    "williamboman/mason-lspconfig.nvim"
  },

  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = { "lua_ls", "pyright", "gopls", "jdtls" },
      -- ensure_installed = { "lua_ls", "pyright", "gopls", "jdtls", "rust_analyzer", "clangd" },

      automatic_installation = true,
      handlers = {
        -- Disable default setup for lua_ls and pyright
        ["lua_ls"] = function() end, -- Empty handler to skip auto-setup
        ["pyright"] = function() end,
        ["gopls"] = function() end,
        ["jdtls"] = function() end,
        ["rust_analyzer"] = function() end, -- using local
        ["clangd"] = function() end,        -- using local
      },
    })
  end,

}
