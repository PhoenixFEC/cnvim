local copilot_ok, copilot = pcall(require, "copilot")
if not copilot_ok then
	return
end

local M = {}

local function setup_copilot()
	copilot.setup({
		panel = {
			enabled = true,
			auto_refresh = true,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
			layout = {
				position = "right", -- | top | left | right
				ratio = 0.4,
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = false,
			debounce = 75,
			keymap = {
				accept = "<M-l>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		filetypes = {
			-- yaml = false,
			markdown = true,
			-- help = false,
			-- gitcommit = false,
			-- gitrebase = false,
			-- hgcommit = false,
			-- svn = false,
			-- cvs = false,
			javascriptreact = true, -- allow specific filetype
			javascript = true, -- allow specific filetype
			typescript = true, -- allow specific filetype
			["*"] = false, -- disable for all other filetypes and ignore default `filetypes`		-- ["."] = false,
		},
		copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v16.19.1/bin/node", -- Node.js version must be > 16.x
		server_opts_overrides = {
			trace = "verbose",
			settings = {
				advanced = {
					listCount = 10, -- #completions for panel
					inlineSuggestCount = 3, -- #completions for getCompletions
				},
			},
		},
	})

	-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end

M.plugin = copilot
M.setup = setup_copilot

return M
