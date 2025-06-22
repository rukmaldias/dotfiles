return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false, -- This plugin is already lazy

  ["rust-analyzer"] = {
    cargo = {
      allFeatures = true,
    },
  },

  config = function()
    local codelldb_path = "/Users/rukmaldias/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb"
    local liblldb_apth = "/Users/rukmaldias/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
    local cfg = require "rustaceanvim.config"

    vim.g.rustaceanvim = {
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_apth),
      },
    }
  end,
}
