local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

------------------------------------------------------------------
--                                                               -
-- Basic
--                                                               -
------------------------------------------------------------------
keymap("n", ";", ":", opts)
keymap("x", ";", ":", opts)

------------------------------------------------------------------
--                                                               -
-- Window controls
--                                                               -
------------------------------------------------------------------
-- split vim window
if vim.fn.has("vertsplit") then
	--- split current window vertically
	keymap("n", "<Leader>-", "<C-w>v<C-w>l", opts)
end
if vim.fn.has("windows") then
	--- split current window horizontally
	keymap("n", "<Leader>_", "<C-w>s", opts)
end

-- navigator to the window
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- window to the Up/Right/Down/Left
keymap("n", "<C-S-k>", "<C-w>K", opts)
keymap("n", "<C-S-l>", "<C-w>L", opts)
keymap("n", "<C-S-j>", "<C-w>J", opts)
keymap("n", "<C-S-h>", "<C-w>H", opts)

-- resize vim window
keymap("n", "<S-Left>", "<C-w>>", opts)
keymap("n", "<S-Down>", "<C-w>-", opts)
keymap("n", "<S-Up>", "<C-w>+", opts)
keymap("n", "<S-Right>", "<C-w><", opts)

------------------------------------------------------------------
--                                                               -
-- Curosr Operations
--                                                               -
------------------------------------------------------------------
--- move to the first non-blank character of the line
keymap("n", "HH", "^", opts)
keymap({ "i", "x" }, "HH", "<Home>", opts)
--- move to the end of the line
keymap("n", "LL", "$", opts)
keymap({ "i", "x" }, "LL", "<End>", opts)
--- move to Left/Right/Down/Up in the insert mode
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)

--- move to the position where the last change was made
--- noremap gI `.

--- move the selected line / block to up and down in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)

--- quickfix, jump to next/preview item.
keymap("n", "<Space>,", ":cp<CR>", opts)
keymap("n", "<Space>.", ":cn<CR>", opts)

------------------------------------------------------------------
--                                                               -
-- Buffer Controls
--                                                               -
------------------------------------------------------------------
-- Quit

-- Save
--- <Leader>w writes the whole buffer to the current file
keymap("n", "<Leader>w", "<CMD>w!<CR>", opts)
keymap("i", "<Leader>w", "<ESC><CMD>w!<CR>", opts)
--- <Leader>W writes all buffers
keymap("n", "<Leader>W", "<CMD>wa!<CR>", opts)
keymap("i", "<Leader>W", "<ESC><CMD>wa!<CR>", opts)

-- Create
keymap("n", "<Leader>new", "<CMD>enew<CR>", opts)

--- `:BW`, really delete the buffer, everything related to the buffer is lost
keymap("n", "<Leader><Tab>", ":Bw<CR>", opts)
keymap("n", "<Leader><S-Tab>", ":Bw!<CR>", opts)
--- move to the specified Buffer
keymap("n", "<Leader>bb", ":buffers<CR>:b<space>", opts)

--- increase & decrease
keymap("n", "-", "<C-x>", opts)
keymap("n", "=", "<C-a>", opts)

--- selection, select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

--- remap U to <C-r> for easier redo
keymap("n", "U", "<C-r>", opts)

--- insert a new line below.
keymap("n", "<Leader>o", "o<ESC>", opts)

-- search, see "kevinhwang91/nvim-hlslens"
-- keymap("n", "n", "nzz", opts)
-- keymap("n", "N", "Nzz", opts)
-- keymap("n", "*", "*zz", opts)
-- keymap("n", "#", "#zz", opts)
-- keymap("n", "g*", "g*zz", opts)

------------------------------------------------------------------
--                                                               -
-- Buffer Format
--                                                               -
------------------------------------------------------------------
-- indent
--- select blocks after indenting
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv|", opts)
keymap("x", "<S-Tab>", "<gv", opts)
keymap("x", "<Tab>", ">gv|", opts)
keymap("x", "<", "<<", opts)
keymap("x", ">", ">>", opts)

-- highlight
--- clear highlight
keymap("n", "<Enter>", ":nohl<CR>", opts)
--- highlight all instances of the current word where the cursor is positioned
keymap(
	"n",
	"<Leader>hlw",
	vim.cmd([[
		set hls
		let @/="\\<<C-r><C-w>\\>"
	]]),
	opts
)
--- use <Leader>hl1, <Leader>hl2, <Leader>hl3 to highlight words in different colors
keymap("n", "<Leader>hl1", function()
	-- vim.api.nvim_set_hl(0, 'String', {fg = '#FFEB95'})
	vim.cmd([[
		highlight Highlight1 ctermfg=0 ctermbg=226 guifg=Black guibg=Yellow
		execute "match Highlight1 /\<<C-r><C-w>\>/"
	]])
end, opts)
keymap("n", "<Leader>hl2", function()
	vim.cmd([[
		highlight Highlight2 ctermfg=0 ctermbg=51 guifg=Black guibg=Cyan
		execute "2match Highlight1 /\<<C-r><C-w>\>/"
	]])
end, opts)
keymap("n", "<Leader>hl3", function()
	vim.cmd([[
		highlight Highlight3 ctermfg=0 ctermbg=46 guifg=Black guibg=Green
		execute "3match Highlight1 /\<<C-r><C-w>\>/"
	]])
end, opts)
--- nnoremap <silent> <ESC><ESC> :nohl<CR> " same as kevinhwang91/nvim-hlslens keymap(<Leader>l), :nohl
