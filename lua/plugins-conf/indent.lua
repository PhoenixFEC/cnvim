local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
	return
end

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

indent_blankline.setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = false,
    show_end_of_line = false,
    show_trailing_blankline_indent = false,

    --char = "",
    --char_highlight_list = {
    --    "IndentBlanklineIndent1",
    --    "IndentBlanklineIndent2",
    --},
    space_char_highlight_list = " ",
    --space_char_highlight_list = {
    --    "IndentBlanklineIndent1",
    --    "IndentBlanklineIndent2",
    --},
    use_treesitter = true,
    buftype_exclude = {"terminal", "telescope", "nofile"},
    filetype_exclude = {"help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float", "Floaterm"},
}
