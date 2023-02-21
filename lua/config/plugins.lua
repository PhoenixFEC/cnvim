local cmd = vim.cmd
local keymap = vim.keymap.set
local opts = {
	silent = true,
	noremap = false,
}

return {
	-- Theme
	{
		"folke/tokyonight.nvim",
		-- lazy = false,
		priority = 1000,
		config = function()
			require("config.colorscheme")
			-- load the colorscheme here
			cmd([[colorscheme tokyonight-moon]])
		end,
	},

	------------------------------------------------------------------
	--                                                               -
	-- Layout
	--                                                               -
	------------------------------------------------------------------
	-- Misc
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("plugins-conf.dashboard").setup()
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"airblade/vim-rooter",
		config = function()
			vim.g.rooter_patterns = { ".git", "package.json", ".root", ".bzr", ".svn", "Makefile" }
			vim.g.rooter_silent_chdir = 1
			-- vim.g.rooter_change_directory_for_non_project_files = ""
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins-conf.indent")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins-conf.colorizer")
		end,
	},
	{ "petertriho/nvim-scrollbar" },

	-- File Explorer
	{
		"nvim-tree/nvim-tree.lua",
		-- lazy = false,
		keys = {
			{ "<C-e>", "<cmd>lua require('plugins-conf.nvim-tree').plugin_api.tree.toggle<CR>", desc = "NvimTree" },
		},
		config = function()
			-- disable netrw at the very start of your init.lua (strongly advised)
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			-- set termguicolors to enable highlight groups
			-- vim.opt.termguicolors = true

			local nvimtree = require("plugins-conf.nvim-tree")
			nvimtree.setup()
			nvimtree.keymap()
		end,
	},

	-- Buffers tabbar
	{
		"akinsho/bufferline.nvim",
		-- lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local bufferline = require("plugins-conf.bufferline")
			bufferline.setup()
			bufferline.keymap()
		end,
	},

	-- Status bar
	{
		"nvim-lualine/lualine.nvim",
		-- lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("plugins-conf.lualine")
		end,
	},

	------------------------------------------------------------------
	--                                                               -
	-- Improvement & Navigation
	--                                                               -
	------------------------------------------------------------------
	-- Fold
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local nvim_ufo = require("plugins-conf.nvim-ufo")
			nvim_ufo.setup()
			nvim_ufo.keymap()
		end,
	},

	{
		"mg979/vim-visual-multi",
		-- lazy = false,
		dependencies = { {
			"kevinhwang91/nvim-hlslens",
		} },
		config = function()
			-- vim.g.VM_leader = ";"
			require("plugins-conf.vim-visual-multi").autocmd()
		end,
	},

	{ "jiangmiao/auto-pairs" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins-conf.autopairs").setup()
		end,
	},
	{ "windwp/nvim-ts-autotag" },

	{ "kylechui/nvim-surround", config = true },
	{ "AndrewRadev/splitjoin.vim" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-speeddating" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		dependencies = {
			{
				"windwp/nvim-ts-autotag",
				config = function()
					-- require("nvim-ts-autotag").setup()
				end,
			},
			"mrjones2014/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-textsubjects",
			-- {
			-- 	"m-demare/hlargs.nvim",
			-- 	config = function()
			-- 		require("hlargs").setup({ color = "#F7768E" })
			-- 	end,
			-- },
		},
		config = function()
			require("plugins-conf.nvim-treesitter").setup()
		end,
	},

	{
		"nvim-pack/nvim-spectre",
		config = function()
			keymap("n", "<Leader>pr", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", opts)
			keymap("n", "<Leader>pr", "<cmd>lua require('spectre').open_visual()<CR>", opts)
		end,
	},

	-- Navigator
	{
		"nvim-telescope/telescope.nvim",
		-- lazy = false,
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "cljoly/telescope-repo.nvim" },
			{ "ThePrimeagen/git-worktree.nvim" },
		},
		config = function()
			local teleescope = require("plugins-conf.telescope")
			teleescope.setup()
			teleescope.keymap()
		end,
	},
	{
		"kevinhwang91/rnvimr",
		-- lazy = false,
		config = function()
			local rnvimr = require("plugins-conf.rnvimr")
			rnvimr.setup()
			rnvimr.keymap()
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		-- lazy = false,
		dependencies = "kevinhwang91/nvim-ufo",
		config = function()
			local hlslens = require("plugins-conf.nvim-hlslens")
			hlslens.setup()
			hlslens.keymap()
		end,
	},
	{
		"ggandor/leap.nvim",
		dependencies = {
			{ "tpope/vim-repeat" },
		},
		config = function()
			-- :h leap-config
			require("leap").add_default_mappings()
		end,
	},
	--{
	--	"ggandor/flit.nvim",
	--	dependencies = "ggandor/leap.nvim",
	--	config = function()
	--		require('flit').setup({
	--			keys = { f = 'f', F = 'F', t = 't', T = 'T' },
	--			-- A string like "nv", "nvo", "o", etc.
	--			labeled_modes = "nvo",
	--			multiline = true,
	--			-- Like `leap`s similar argument (call-specific overrides).
	--			-- E.g.: opts = { equivalence_classes = {} }
	--			--opts = {}
	--		})
	--	end
	--},
	{
		"pechorin/any-jump.vim",
	},

	------------------------------------------------------------------
	--                                                               -
	-- Git
	--                                                               -
	------------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins-conf.git.gitsigns")
		end,
	},
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugins-conf.git.diffview").setup()
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("plugins-conf.git.git-conflict")
		end,
	},
	{
		"ThePrimeagen/git-worktree.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			"<Leader>gwc",
			"<Leader>gww",
		},
		config = function()
			require("plugins-conf.git.git-worktree")
		end,
	},
	---  'airblade/vim-gitgutter'
	{
		"kdheepak/lazygit.nvim",
		lazy = false,
		cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilterCurrentFile", "LazyGitFilter" },
		config = function()
			require("plugins-conf.git.lazygit")
		end,
	},

	------------------------------------------------------------------
	--                                                               -
	-- Language Server Protocol & Complementarity
	--                                                               -
	------------------------------------------------------------------
	-- LSP
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		servers = nil,
	},

	-- LSP Format
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		config = function()
			require("plugins-conf.null-ls")
		end,
	},

	-- LSP Cmp & Snippet
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			"saadparwaiz1/cmp_luasnip",
			{ "tzachar/cmp-tabnine", build = "./install.sh" },
			{
				"David-Kunz/cmp-npm",
				config = function()
					require("cmp-npm").setup({
						ignore = {},
						only_semantic_versions = true,
					})
				end,
			},
			{ "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" },
			{
				"zbirenbaum/copilot-cmp",
				dependencies = {
					{
						"zbirenbaum/copilot.lua",
						cmd = "Copilot",
						event = "InsertEnter",
						config = function()
							require("plugins-conf.copilot").setup()
						end,
					},
				},
				enabled = false,
				config = function()
					require("plugins-conf.copilot-cmp").setup()
				end,
			},
		},
		config = function()
			require("plugins-conf.lsp.cmp")
		end,
	},

	-- LSP Addons
	{ "onsails/lspkind-nvim" },
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("plugins-conf.dressing")
		end,
	},
	{ "nvim-lua/popup.nvim" },

	------------------------------------------------------------------
	--                                                               -
	-- Development
	--                                                               -
	------------------------------------------------------------------
	{
		"Shatur/neovim-session-manager",
		lazy = false,
		config = function()
			require("plugins-conf.session-manager").setup()
		end,
	},
	{
		"voldikss/vim-floaterm",
		config = function()
			require("plugins-conf.vim-floaterm").keymap()
		end,
	},
	{
		"vuki656/package-info.nvim",
		event = "BufEnter package.json",
		config = function()
			require("plugins-conf.package-info")
		end,
	},
	{
		"RRethy/vim-hexokinase",
		build = "make hexokinase",
		config = function()
			vim.g.Hexokinase_highlighters = { "foreground" }
		end,
	},
	{
		"mlaursen/vim-react-snippets",
		dependencies = "SirVer/ultisnips",
	},
	{ "jose-elias-alvarez/typescript.nvim" },
	{
		"axelvc/template-string.nvim",
		event = "InsertEnter",
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		config = true, -- run require("template-string").setup()
	},
	{
		"peitalin/vim-jsx-typescript",
		dependencies = "leafgarland/typescript-vim",
		config = function()
			vim.cmd([[
				" set filetypes as typescriptreact
				autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
			]])
		end,
	},

	-- Format
	-- {
	-- 	"mhartington/formatter.nvim",
	-- 	config = function()
	-- 	end
	-- },

	-- Replacement
	{
		"svermeulen/vim-subversive",
	},

	-- Comment
	{
		"tpope/vim-commentary",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = "tpope/vim-commentary",
		config = function()
			-- move to treesitter
			-- require('ts_context_commentstring.internal').update_commentstring({
			--   key = '__multiline',
			-- })
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("plugins-conf.todo-comments").setup()
			require("plugins-conf.todo-comments").keymap()
		end,
	},

	-- AIGC
	{
		"zbirenbaum/copilot.lua",
	},
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup()
		end,
		cmd = { "ChatGPT", "ChatGPTEditWithInstructions" },
	},

	-- DAP
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("plugins-conf.dap")
		end,
		keys = {
			"<Leader>da",
			"<Leader>db",
			"<Leader>dc",
			"<Leader>dd",
			"<Leader>dh",
			"<Leader>di",
			"<Leader>do",
			"<Leader>dO",
			"<Leader>dt",
		},
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
		},
	},

	-- Markdown
	{ "dhruvasagar/vim-table-mode", ft = { "markdown" } },
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"dkarter/bullets.vim",
		config = function()
			vim.cmd([[
				let g:bullets_enabled_file_types = [
					\ 'markdown',
					\ 'text',
					\ 'gitcommit',
					\ 'scratch'
					\]
			]])
		end,
	},
	{
		"godlygeek/tabular",
		config = function()
			vim.cmd([[vnoremap gtb :Tabularize /]])
		end,
	},

	{ "voldikss/vim-translator" },
	-- I have a separate config.mappings file where I require which-key.
	-- With lazy the plugin will be automatically loaded when it is required somewhere
	{ "folke/which-key.nvim", lazy = true },
}
