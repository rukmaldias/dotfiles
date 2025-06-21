return {
  "nvim-lualine/lualine.nvim",
  config = function()
    -- stylua: ignore
    local colors = {
      blue   = '#80a0ff',
      cyan   = '#79dac8',
      black  = '#080808',
      white  = '#c6c6c6',
      red    = '#ff5189',
      violet = '#d183e8',
      grey   = '#303030',
      green  = '#98c379',
      orange = '#e5c07b',
    }

    local bubbles_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white },
      },
      insert = { a = { fg = colors.black, bg = colors.blue } },
      visual = { a = { fg = colors.black, bg = colors.cyan } },
      replace = { a = { fg = colors.black, bg = colors.red } },
      inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
      },
    }

    -- LSP status component
    local function lsp_status()
      local clients = vim.lsp.get_clients { bufnr = 0 }
      if #clients == 0 then
        return "No LSP"
      end

      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end

      return "LSP: " .. table.concat(client_names, ", ")
    end

    -- Alternative more detailed LSP status with connection state
    local function detailed_lsp_status()
      local clients = vim.lsp.get_clients { bufnr = 0 }
      if #clients == 0 then
        return ""
      end

      local status_parts = {}
      for _, client in ipairs(clients) do
        local status = "connected"
        if client.is_stopped() then
          status = "stopped"
        elseif not client.initialized then
          status = "connecting..."
        end
        table.insert(status_parts, client.name .. ":" .. status)
      end

      return " " .. table.concat(status_parts, " ")
    end

    require("lualine").setup {
      options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch" },
        lualine_c = {
          "%=", --[[ add your center components here in place of this comment ]]
        },
        lualine_x = {
          -- Simple LSP status
          {
            lsp_status,
            color = { fg = colors.green },
          },
          -- Or use the detailed version instead:
          -- {
          --   detailed_lsp_status,
          --   color = function()
          --     local clients = vim.lsp.get_clients { bufnr = 0 }
          --     if #clients == 0 then
          --       return { fg = colors.grey }
          --     end
          --     for _, client in ipairs(clients) do
          --       if not client.initialized then
          --         return { fg = colors.orange }
          --       elseif client.is_stopped() then
          --         return { fg = colors.red }
          --       end
          --     end
          --     return { fg = colors.green }
          --   end,
          -- },
        },
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    }
  end,
}
