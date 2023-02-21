local ok, package_info = pcall(require, "package-info")
if not ok then
		return
end

local icons = require("icons")

package_info.setup {
		colors = {
				up_to_date = "#3C4048",
				outdated = "#fc514e",
		},

		icons = {
				enable = true,
				style = {
						up_to_date = icons.checkSquare,
						outdated = icons.gitRemove,
				},
		},

		-- Whether to autostart when `package.json` is opened
		autostart = true,

		hide_up_to_date = true,
		hide_unstable_versions = true,

		-- Can be `npm` or `yarn`. Used for `delete`, `install` etc...
		-- The plugin will try to auto-detect the package manager based on
		-- `yarn.lock` or `package-lock.json`. If none are found it will use the
		-- provided one, if nothing is provided it will use `yarn`
		package_manager = 'yarn'
}
