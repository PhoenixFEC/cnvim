local ok, hlslens = pcall(require, "hlslens")
if not ok then
	return
end

local M = {}
local config
local lensBak

-- The lens has been adapted to the folds of nvim-ufo, still need remap n and N action if you want to peek at folded lines.
local function nN(char)
	local winid_ok, winid = hlslens.nNPeekWithUFO(char)
	if winid_ok and winid then
		-- Safe to override buffer scope keymaps remapped by ufo,
		-- ufo will restore previous buffer keymaps before closing preview window
		-- Type <CR> will switch to preview window and fire `trace` action
		vim.keymap.set('n', '<CR>', function()
			local keyCodes = vim.api.nvim_replace_termcodes('<Tab><CR>', true, false, true)
			vim.api.nvim_feedkeys(keyCodes, 'im', false)
		end, {buffer = true})
	end
end

-- Customize virtual text
local override_lens = function(render, posList, nearest, idx, relIdx)
	local sfw = vim.v.searchforward == 1
	local indicator, text, chunks
	local absRelIdx = math.abs(relIdx)
	if absRelIdx > 1 then
			indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
	elseif absRelIdx == 1 then
			indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
	else
			indicator = ''
	end

	local lnum, col = unpack(posList[idx])
	if nearest then
			local cnt = #posList
			if indicator ~= '' then
					text = ('[%s %d/%d]'):format(indicator, idx, cnt)
			else
					text = ('[%d/%d]'):format(idx, cnt)
			end
			chunks = {{' ', 'Ignore'}, {text, 'VM_Extend'}}
	else
			text = ('[%s %d]'):format(indicator, idx)
			chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
	end
	render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
end

local start = function()
    if hlslens then
        config = require('hlslens.config')
        config.override_lens = override_lens
        lensBak = config.override_lens
        hlslens.start()
    end
end

local exit = function()
    if hlslens then
        config.override_lens = lensBak
        hlslens.start()
    end
end

local keymap = function()
	local opts = {
		silent = true,
		noremap = false
	}

	vim.keymap.set({'n', 'x'}, 'n', function() nN('n') end)
	vim.keymap.set({'n', 'x'}, 'N', function() nN('N') end)

	vim.api.nvim_set_keymap("n", "n",
		[[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("plugins-conf.nvim-hlslens").start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "N",
		[[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("plugins-conf.nvim-hlslens").start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require("plugins-conf.nvim-hlslens").start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require("plugins-conf.nvim-hlslens").start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require("plugins-conf.nvim-hlslens").start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require("plugins-conf.nvim-hlslens").start()<CR>]], opts)

	vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", opts)
end

M.plugin = hlslens
M.setup = function()
	hlslens.setup()
end
M.start = start
M.exit = exit
M.keymap = keymap

return M
