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
					icon = "🐠 ",
					desc = "Find Git Project                          ",
					action = "Telescope repo list",
					key = "SPC fp",
					icon_hl = "DashboardIcon",
					desc_hl = "DashboardDesc",
					key_hl = "DashboardShotCut",
				},
				{
					icon = "  ", -- 
					desc = "New buffer                               ",
					action = "enew",
					key = "SPC tn",
					icon_hl = "DashboardIcon",
					desc_hl = "DashboardDesc",
					key_hl = "DashboardShotCut",
				},
				{
					icon = "  ",
					desc = "Recently opened files                    ",
					action = "Telescope oldfiles",
					key = "SPC fo",
					icon_hl = "DashboardIcon",
					desc_hl = "DashboardDesc",
					key_hl = "DashboardShotCut",
				},
				{
					icon = "  ",
					desc = "Find  File                               ",
					action = "Telescope find_files",
					key = "SPC ff",
					icon_hl = "DashboardIcon",
					desc_hl = "DashboardDesc",
					key_hl = "DashboardShotCut",
				},
				{
					icon = "  ",
					desc = "Git Commits                              ",
					action = "Telescope git_commits",
					key = "SPC fc",
					icon_hl = "DashboardIcon",
					desc_hl = "DashboardDesc",
					key_hl = "DashboardShotCut",
				},
				{
					icon = "  ",
					desc = "File Browser                             ",
					action = "RnvimrToggle",
					key = "<M-o>",
					icon_hl = "DashboardIcon",
					desc_hl = "DashboardDesc",
					key_hl = "DashboardShotCut",
				},
				{
					icon = "  ",
					desc = "Find  word                               ",
					action = "Telescope live_grep",
					key = "SPC fg",
					icon_hl = "DashboardIcon",
					desc_hl = "DashboardDesc",
					key_hl = "DashboardShotCut",
				},
				{
					icon = "  ",
					desc = "Find Keymaps                             ",
					action = "Telescope keymaps",
					key = "SPC km",
					icon_hl = "DashboardIcon",
					desc_hl = "DashboardDesc",
					key_hl = "DashboardShotCut",
				},
			},
			footer = { "", "", "🫧 🚀 🚀 🚀 Funny 🫧" },
		},
	})
end

M.plugin = db
M.setup = setup_dashboard

return M

