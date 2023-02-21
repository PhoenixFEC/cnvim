local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not lspconfig_ok or not cmp_nvim_lsp_ok then
	return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ virtual_text = true }
	),
}

local function on_attach(client, bufnr)
	-- set up buffer keymaps, etc.
	require("plugins-conf.lsp.keymappings").lsp_keymap(client, bufnr)
end

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local typescript_ok, typescript = pcall(require, "typescript")

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescript_ok then
	typescript.setup({
		disable_commands = false, -- prevent the plugin from creating Vim commands
		debug = false, -- enable debug logging for commands
		-- LSP Config options
		server = {
			capabilities = require("plugins-conf.lsp.servers.tsserver").capabilities,
			handlers = require("plugins-conf.lsp.servers.tsserver").handlers,
			on_attach = require("plugins-conf.lsp.servers.tsserver").on_attach,
			settings = require("plugins-conf.lsp.servers.tsserver").settings,
		},
	})
end

-- local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
-- if mason_lspconfig_ok then
-- 		mason_lspconfig.setup_handlers {
-- 						-- The first entry (without a key) will be the default handler
-- 				-- and will be called for each installed server that doesn't have
-- 				-- a dedicated handler.
-- 				function (server_name) -- default handler (optional)
-- 						lspconfig[server_name].setup {
-- 								on_attach = on_attach,
-- 						}
-- 				end,
-- 				-- Next, you can provide a dedicated handler for specific servers.
-- 				-- For example, a handler override for the `rust_analyzer`:
-- 				-- ["rust_analyzer"] = function ()
-- 				--     require("rust-tools").setup {}
-- 				-- end
-- 				["sumneko_lua"] = function ()
-- 						lspconfig.sumneko_lua.setup {
-- 								on_attach = on_attach,
-- 								settings = {
-- 										runtime = {
-- 												version = 'LuaJIT'
-- 										},
-- 										Lua = {
-- 												diagnostics = {
-- 														globals = { "vim" }
-- 												}
-- 										},
-- 										workspace = {
-- 												library = vim.api.nvim_get_runtime_file("", true)
-- 										},
-- 										telemetry = {
-- 												enable = false
-- 										}
-- 								}
-- 						}
-- 				end,
-- 		}
-- end

lspconfig.vuels.setup({
	filetypes = require("plugins-conf.lsp.servers.vuels").filetypes,
	handlers = handlers,
	init_options = require("plugins-conf.lsp.servers.vuels").init_options,
	on_attach = on_attach,
})

lspconfig.tailwindcss.setup({
	capabilities = require("plugins-conf.lsp.servers.tailwindcss").capabilities,
	filetypes = require("plugins-conf.lsp.servers.tailwindcss").filetypes,
	handlers = handlers,
	init_options = require("plugins-conf.lsp.servers.tailwindcss").init_options,
	on_attach = require("plugins-conf.lsp.servers.tailwindcss").on_attach,
	settings = require("plugins-conf.lsp.servers.tailwindcss").settings,
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = require("plugins-conf.lsp.servers.cssls").on_attach,
	settings = require("plugins-conf.lsp.servers.cssls").settings,
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = require("plugins-conf.lsp.servers.eslint").on_attach,
	settings = require("plugins-conf.lsp.servers.eslint").settings,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("plugins-conf.lsp.servers.jsonls").settings,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "bit" },
			},
		},
	},
})

-- local language_servers = lspconfig.util.available_servers()
local other_language_servers = {
	"bashls",
	"clangd",
	"emmet_ls",
	"gradle_ls",
	"grammarly",
	"graphql",
	"html",
	"jdtls",
	"jedi_language_server",
	"prismals",
	"spectral",
	"sqlls",
	"svelte",
	"tsserver",
	"vimls",
	"volar",
	"lemminx",
	"yamlls",
	"zk",
}
for _, ls in ipairs(other_language_servers) do
	lspconfig[ls].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
	})
end
