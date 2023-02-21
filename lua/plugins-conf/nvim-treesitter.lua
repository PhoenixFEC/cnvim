local ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

local M = {}

M.plugin = treesitter_configs
M.setup = function()
	treesitter_configs.setup({
		-- A list of parser names, or "all"
		ensure_installed = {
			"typescript",
			"javascript",
			"html",
			"css",
			"python",
			"dart",
			"bash",
			"go",
			"c",
			"cpp",
			"lua",
			"vim",
		},
		-- ensure_installed = 'all',

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		-- List of parsers to ignore installing (for "all")
		--  ignore_install = { "javascript" },
		ignore_install = {},

		---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
		-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

		highlight = {
			-- `false` will disable the whole extension
			enable = true,

			-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
			-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
			-- the name of the parser)
			-- list of language that will be disabled
			--disable = { "c", "rust" },
			-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},

		indent = {
			-- enable = true
		},

		rainbow = {
			enable = true,
			extended_mode = true,
		},

		-- windwp/nvim-ts-autotag, enable
		autoTag = {
			enable = true,
		},

		context_commentstring = {
			enable = true,
			config = {
				-- Languages that have a single comment style
				css = { __default = "/* %s */", __multiline = "/* %s */" },
				scss = { __default = "// %s", __multiline = "/* %s */" },
				php = { __default = "// %s", __multiline = "/* %s */" },
				html = "<!-- %s -->",
				svelte = "<!-- %s -->",
				vue = "<!-- %s -->",
				astro = "<!-- %s -->",
				handlebars = "{{! %s }}",
				glimmer = "{{! %s }}",
				graphql = "# %s",
				--lua = { __default = '-- %s', __multiline = '--[[ %s ]]' },
				lua = "-- %s",
				vim = '" %s',
				twig = "{# %s #}",

				-- Languages that can have multiple types of comments
				tsx = {
					__default = "// %s",
					__multiline = "/* %s */",
					jsx_element = "{/* %s */}",
					jsx_fragment = "{/* %s */}",
					jsx_attribute = { __default = "// %s", __multiline = "/* %s */" },
					comment = { __default = "// %s", __multiline = "/* %s */" },
					call_expression = { __default = "// %s", __multiline = "/* %s */" },
					statement_block = { __default = "// %s", __multiline = "/* %s */" },
					spread_element = { __default = "// %s", __multiline = "/* %s */" },
				},
				javascript = {
					__default = "// %s",
					__multiline = "/* %s */",
					jsx_element = "{/* %s */}",
					jsx_fragment = "{/* %s */}",
					jsx_attribute = { __default = "// %s", __multiline = "/* %s */" },
					comment = { __default = "// %s", __multiline = "/* %s */" },
					call_expression = { __default = "// %s", __multiline = "/* %s */" },
					statement_block = { __default = "// %s", __multiline = "/* %s */" },
					spread_element = { __default = "// %s", __multiline = "/* %s */" },
				},
			},
			commentary_integration = {
				-- change default mapping
				--Commentary = 'g/',
				-- disable default mapping
				--CommentaryLine = false,
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]]"] = "@function.outer",
						["]m"] = "@class.outer",
					},
					goto_next_end = {
						["]["] = "@function.outer",
						["]M"] = "@class.outer",
					},
					goto_previous_start = {
						["[["] = "@function.outer",
						["[m"] = "@class.outer",
					},
					goto_previous_end = {
						["[]"] = "@function.outer",
						["[M"] = "@class.outer",
					},
				},
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["~"] = "@parameter.inner",
					},
				},
			},

			textsubjects = {
				enable = true,
				keymaps = {
					["<cr>"] = "textsubjects-smart", -- works in visual mode
				},
			},
		},
	})
end

return M
