local M = {}

M.keymap = function ()
	vim.cmd [[
		" <M-o> ==> ø
		nnoremap <silent> ø :RnvimrToggle<CR>
		tnoremap <silent> ø <C-\><C-n>:RnvimrToggle<CR>

		" <M-i> ==> ˆ , Resize floating window by all preset layouts
		" tnoremap <silent> ˆ <C-\><C-n>:RnvimrResize<CR>

		" <M-l> ==> ¬ , Resize floating window by special preset layouts
		" tnoremap <silent> ¬ <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>

		" Resize floating window by single preset layout
		" tnoremap <silent> <M-y> <C-\><C-n>:RnvimrResize 6<CR>
	]]
end
M.setup = function ()
	vim.cmd [[
		" Allows you to use Ranger in a floating window
		" ---- kevinhwang91/rnvimr ----
		" Make Ranger replace Netrw and be the file explorer
		let g:rnvimr_enable_ex = 0

		" Make Ranger to be hidden after picking a file
		let g:rnvimr_enable_picker = 1

		" Replace `$EDITOR` candidate with this command to open the selected file
		let g:rnvimr_edit_cmd = 'drop'

		" Disable a border for floating window
		let g:rnvimr_draw_border = 0

		" Hide the files included in gitignore
		let g:rnvimr_hide_gitignore = 1

		" Change the border's color
		let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

		" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
		let g:rnvimr_enable_bw = 1

		" Add a shadow window, value is equal to 100 will disable shadow
		let g:rnvimr_shadow_winblend = 70

		" Draw border with both
		let g:rnvimr_ranger_cmd = ['ranger', '--cmd=set draw_borders both']

		" Link CursorLine into RnvimrNormal highlight in the Floating window
		highlight link RnvimrNormal CursorLine

		" Map Rnvimr action
		let g:rnvimr_action = {
								\ '<C-t>': 'NvimEdit tabedit',
								\ '<C-x>': 'NvimEdit split',
								\ '<C-v>': 'NvimEdit vsplit',
								\ 'gw': 'JumpNvimCwd',
								\ 'yw': 'EmitRangerCwd'
								\ }

		" Add views for Ranger to adapt the size of floating window
		let g:rnvimr_ranger_views = [
								\ {'minwidth': 90, 'ratio': []},
								\ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
								\ {'maxwidth': 49, 'ratio': [1]}
								\ ]

		" Customize the initial layout
		let g:rnvimr_layout = {
								\ 'relative': 'editor',
								\ 'width': float2nr(round(0.7 * &columns)),
								\ 'height': float2nr(round(0.7 * &lines)),
								\ 'col': float2nr(round(0.15 * &columns)),
								\ 'row': float2nr(round(0.15 * &lines)),
								\ 'style': 'minimal'
								\ }

		" Customize multiple preset layouts
		" '{}' represents the initial layout
		let g:rnvimr_presets = [
			\ {'width': 0.800, 'height': 0.800}
			\ ]

		" Fullscreen for initial layout
		" let g:rnvimr_layout = {
		"            \ 'relative': 'editor',
		"            \ 'width': &columns,
		"            \ 'height': &lines - 2,
		"            \ 'col': 0,
		"            \ 'row': 0,
		"            \ 'style': 'minimal'
		"            \ }
		"
		" Only use initial preset layout
		" let g:rnvimr_presets = [{}]
	]]
end

return M

