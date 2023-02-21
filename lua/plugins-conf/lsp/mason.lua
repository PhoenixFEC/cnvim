

local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')

if not mason_ok or not mason_lsp_ok then
  return
end

mason.setup {
    ui = {
    		border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
    providers = {
        "mason.providers.client",
        "mason.providers.registry-api",
    },
}

mason_lsp.setup {
		-- A list of servers to automatically install if they're not already installed
    ensure_installed = {
        -- "arduino_language_server", -- Arduino
        "bashls",
        "clangd", -- C, C++
        "cssls",
        -- "cssmodules_ls",
        "eslint",
        -- "elixirls",
        -- "elmls",
        "emmet_ls",
        -- "golangci_lint_ls", -- Go
        -- "gopls", -- Go
        "gradle_ls",
        "grammarly",
        "graphql",
        "html",
        "jsonls",
        "jdtls", -- Java
        "jedi_language_server", -- python
        -- "sumneko_lua", -- Lua
        "lua_ls", -- Lua
        -- "psalm", -- php
        "prismals",
        "spectral", -- openAPI
        "sqlls",
        "svelte",
        "tailwindcss",
        "tsserver", -- JavaScript, TypeScript
        -- "vtsls", -- JavaScript, TypeScript
        -- "kotlin_language_server",
        -- "ltex", -- LaTeX
        -- "texlab", -- LaTeX
        "vimls", -- vimL
        "volar", -- Vue
        "vuels", -- Vue
        "lemminx", -- XML
        "yamlls", -- YMAL
        "zk", -- markdown
    },


  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
}
