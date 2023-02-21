local ok, nvim_autopairs = pcall(require, "nvim-autopairs")
if not ok then
		return
end

local M = {}
M.setup = function()
	nvim_autopairs.setup({
		disable_filetype = { "TelescopePrompt" , "vim" },
		check_ts = true,
		ts_config = {
			lua = { 'string' },
			javascript = { 'template_string' },
			java = false,
		}
	})

	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	local cmp_o = require('cmp')

	cmp_o.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end
M.plugin = nvim_autopairs

return M

-- FastWrap
--Before        Input                    After
----------------------------------------------------
--(|foobar      <M-e> then press $        (|foobar)
--(|)(foobar)   <M-e> then press q       (|(foobar))

