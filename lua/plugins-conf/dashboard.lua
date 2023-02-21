local db_ok, db = pcall(require, "dashboard")
if not db_ok then
	return
end

local M = {}
local config_path = require("config.basic").config_path
local assets = config_path .. "/assets/banner"

local function setup_dashboard()
	db.setup({
		theme = "doom", -- options: "doom", "hyper". defalut "hyper"
		preview = {
			command = "cat | lolcat -F 0.18",
			file_path = assets .. "/hollyworld",
			file_height = 15,
			file_width = 120,
		},
		hide = {
			statusline = true,
			tabline = true,
			winbar = true,
		},
		config = {
			-- week_header = {
			--    enable = true,
			-- },
			-- packages = { enable = true }, -- show how many plugins neovim loaded
			center = {
				{
					icon = "🐠  ",
					desc = "Find Git Project                         ",
					action = "Telescope repo list",
					key = "SPC fp",
					icon_hl = "group",
					desc_hl = "group",
					key_hl = "group",
				},
				{
					icon = "  ", -- 
					desc = "New buffer                               ",
					action = "<Cmd>enew<CR>",
					key = "SPC tn",
					icon_hl = "group",
					desc_hl = "group",
					key_hl = "group",
				},
				{
					icon = "  ",
					desc = "Recently opened files                    ",
					action = "Telescope oldfiles",
					key = "SPC fo",
					icon_hl = "group",
					desc_hl = "group",
					key_hl = "group",
				},
				{
					icon = "  ",
					desc = "Find  File                               ",
					action = "Telescope find_files",
					key = "SPC ff",
					icon_hl = "group",
					desc_hl = "group",
					key_hl = "group",
				},
				{
					icon = "  ",
					desc = "Git Commits                              ",
					action = "Telescope git_commits",
					key = "SPC fc",
					icon_hl = "group",
					desc_hl = "group",
					key_hl = "group",
				},
				{
					icon = "  ",
					desc = "File Browser                             ",
					action = "RnvimrToggle",
					key = "<M-o>",
					icon_hl = "group",
					desc_hl = "group",
					key_hl = "group",
				},
				{
					icon = "  ",
					desc = "Find  word                               ",
					action = "Telescope live_grep",
					key = "SPC fg",
					icon_hl = "group",
					desc_hl = "group",
					key_hl = "group",
				},
				{
					icon = "  ",
					desc = "Find Keymaps                             ",
					action = "Telescope keymaps",
					key = "SPC km",
					icon_hl = "group",
					desc_hl = "group",
					key_hl = "group",
				},
			},
			footer = { "", "", "🫧 🚀 🚀 🚀 Funny 🫧" },
		},
	})
end

M.plugin = db
M.setup = setup_dashboard

return M
-- -- macos
-- db.preview_command = "cat | lolcat -F 0.18"
-- -- db.preview_command = "cat | figlet -c -w 200 < "
-- db.preview_file_path = assets .. "/hollyworld"
-- db.preview_file_height = 15
-- db.preview_file_width = 120

-- db.custom_center = {
--     {
--         icon = "  ",
--         desc = "Recently opened files                    ",
--         action = "Telescope oldfiles",
--         shortcut = "SPC fo"},
--     {
--         icon = "  ",
--         desc = "Find  File                               ",
--         action = "Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍",
--         shortcut = "SPC ff"},
--     {
--         icon = "  ",
--         desc = "Git Commits                              ",
--         action = "Telescope git_commits",
--         shortcut = "SPC fc"},
--     {
--         icon = "  ",
--         desc = "File Browser                             ",
--         action = "RnvimrToggle",
--         shortcut = "<M-o>"},
--     {
--         icon = "  ",
--         desc = "Find  word                               ",
--         action = "Telescope live_grep",
--         shortcut = "SPC fg"},
--     {
--         icon = "-> ",
--         desc = "Find Keymaps                             ",
--         action = "Telescope keymaps",
--         shortcut = "SPC km"},
-- }
