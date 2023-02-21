-- restore cursor position when opening file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
  	vim.cmd [[
			if line("'\"") > 1 && line("'\"") <= line("$") |
			execute "normal! g`\"" |
			endif
		]]
	end
})

-- Dashboard
-- vim.cmd [[
	-- " autocmd VimEnter,BufEnter FileType Dashboard set nocursorline
-- ]]

-- vim-visual-multi
vim.cmd([[
	aug VMlens
		au!
		au User visual_multi_start lua require("plugins-conf.nvim-hlslens").start()
		au User visual_multi_exit lua require("plugins-conf.nvim-hlslens").exit()
	aug END
]])
