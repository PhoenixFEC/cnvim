local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
	return
end

local M = {}
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local viewMappings = {
    --custom_only = false,
    list          = {
        -- BEGIN_DEFAULT_MAPPINGS
        --{ key = { "o" },                          action = "edit" },
        --{ key = "<C-e>",                          action = "edit_in_place" },
        --{ key = "O",                              action = "edit_no_picker" },
        --{ key = { "<CR>" },                     action = "cd" },
        --{ key = "<C-v>",                          action = "vsplit" },
        --{ key = "<C-x>",                          action = "split" },
        --{ key = "<C-t>",                          action = "tabnew" },
        --{ key = "<",                              action = "prev_sibling" },
        --{ key = ">",                              action = "next_sibling" },
        --{ key = "P",                              action = "parent_node" },
        --{ key = "<BS>",                           action = "close_node" },
        --{ key = "<Tab>",                          action = "preview" },
        --{ key = "K",                              action = "first_sibling" },
        --{ key = "J",                              action = "last_sibling" },
        --{ key = "I",                              action = "toggle_git_ignored" },
        --{ key = "H",                              action = "toggle_dotfiles" },
        --{ key = "U",                              action = "toggle_custom" },
        --{ key = "R",                              action = "refresh" },
        --{ key = "a",                              action = "create" },
        --{ key = "d",                              action = "remove" },
        --{ key = "D",                              action = "trash" },
        --{ key = "r",                              action = "rename" },
        --{ key = "<C-r>",                          action = "full_rename" },
        --{ key = "x",                              action = "cut" },
        --{ key = "c",                              action = "copy" },
        --{ key = "p",                              action = "paste" },
        --{ key = "y",                              action = "copy_name" },
        --{ key = "Y",                              action = "copy_path" },
        --{ key = "gy",                             action = "copy_absolute_path" },
        --{ key = "[e",                             action = "prev_diag_item" },
        --{ key = "[c",                             action = "prev_git_item" },
        --{ key = "]e",                             action = "next_diag_item" },
        --{ key = "]c",                             action = "next_git_item" },
        --{ key = "-",                              action = "dir_up" },
        --{ key = "s",                              action = "system_open" },
        --{ key = "f",                              action = "live_filter" },
        --{ key = "F",                              action = "clear_live_filter" },
        --{ key = "q",                              action = "close" },
        --{ key = "W",                              action = "collapse_all" },
        --{ key = "E",                              action = "expand_all" },
        --{ key = "S",                              action = "search_node" },
        --{ key = ".",                              action = "run_file_command" },
        --{ key = "<C-k>",                          action = "toggle_file_info" },
        --{ key = "g?",                             action = "toggle_help" },
        --{ key = "m",                              action = "toggle_mark" },
        --{ key = "bmv",                            action = "bulk_move" }
        -- END_DEFAULT_MAPPINGS
    },
}

