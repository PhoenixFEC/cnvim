local ok, copilot_cmp = pcall(require, "copilot_cmp")
if not ok then
	return
end

local M = {}

M.plugin = copilot_cmp
M.setup = function()
	copilot_cmp.setup({
		sorting = {
			priority_weight = 2,
			comparators = {
				require("copilot_cmp.comparators").prioritize,
				require("copilot_cmp.comparators").score,

				-- -- Below is the default comparitor list and order for nvim-cmp
				-- cmp.config.compare.offset,
				-- -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
				-- cmp.config.compare.exact,
				-- cmp.config.compare.score,
				-- cmp.config.compare.recently_used,
				-- cmp.config.compare.locality,
				-- cmp.config.compare.kind,
				-- cmp.config.compare.sort_text,
				-- cmp.config.compare.length,
				-- cmp.config.compare.order,
			},
		},
	})
end

return M
