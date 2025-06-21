return {
  {
    "vim-airline/vim-airline",
    dependencies = {
      "vim-airline/vim-airline-themes",
    },
    config = function()
      -- Basic settings
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_theme = "onedark" -- Choose your theme
      -- Enable tabline
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
      vim.g["airline#extensions#tabline#show_buffers"] = 1
      vim.g["airline#extensions#tabline#show_tabs"] = 1
      vim.g["airline#extensions#tabline#tab_nr_type"] = 1
      -- Configure sections
      vim.g["airline#extensions#default#layout"] = {
        { "a", "b", "c" },
        { "x", "y", "z" },
      }
      -- Customize what's shown
      vim.g["airline#extensions#branch#enabled"] = 1
      vim.g["airline#extensions#hunks#enabled"] = 1
      vim.g["airline#extensions#syntastic#enabled"] = 1
      vim.g["airline#extensions#ale#enabled"] = 1
      -- Performance settings
      vim.g.airline_skip_empty_sections = 1
      vim.g.airline_highlighting_cache = 1
      -- Custom symbols (if using powerline fonts)
      if vim.g.airline_powerline_fonts == 1 then
        vim.g.airline_left_sep = ""
        vim.g.airline_left_alt_sep = ""
        vim.g.airline_right_sep = ""
        vim.g.airline_right_alt_sep = ""
      end

      -- Mode display (FIXED - no duplicate keys)
      vim.g.airline_mode_map = {
        ["__"] = "-",
        ["c"] = "C",
        ["i"] = "I",
        ["ic"] = "I",
        ["ix"] = "I",
        ["n"] = "N",
        ["multi"] = "M",
        ["ni"] = "N",
        ["no"] = "N",
        ["R"] = "R",
        ["Rv"] = "R",
        ["s"] = "S",
        ["S"] = "S-LINE",
        ["\19"] = "S-BLOCK", -- CTRL-S for select block mode
        ["t"] = "T",
        ["v"] = "V",
        ["V"] = "V-LINE",
        ["\22"] = "V-BLOCK", -- CTRL-V for visual block mode
      }

      -- Method 3: LSP Status Integration
      -- Create LSP status module
      local lsp_status_airline = {}

      function lsp_status_airline.get_status()
        local clients = vim.lsp.get_active_clients { bufnr = 0 }
        if #clients == 0 then
          return "󰅚 No LSP"
        end

        local client_names = {}
        for _, client in ipairs(clients) do
          -- Use shorter names for common servers
          local name = client.name
          if name == "lua_ls" then
            name = "Lua"
          elseif name == "pyright" then
            name = "Python"
          elseif name == "pylsp" then
            name = "Python"
          elseif name == "tsserver" then
            name = "TS"
          elseif name == "typescript-language-server" then
            name = "TS"
          elseif name == "rust_analyzer" then
            name = "Rust"
          elseif name == "gopls" then
            name = "Go"
          elseif name == "clangd" then
            -- Detect if it's C or C++ based on file extension
            local filetype = vim.bo.filetype
            if filetype == "c" then
              name = "C"
            elseif filetype == "cpp" or filetype == "cxx" or filetype == "cc" then
              name = "C++"
            else
              name = "C/C++"
            end
          elseif name == "ccls" then
            -- Same logic for ccls
            local filetype = vim.bo.filetype
            if filetype == "c" then
              name = "C"
            elseif filetype == "cpp" or filetype == "cxx" or filetype == "cc" then
              name = "C++"
            else
              name = "C/C++"
            end
          elseif name == "jdtls" then
            name = "Java"
          elseif name == "html" then
            name = "HTML"
          elseif name == "cssls" then
            name = "CSS"
          elseif name == "jsonls" then
            name = "JSON"
          elseif name == "yamlls" then
            name = "YAML"
          elseif name == "bashls" then
            name = "Bash"
          elseif name == "vimls" then
            name = "Vim"
          end
          table.insert(client_names, name)
        end

        -- Get diagnostic counts
        local diagnostics = vim.diagnostic.get(0)
        local errors = 0
        local warnings = 0
        local hints = 0
        local info = 0

        for _, diagnostic in ipairs(diagnostics) do
          if diagnostic.severity == vim.diagnostic.severity.ERROR then
            errors = errors + 1
          elseif diagnostic.severity == vim.diagnostic.severity.WARN then
            warnings = warnings + 1
          elseif diagnostic.severity == vim.diagnostic.severity.HINT then
            hints = hints + 1
          elseif diagnostic.severity == vim.diagnostic.severity.INFO then
            info = info + 1
          end
        end

        local status = "󰒋 " .. table.concat(client_names, ",")

        local diagnostic_parts = {}
        if errors > 0 then
          table.insert(diagnostic_parts, "🚨" .. errors)
        end
        if warnings > 0 then
          table.insert(diagnostic_parts, "⚠️" .. warnings)
        end
        if hints > 0 then
          table.insert(diagnostic_parts, "💡" .. hints)
        end
        if info > 0 then
          table.insert(diagnostic_parts, "ℹ️" .. info)
        end

        if #diagnostic_parts > 0 then
          status = status .. " " .. table.concat(diagnostic_parts, " ")
        end

        return status
      end

      -- Make the module globally available
      _G.lsp_status_airline = lsp_status_airline

      -- Register custom airline section function
      vim.cmd [[
        function! AirlineLSPStatus()
          return luaeval('_G.lsp_status_airline.get_status()')
        endfunction
        
        " Method 3: Add LSP status to section x (replaces file type)
        let g:airline_section_x = '%{AirlineLSPStatus()}'
        
        " Alternative options (uncomment one of these instead if preferred):
        
        " Option A: Add to section y (file encoding area)
        " let g:airline_section_y = '%{AirlineLSPStatus()} %{&fenc?&fenc:&enc}'
        
        " Option B: Add to section z (position area)
        " let g:airline_section_z = '%{AirlineLSPStatus()} %3p%% %l:%c'
        
        " Option C: Add to section c (filename area)
        " let g:airline_section_c = '%t %{AirlineLSPStatus()}'
        
        " Option D: Create custom section between existing ones
        " let g:airline_section_x = '%{&filetype} %{AirlineLSPStatus()}'
      ]]

      -- Auto-refresh airline when LSP status changes
      local airline_refresh_group = vim.api.nvim_create_augroup("AirlineLSPRefresh", { clear = true })

      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        group = airline_refresh_group,
        callback = function()
          -- Small delay to prevent too frequent updates
          vim.defer_fn(function()
            vim.cmd "AirlineRefresh"
          end, 100)
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = airline_refresh_group,
        callback = function()
          vim.cmd "AirlineRefresh"
        end,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = airline_refresh_group,
        callback = function()
          vim.cmd "AirlineRefresh"
        end,
      })

      -- Refresh on buffer change
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        group = airline_refresh_group,
        callback = function()
          vim.cmd "AirlineRefresh"
        end,
      })
    end,
  },
}
