-- restore cursor position when opening file
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		vim.cmd([[
			if line("'\"") > 1 && line("'\"") <= line("$") |
			execute "normal! g`\"" |
			endif
		]])
	end,
})
