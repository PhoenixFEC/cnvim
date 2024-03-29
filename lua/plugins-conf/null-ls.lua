local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- you can reuse a shared lspconfig on_attach callback here
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
				-- vim.lsp.buf.formatting_sync()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

null_ls.setup({
	sources = {
		-- null_ls.builtins.code_actions.gitsigns,
		-- null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.formatting.prettierd,
		require("typescript.extensions.null-ls.code-actions"),
		-- null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.diagnostics.flake8,
	},
	on_attach = on_attach,
})
