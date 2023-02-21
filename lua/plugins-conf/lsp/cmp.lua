local cmp_tabnine_status_ok, tabnine = pcall(require, "cmp_tabnine.config")
local cmp_status_ok, cmp = pcall(require, "cmp")
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not cmp_tabnine_status_ok or not cmp_status_ok or not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local lspkind = require("lspkind")
local types = require("cmp.types")

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local function deprioritize_snippet(entry1, entry2)
	if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
		return false
	end
	if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
		return true
	end
end

local icons = require("icons")
local source_mapping = {
	npm = icons.terminal .. "NPM",
	cmp_tabnine = icons.light,
	Copilot = icons.copilot,
	nvim_lsp = icons.paragraph .. "LSP",
	buffer = icons.buffer .. "BUF",
	nvim_lua = icons.bomb,
	luasnip = icons.snippet .. "SNP",
	calc = icons.calculator,
	path = icons.folderOpen2,
	treesitter = icons.tree,
	zsh = icons.terminal .. "ZSH",
}

local buffer_option = {
	-- Complete from all visible buffers (splits)
	get_bufnrs = function()
		local bufs = {}
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			bufs[vim.api.nvim_win_get_buf(win)] = true
		end
		return vim.tbl_keys(bufs)
	end,
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			-- this is the important line for copilot_cmp
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				-- local has_words_before = function()
				-- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
				-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				-- 	return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
				-- end
				-- if has_words_before() then
				-- 	cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				-- end
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-l>"] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-h>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			max_width = 50,
			symbol_map = source_mapping,
			before = function(entry, vim_item)
				vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
				local menu = source_mapping[entry.source.name]
				local maxwidth = 50

				if entry.source.name == "cmp_tabnine" then
					if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
						menu = menu .. entry.completion_item.data.detail
					else
						menu = menu .. "TBN"
					end
				end

				vim_item.menu = menu
				vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
				return vim_item
			end,
		}),
	},
	-- You should specify your *installed* sources.
	sources = {
		{ name = "nvim_lsp", priority = 9 },
		{ name = "npm", priority = 9 },
		{ name = "copilot", priority = 8 },
		{ name = "cmp_tabnine", priority = 8, max_num_results = 3 },
		{ name = "luasnip", priority = 7, max_item_count = 8 },
		{ name = "buffer", priority = 7, keyword_length = 5, option = buffer_option, max_item_count = 8 },
		{ name = "nvim_lua", priority = 5 },
		{ name = "path", priority = 4 },
		{ name = "calc", priority = 3 },
	},
	sorting = {
		comparators = {
			deprioritize_snippet,

			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,

			cmp.config.compare.offset,
		},
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		}),
	},
	experimental = {
		ghost_text = true,
	},
})

-- `/` buffer setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Tabnine Setup
tabnine:setup({
	max_lines = 1000,
	max_num_results = 3,
	sort = true,
	show_prediction_strength = true,
	run_on_every_keystroke = true,
	snipper_placeholder = "..",
	ignored_file_types = {},
})
