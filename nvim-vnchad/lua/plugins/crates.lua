return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" }, -- Load only for Cargo.toml
  config = function()
    require("crates").setup {
      completion = {
        cmp = {
          enabled = true,
        },
      },
    }
    require("cmp").setup.buffer {
      sources = {
        { name = "crates" },
      },
    }
  end,
}
