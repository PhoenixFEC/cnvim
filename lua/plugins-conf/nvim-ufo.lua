local ok, ufo = pcall(require, "ufo")
if not ok then
	return
end

local M = {}

-- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
local ftMap = {
	vim = 'indent',
	python = {'indent'},
	git = ''
}

local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (' ✧✧⌇ ⚡︎ %d '):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, {chunkText, hlGroup})
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, {suffix, 'MoreMsg'})
	return newVirtText
end

local setup_ufo = function()
	vim.o.foldcolumn = '0' -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	ufo.setup({
		fold_virt_text_handler = handler,
		open_fold_hl_timeout = 150,
		close_fold_kinds = {'imports', 'comment'},
		preview = {
			win_config = {
				border = {'', '─', '', '', '', '─', '', ''},
				winhighlight = 'Normal:Folded',
				winblend = 0
			},
			mappings = {
				scrollU = '<C-u>',
				scrollD = '<C-d>',
				jumpTop = '[',
				jumpBot = ']'
			}
		},
		-- provider_selector = function(bufnr, filetype, buftype)
		provider_selector = function()
			-- if you prefer treesitter provider rather than lsp,
			-- return ftMap[filetype] or {'treesitter', 'indent'}
			return {'treesitter', 'indent'}

			-- refer to ./doc/example.lua for detail
		end
	})
end

M.plugin = ufo
M.setup = setup_ufo
M.keymap = function()
	local keymap = vim.keymap.set
	local opts = {
		silent = true,
		noremap = false
	}

	keymap('n', 'zR', function() ufo.openAllFolds() end, opts)
	keymap('n', 'zM', function() ufo.closeAllFolds() end, opts)
	keymap('n', 'zr', function() ufo.openFoldsExceptKinds() end, opts)
	keymap('n', 'zm', function() ufo.closeFoldsWith() end, opts) -- closeAllFolds == closeFoldsWith(0)
	keymap('n', 'K', function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
					-- choose one of coc.nvim and nvim lsp
					-- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
					vim.lsp.buf.hover()
			end
	end, opts)
end

return M
