local cnvim = require('config.basic')
local helper = {}

helper.is_win = package.config:sub(1, 1) == '\\' and true or false
helper.path_sep = helper.is_win and '\\' or '/'

helper.join_paths = _G.join_paths

---Join path segments that were passed as input
--@return string
function helper.path_join(...)
  return table.concat({ ... }, helper.path_sep)
end

function helper.get_data_path()
  if cnvim.data_path then
    return cnvim.data_path
  end
  return vim.fn.stdpath('data')
end

function helper.get_cache_path(dir)
  if cnvim.cache_path then
    return cnvim.cache_path .. dir
  end
  return vim.fn.stdpath('cache') .. dir
end

function helper.get_config_path()
  if cnvim.data_path then
    return cnvim.data_path
  end
  return vim.fn.stdpath('config')
end

local function get_color(color)
  local tbl = {
    black = '\027[90m',
    red = '\027[91m',
    green = '\027[92m',
    yellow = '\027[93m',
    blue = '\027[94m',
    purple = '\027[95m',
    cyan = '\027[96m',
    white = '\027[97m',
  }
  return tbl[color]
end

local function color_print(color)
  local rgb = get_color(color)
  return function(text)
    print(rgb .. text .. '\027[m')
  end
end

function helper.write(color)
  local rgb = get_color(color)
  return function(text)
    io.write(rgb .. text .. '\027[m')
  end
end

function helper.success(msg)
  color_print('green')('\t🍻 ' .. msg .. ' Success ‼️ ')
end

function helper.error(msg)
  color_print('red')('\t✘ ' .. msg)
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function helper.is_file(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function helper.is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory" or false
end

return helper
