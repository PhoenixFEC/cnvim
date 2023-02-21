local ok, lualine = pcall(require, "lualine")
if not ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "NvimTree", "dashboard" },
			winbar = { "NvimTree", "dashboard" },
		},
		ignore_focus = { "NvimTree", "dashboard" },
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
		},
		lualine_b = {
			"branch",
			{
				"diff",
				colored = true, -- Displays a colored diff status if set to true
				-- diff_color = {
				--     -- Same color values as the general color option can be used here.
				--     added    = "DiffAdd",    -- Changes the diff"s added color
				--     modified = "DiffChange", -- Changes the diff"s modified color
				--     removed  = "DiffDelete", -- Changes the diff"s removed color you
				-- },
				symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
			},
		},
		lualine_c = {
			"diagnostics",
			"location",
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				newfile_status = false, -- Display new file status (new file means no write after created)
				path = 0, -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
			"filesize",
		},
		lualine_x = {
			"encoding",
			"filetype",
			{
				"fileformat",
				symbols = {
					unix = "", -- e712
					dos = "", -- e70f
					mac = "", -- e711
				},
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "os.date('%a %b %d  %H:%M')" }, --  
	},
	-- inactive_sections = {
	--     lualine_a = {},
	--     lualine_b = {},
	--     lualine_c = {},
	--     lualine_x = {},
	--     lualine_y = {},
	--     lualine_z = {}
	-- },
	-- tabline = {
	--   lualine_a = {},
	--   lualine_b = {},
	--   lualine_c = {},
	--   lualine_x = {},
	--   lualine_y = {},
	--   lualine_z = {"tabs"}
	-- },
	winbar = {
		lualine_a = {},
		lualine_b = {
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				newfile_status = false, -- Display new file status (new file means no write after created)
				path = 3, -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	-- inactive_winbar = {
	--   lualine_a = {},
	--   lualine_b = {},
	--   lualine_c = {},
	--   lualine_x = {},
	--   lualine_y = {},
	--   lualine_z = {}
	-- },
	--extensions = {}
})
