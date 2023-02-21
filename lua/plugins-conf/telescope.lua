local ok, telescope = pcall(require, "telescope")
if not ok then
		return
end

telescope.load_extension("fzf")
telescope.load_extension("repo")
telescope.load_extension("git_worktree")
-- require("telescope").load_extension("coc")

local actions    = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local telescope_builtin = require("telescope.builtin")

local M = {}

M.setup = function ()
	telescope.setup {
			defaults = {
					layout_strategy = "horizontal",
					layout_config   = {
							height          = 0.9,
							preview_cutoff  = 120,
							prompt_position = "top",
							width           = 0.8
					},
					prompt_prefix        = " ⚡︎ ",
					file_sorter          = sorters.get_fzy_sorter,
					sorting_strategy     = "ascending",
					color_devicons       = true,
					--wrap_results       = true,
					file_ignore_patterns = {"^node_modules/"},

					vimgrep_arguments    = {
							"rg",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case"
					},

					file_previewer   = previewers.vim_buffer_cat.new,
					grep_previewer   = previewers.vim_buffer_vimgrep.new,
					qflist_previewer = previewers.vim_buffer_qflist.new,
					preview = {
							mime_hook = function(filepath, bufnr, opts)
									local is_image = function(imgpath)
											local image_extensions = {'png','jpg','jpeg'}
											local split_path       = vim.split(imgpath:lower(), '.', {plain=true})
											local extension        = split_path[#split_path]

											return vim.tbl_contains(image_extensions, extension)
									end

									if is_image(filepath) then
											local term = vim.api.nvim_open_term(bufnr, {})
											local function send_output(_, data, _ )
													for _, d in ipairs(data) do
															vim.api.nvim_chan_send(term, d..'\r\n')
													end
											end

											vim.fn.jobstart(
													{
															'imgcat', filepath  -- Terminal image viewer command
													},
													{on_stdout=send_output, stdout_buffered=true, pty=true})
									else
											require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
									end
							end
					},
			},
			mappings = {
					i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<C-n>"] = actions.cycle_previewers_next,
							["<C-p>"] = actions.cycle_previewers_prev,
							["<C-h>"] = "which_key",
							["<ESC>"] = actions.close,
					},
					n = {
							["j"] = actions.cycle_previewers_next,
							["k"] = actions.cycle_previewers_prev,
					}
			},
			extensions = {
					fzf = {
							fuzzy                   = true, -- false will only do exact matching
							override_generic_sorter = true, -- override the generic sorter
							override_file_sorter    = true, -- override the file sorter
							case_mode               = "smart_case" -- or "ignore_case" or "respect_case", default "smart_case"
					},
					repo = {
							list = {
									pattern = [[^\.git$]],
									fd_opts = {
											"--no-ignore-vcs",
									},
									search_dirs = {
											"~/WorkSpace",
											"~/MyProjects",
											"~/MyLeecode",
											"~/MyNotes",
											"~/MySDK"
									},
							},
							cached_list = {
									-- locate_opts = {
									-- 		"-d",
									-- 		vim.env.HOME .. "/locatedb"
									-- },
									file_ignore_patterns = {
											"/%.cache/",
											"/%.cargo/"
									}
							}
					},
					-- coc = {
					--     -- theme = 'ivy',
					--     prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
					-- }
			}
	}
end

M.plugin = telescope
M.plugin_builtin = telescope_builtin
M.keymap = function()
	local keymap = vim.keymap.set
	local opts = {
		silent = true,
		noremap = false
	}

	keymap("n", "<Leader>ts", "<cmd>Telescope<CR>", opts)
	keymap("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", opts)
	keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", opts)
	keymap("n", "<Leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
	keymap("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)
	keymap("n", "<Leader>fc", "<cmd>Telescope git_commits<CR>", opts)
	keymap("n", "<Leader>km", "<cmd>Telescope keymaps<CR>", opts)
	-- nnoremap <Leader>fh <Cmd>Telescope help_tags<CR>", optes)
	keymap("n", "<Leader>fp", "<cmd>Telescope repo list<CR>", opts)
	-- Find word/file across project
	keymap("n", "<Leader>pf",
		function() telescope_builtin.find_files({ default_text = vim.fn.expand('<cword>'), initial_mode = 'normal' }) end,
		opts)
	keymap("n", "<Leader>pw", function() telescope_builtin.grep_string({ initial_mode = 'normal' }) end, opts)

	-- git_worktree
	keymap({"n", "i"}, "<Leader>gww", function ()
		telescope.extensions.git_worktree.git_worktrees()
		-- <Enter> - switches to that worktree
		-- <c-d> - deletes that worktree
		-- <c-f> - toggles forcing of the next deletion
	end, opts)
	keymap({"n", "i"}, "<Leader>gwc", function ()
		telescope.extensions.git_worktree.create_git_worktree()
	end, opts)
end

-- Autocmd
-- autocmd User TelescopePreviewerLoaded setlocal wrap
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  command = "setlocal wrap"
})

return M