local setup = function()
	nvim_tree.setup({
			hijack_unnamed_buffer_when_opening = false,
			hijack_netrw = true,
			disable_netrw = true,
			-- create_in_closed_folder = true,
			sort_by                    = "case_sensitive",
			--root_dirs                = {},
			-- Changes the tree root directory on `DirChanged` and refreshes the tree. Default: false
			sync_root_with_cwd = false,
			-- will change cwd of nvim-tree to that of new buffer's when opening nvim-tree. default: false
			respect_buf_cwd     = false,
			filesystem_watchers = {
					--enable = true,
					--debounce_delay = 50,
					ignore_dirs = {"node_modules", "\\.git", "\\.svn", "cache$"},
			},
			view = {
					adaptive_size        = true,
					centralize_selection = true,
					hide_root_folder     = false,
					-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
					side                 = 'left',
					mappings             = viewMappings,
			},
			tab = {
					sync = {
							open = true,
							close = true,
							ignore = { "dashboard", "help", "qf" }
					}
			},
			renderer = {
					group_empty            = true,
					--add_trailing         = false,
					highlight_git          = true,

					-- highlight_opened_files, value can be `"none"`, `"icon"`, `"name"` or `"all"`.
					highlight_opened_files = "all",

					indent_markers = {
						enable = true,
						icons = {
							corner = "└",
							edge = "│",
							item = "│",
							bottom = "─",
							none = " ",
						},
					},

					icons = {
							show = {
									folder_arrow = false
							},
							glyphs = {
									folder = {
											--    
											arrow_closed = "",
											arrow_open   = "",
											default      = "",
											open         = "",
											empty        = "",
											empty_open   = "",
											symlink      = "",
											symlink_open = "",
									},
									git = {
											unstaged  = "⌯", -- ⁃□▻⌯▻
											staged    = "✓",
											unmerged  = "",
											renamed   = "➜",
											untracked = "★",
											deleted   = "✗",
											ignored   = "◌",
									},
							},
					}
			},
			-- Deprecated
			-- ignore_ft_on_setup = {},
			diagnostics        = {
					enable = false,
					icons  = {
							hint    = "",
							info    = "",
							warning = "",
							error   = "",
					}
			},
			-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
			update_focused_file = {
					-- enables the feature
					enable      = true,
					-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
					-- only relevant when `update_focused_file.enable` is true
					update_cwd  = false,
					-- Update the root directory of the tree if the file is not under current
					-- root directory. It prefers vim's cwd and `root_dirs`.
					-- Otherwise it falls back to the folder containing the file.
					-- Only relevant when `update_focused_file.enable` is `true`
					update_root = false,
					-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
					-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
					ignore_list = { "help", "dashboard" }
			},
			filters = {
					-- Toggle via the `toggle_dotfiles` action, default mapping `H`.
					dotfiles = false,
					git_clean = false,
					no_buffer = false,

					-- Toggle via the `toggle_custom` action, default mapping `U`.
					custom   = {"node_modules", "\\.git"},
					exclude = {},
			},
			git = {
					enable = true,
					ignore = true,
					timeout = 500,
			},
			actions = {
					expand_all = {
							--max_folder_discovery = 300,
							exclude = {"target", "build", ".git", "node_modules", ".cache"},
					},
					open_file = {
							quit_on_open = false,
							resize_window = true,
							window_picker = {
									enable = true,
									picker = "default",
									chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
									exclude = {
											filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
											buftype = { "nofile", "terminal", "help" },
									},
							},
					},
			},
			trash = {
					cmd             = "trash -F",
					require_confirm = true,
			},
			live_filter = {
					prefix              = "  ⚡︎",
					always_show_folders = true,
			},

	})
end

local open_nvim_tree = function(data)
  local IGNORED_FT = {
    "markdown",
    "help",
    "dashboard",
    "qf",
    "",
  }

  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- &ft
  local filetype = vim.bo[data.buf].ft

  -- only files please
  if not real_file and not no_name then
    return
  end

	print(vim.inspect(data))
	print(vim.inspect(filetype))
	print(vim.tbl_contains(IGNORED_FT, filetype))

  -- skip ignored filetypes
  if vim.tbl_contains(IGNORED_FT, filetype) then
    return
  end

  -- open the tree but don't focus it
  require("nvim-tree.api").tree.toggle({ focus = false })
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

M.setup = setup
M.plugin = nvim_tree
M.plugin_api = require("nvim-tree.api")
M.keymap = function ()
	local keymap = vim.keymap.set
	local opts = {
		silent = true,
		noremap = false
	}

	keymap("n", "<C-e>", M.plugin_api.tree.toggle, opts)
	keymap("n", "<leader>mn", M.plugin_api.marks.navigate.next, opts)
	keymap("n", "<leader>mp", M.plugin_api.marks.navigate.prev, opts)
	keymap("n", "<leader>ms", M.plugin_api.marks.navigate.select, opts)
end

return M
