local M = {}
M.keymap = function()
	vim.cmd([[
		let g:floaterm_width = 0.8
		let g:floaterm_height = 0.8
		let g:floaterm_borderchars = '─│─│╭╮╯╰'

		" let g:floaterm_keymap_new    = '<F7>'
		" let g:floaterm_keymap_prev   = '<S-F7>'
		" let g:floaterm_keymap_next   = '<F9>'
		" let g:floaterm_keymap_toggle = '<C-F7>'

		nnoremap   <silent>   <F7>   :FloatermToggle<CR>
		tnoremap   <silent>   <F7>   <C-\><C-n>:FloatermToggle<CR>
		" Ctrl + F7 -> <F31> in MocOS
		nnoremap   <silent>   <F31>    :FloatermPrev<CR>
		tnoremap   <silent>   <F31>    <C-\><C-n>:FloatermPrev<CR>
		" Shift + F7 -> <F19> in MocOS
		nnoremap   <silent>   <F19>    :FloatermNew<CR>
		tnoremap   <silent>   <F19>    <C-\><C-n>:FloatermNew<CR>

		tnoremap   <silent>   <C-u>    <C-\><C-n><C-u>
		tnoremap   <silent>   <C-d>    <C-\><C-n><C-d>

		" " Set floaterm window's background
		hi Floaterm guibg=#1f2335
		" " Set floating window border line color and background
		hi FloatermBorder guibg=#1f2335 guifg=#2ac3de
		" " Set floaterm window foreground once the cursor moves out from it
		hi FloatermNC guifg=#3d59a1
	]])
end

return M
