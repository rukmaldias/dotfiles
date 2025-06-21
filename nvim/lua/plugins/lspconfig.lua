return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
    },
  },

  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    -- Define on_attach function
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      --key mappings
      keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

      -- <leader>f formatting is being used in conform
      -- vim.keymap.set("n", "<leader>f", function()
      --   vim.lsp.buf.format { async = true }
      -- end, opts)
    end

    -- Get LSP capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Optional: Set diagnostic signs
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
    })

    -- Define signs for diagnostics
    local signs = { Error = "●", Warn = "󰀪 ", Hint = "󰋽 ", Info = "󰌶 " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- clangd
    lspconfig["clangd"].setup({
      on_attach = on_attach,       -- Attach the on_attach function
      capabilities = capabilities, -- Pass capabilities separately
      cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      init_options = {
        clangdFileStatus = true,
      },
      settings = {
        clangd = {
          offsetEncoding = "utf-16", -- Moved offsetEncoding here, though clangd typically handles this automatically
        },
      },
    })

    -- Lua (lua_ls)
    lspconfig["lua_ls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_dir = require("lspconfig.util").root_pattern(".git", "init.lua") or vim.fn.getcwd(),
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT", -- For Neovim
          },
          diagnostics = {
            globals = { "vim" }, -- Recognize Neovim globals
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime
            checkThirdParty = false,                           -- Avoid third-party prompts
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- rust-analyzer
    -- lspconfig["rust_analyzer"].setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   cmd = { "rust-analyzer" },
    --   filetypes = { "rust" },
    --
    --   root_dir = function(fname)
    --     return vim.fs.dirname(vim.fs.find({ "Cargo.toml", ".git" }, { upward = true, path = fname })[1]) or
    --         vim.loop.cwd()
    --   end,
    --
    --   init_options = {
    --     checkOnSave = {
    --       command = "clippy", -- Run clippy for diagnostics on save
    --     },
    --   },
    --   settings = {
    --     ["rust-analyzer"] = {
    --       diagnostics = {
    --         enable = true,
    --       },
    --       cargo = {
    --         allFeatures = true, -- Build with all features enabled
    --       },
    --       procMacro = {
    --         enable = true, -- Enable proc-macro support
    --       },
    --     },
    --   },
    -- })

    -- Go
    lspconfig["gopls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = require("lspconfig.util").root_pattern("go.mod", ".git") or vim.fn.getcwd(),
      init_options = {
        usePlaceholders = true,
      },
      settings = {
        gopls = {
          analyses = { unusedparams = true },
          staticcheck = true,
          hints = { parameterNames = true },
        },
      },
    })

    -- Python
    lspconfig["pyright"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_dir = function(fname)
        -- Use file's directory as root for standalone files
        return vim.fn.fnamemodify(fname, ":p:h")
      end,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "basic",
            diagnosticSeverityOverrides = {
              reportUnusedVariable = "warning",
            },
          },
        },
      },
    })

    -- Java (jdtls)
    lspconfig["jdtls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {
        "/usr/local/bin/jdtls",
        "--jvm-arg=-Xms1g",
        "--jvm-arg=-Xmx2g",
      },
      filetypes = { "java" },
      root_dir = require("lspconfig.util").root_pattern("pom.xml", "build.gradle", ".git") or vim.fn.getcwd(),
      settings = {
        java = {
          autobuild = { enabled = true },
          signatureHelp = { enabled = true },
          import = { enabled = true },
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath("config") .. "/lsp/java-formatter.xml",
            },
          },
          configuration = {
            runtimes = {
              {
                name = "Java-17",
                path = "/path/to/java-17",
              },
            },
          },
        },
      },
      init_options = {
        bundles = {},
      },
    })
  end,
}
