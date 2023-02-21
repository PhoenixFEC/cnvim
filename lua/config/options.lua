vim.g.scriptencoding = "utf-8"
-- Leader
vim.g.mapleader = " "

local helper = require("../helper")

local set = vim.opt
local vimfn = vim.fn

set.path:prepend({ ".", "./lua", "./?.lua", "./lua/?.lua" })

-- Appearance
set.encoding = "utf-8"
set.fileencoding = "utf-8"
set.termguicolors = true
if not vimfn.has("gui_running") == 1 then
	set.t_Co = 256
end
set.background = "dark"
set.ruler = true
set.number = true
set.relativenumber = true
--- highline current line
set.cursorline = true
set.cursorlineopt = { "screenline", "number" }

--- no flash
set.errorbells = true
set.visualbell = true

set.secure = true
set.clipboard:prepend({ "unnamed", "unnamedplus" })
set.history = 1000
set.mouse = "nvc"

set.timeout = true
set.ttimeout = true
set.timeoutlen = 500 --- time out on mappings
set.ttimeoutlen = 50 --- time out on key codes
set.updatetime = 100 --- idle time to write swap and trigger CursorHold
set.redrawtime = 1500 --- time in milliseconds for stopping display redraw
--- don't redraw while executing macros (good performance config)
set.lazyredraw = true

--- command bar
set.cmdheight = 1
set.showcmd = true
set.showmode = true
---set.display:append({"lastline"})
--- show status. 0 -> Hidden, 1 -> When multi-window, 2 -> Show Always
set.laststatus = 2

--- change current work directory automatically
-- set.autochdir=true

-- Windows
--- split current window
if vimfn.has("vertsplit") == 1 then
	---- when splitting vertically, split to the right
	set.splitright = true
end
if vimfn.has("windows") == 1 then
	---- when splitting horizontally, split below
	set.splitbelow = true
end

--- padding of window to keep above and below the cursor
set.scrolloff = 2
set.sidescrolloff = 5

-- buffer
set.spell = false
set.bomb = false
--- switch to the paste mode to copy with no number
set.pastetoggle = "<F6>"

--- use Unix as the standard file type
set.ffs = { "unix", "dos", "mac" }
set.switchbuf = "usetab"
set.autoread = true
set.spelllang = "en_us"

set.showmatch = true
--- add HTML brackets to pair matching
set.matchpairs:append("<:>")
--- tenths of a second to show the matching paren
set.matchtime = 1

set.wrap = true
set.wrapmargin = 2
set.textwidth = 120
set.linebreak = true
set.whichwrap:append("h,l,<,>,[,],~")

--- indent
set.autoindent = true
set.smartindent = true
--- copy the previous indentation on autoindenting
set.copyindent = true
set.cindent = true
set.smarttab = true
set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.shiftround = true

set.foldenable = true
set.foldlevel = 99
set.foldlevelstart = 99
set.foldmethod = "manual"
-- set.foldmethod = "indent"

set.nrformats:remove("octal")
set.formatoptions:remove("t")
set.formatoptions:append("c")
set.formatoptions:append("r")
set.shortmess:append("c")

set.viewoptions = "folds,options,cursor,curdir,slash,unix"
set.conceallevel = 2
set.list = true
set.listchars = "tab:» ,eol:↵,trail:·,extends:↷,precedes:↶"
set.fillchars = "vert:│,fold:·"
set.backspace = "indent,eol,start"

set.wildmenu = true
set.wildmode = "longest:list,full"
set.wildignorecase = true
--- ignore the .git directory
set.wildignore:append(".git,.svn")
set.wildignore:append("*.DS_Store")
set.wildignore:append("**/node_modules/**,**/bower_modules/**")
set.wildignore:append("**/.sass-cache/**,**/npm-cache/**")
set.wildignore:append("__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**,.cache/**")

--- complete
set.completeopt = "menu,menuone,noselect,preview" -- longest,noinsert,
---- disable scanning included files
set.complete:remove("i")
---- disable searching tags
set.complete:remove("t")

--- cache
set.swapfile = false
set.writebackup = false
set.backup = false
set.undofile = true
set.undolevels = 1000
if not helper.is_directory(helper.get_data_path()) then
	vim.fn.mkdir(helper.get_data_path(), "p", 0700)
end
if not helper.is_directory(helper.get_cache_path("/backup")) then
	vim.fn.mkdir(helper.get_cache_path("/backup"), "p", 0700)
end
if not helper.is_directory(helper.get_cache_path("/swapfile")) then
	vim.fn.mkdir(helper.get_cache_path("/swapfile"), "p", 0700)
end
if not helper.is_directory(helper.get_cache_path("/undofile")) then
	vim.fn.mkdir(helper.get_cache_path("/undofile"), "p", 0700)
end

vim.filetype.add({
	extension = {
		wxml = "miniprogram",
		wcss = "css",
	},
	pattern = {
		["[jt]sconfig.*.json"] = "jsonc",
	},
})

if vim.fn.executable("rg") == 1 then
	set.grepformat = "%f:%l:%c:%m,%f:%l:%m" --- '%f:%l:%c%p%m'
	set.errorformat:append("%f:%l:%c%p%m")
	set.grepprg = "rg --vimgrep --no-heading --smart-case"
end
