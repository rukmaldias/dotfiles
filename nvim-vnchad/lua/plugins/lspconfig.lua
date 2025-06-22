return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },

  config = function()
    require("nvchad.configs.lspconfig").defaults()

    local lspconfig = require "lspconfig"
    local util = require "lspconfig.util"

    require("mason").setup {
      opts = {
        ensure_installed = {
          "lua",
          "clangd",
          "rust-analyzer",
          "codelldb",
          "dockerls",
          "gopls",

          -- formatters
          "stylua",
          "shfmt",
          "isort",
          "black",
          "goimports",
          "google-java-format",
        },
      },
    }

    require("mason-lspconfig").setup {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "dockerls",
        -- manually attached:
        -- "jdtls", "clangd", "rust_analyzer", "gopls"
      },

      handlers = {
        function(server_name)
          local skip = {
            jdtls = true,
            clangd = true,
            rust_analyzer = true,
            gopls = true,
          }
          if not skip[server_name] then
            lspconfig[server_name].setup {}
          end
        end,
      },
    }

    -- Utility function for safe LSP attach
    local function attach_lsp(server, config)
      local root = config.root_dir or vim.fn.getcwd()

      local existing_clients = vim.lsp.get_clients {
        filter = function(client)
          return client.name == server and client.config.root_dir == root
        end,
      }

      if #existing_clients > 0 then
        return -- LSP already attached to this root
      end

      config.root_dir = root
      config.on_attach = function(client, bufnr)
        -- vim.notify("✅ LSP attached: " .. client.name .. " (buffer " .. bufnr .. ")")
      end

      require("lspconfig")[server].start_client(config)
    end

    -- Java (jdtls)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        --local jdtls = require "jdtls"
        local ok, jdtls = pcall(require, "jdtls")
        if not ok then
          return
        end -- jdtls not loaded yet
        local root_dir = require("jdtls.setup").find_root { "pom.xml", "build.gradle", ".git" } or vim.fn.getcwd()

        local workspace_dir = vim.fn.stdpath "cache" .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

        local active = vim.lsp.get_clients {
          filter = function(client)
            return client.name == "jdtls" and client.config.root_dir == root_dir
          end,
        }
        if #active > 0 then
          return
        end

        jdtls.start_or_attach {
          cmd = {
            "jdtls",
            "-configuration",
            "/Users/rukmaldias/.cache/jdtls/config",
            "-data",
            workspace_dir,
          },
          root_dir = root_dir,
        }
      end,
    })

    -- C/C++ (clangd)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp", "objc", "objcpp" },
      callback = function()
        local root = util.root_pattern("compile_commands.json", ".git")(vim.fn.expand "%:p") or vim.fn.getcwd()
        attach_lsp("clangd", {
          cmd = { "clangd", "--background-index", "--offset-encoding=utf-8" },
          root_dir = root,
        })
      end,
    })

    -- Rust (rust-analyzer)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "rust",
      callback = function()
        local root = util.root_pattern("Cargo.toml", ".git")(vim.fn.expand "%:p") or vim.fn.getcwd()
        attach_lsp("rust_analyzer", {
          cmd = { "rust-analyzer" },
          root_dir = root,
          settings = {
            ["rust-analyzer"] = {
              diagnostics = { enable = true },
              inlayHints = { enable = true },
            },
          },
        })
      end,
    })

    -- (gopls)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        local root = util.root_pattern("go.mod", ".git")(vim.fn.expand "%:p") or vim.fn.getcwd()
        attach_lsp("gopls", {
          cmd = { "gopls" },
          root_dir = root,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        })
      end,
    })
  end,
}
