vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local cnvim = {}

cnvim.is_debug = false

cnvim.config_path = vim.fn.stdpath("config")
cnvim.data_path = vim.fn.stdpath("data")
cnvim.cache_path = vim.fn.stdpath("cache")

if cnvim.is_debug then
	print(vim.inspect(cnvim))
end

return cnvim
