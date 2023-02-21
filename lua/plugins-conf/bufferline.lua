local ok, bufferline = pcall(require, "bufferline")
if not ok then
  return
end

local M = {}

vim.opt.termguicolors = true

local setup_bufferline = function()
  bufferline.setup {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      --numbers = "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      --numbers = "ordinal",
      numbers = function(opts)
        return string.format("%s·", opts.raise(opts.ordinal), opts.lower(opts.id))
      end,
      --- @deprecated, please specify numbers as a function to customize the styling
      --number_style = "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
      number_style = "superscript",
      close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
      -- NOTE: this plugin is designed with this icon in mind,
      -- and so changing this is NOT recommended, this is intended
      -- as an escape hatch for people who cannot bear it for whatever reason
      --indicator_icon = "",
      indicator = {
        icon = " ♓︎", -- ♨︎ ⚡︎this should be omitted if indicator style is not 'icon'
        style = "icon", -- 'icon' | 'underline' | 'none',
      },
      buffer_close_icon = "",
      modified_icon = "✷",
      close_icon = "",       -- 
      left_trunc_marker = "", -- 
      right_trunc_marker = "", -- 
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      name_formatter = function(buf) -- buf contains:
        -- name                | str        | the basename of the active file
        -- path                | str        | the full path of the active file
        -- bufnr (buffer only) | int        | the number of the active buffer
        -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
        -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`

        -- remove extension from markdown files for example
        if buf.name:match("%.md") then
          return vim.fn.fnamemodify(buf.name, ":t:r")
        end
      end,
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      tab_size = 18,
      truncate_names = true,  -- whether or not tab names should be truncated
      --diagnostics = false | "nvim_lsp" | "coc",
      diagnostics = false,
      diagnostics_update_in_insert = true,
      --[[diagnostics_indicator = function(count, level, diagnostics_dict, context)
						return "(" .. count .. ")"
					end,]]
      -- rest of config ...

      --- count is an integer representing total count of errors
      --- level is a string "error" | "warning"
      --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
      --- this should return a string
      --- Don't get too fancy as this function will be executed a lot
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number, buf_numbers)
        ---- filter out filetypes you don't want to see
        --if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --    return true
        --end
        ---- filter out by buffer name
        --if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        --    return true
        --end
        ---- filter out based on arbitrary rules
        ---- e.g. filter out vim wiki buffer from tabline in your work repo
        --if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        --    return true
        --end
        ---- filter out by it's index number in list (don't show first buffer)
        --if buf_numbers[1] ~= buf_number then
        --    return true
        --end

        --hidden for defx
        local finded, _ = string.find(vim.bo[buf_number].filetype, "NvimTree")
        if finded ~= nil then
          return false
        end
        return true
      end,
      --offsets = {{filetype = "NvimTree", text = "File Explorer" | function , text_align = "left" | "center" | "right", separator = true}},
      offsets = { {
        filetype = "NvimTree",
        --text = function()
        --    return vim.fn.getcwd()
        --end,
        text = "File Explorer",
        text_align = "left",
        highlight = "Directory",
        separator = true
      } },
      color_icons = true,
      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = true,
      show_buffer_default_icon = false,
      show_close_icon = false,
      show_tab_indicators = true,
      show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
      persist_buffer_sort = true,   -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      --separator_style = "slant" | "thick" | "thin" | {"any", "any"}, `{"|", "|"}
      separator_style = { "|", "" },
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' }
      },
      --[[sort_by = "id" | "extension" | "relative_directory" | "directory" | "tabs" | function(buffer_a, buffer_b)
							-- add custom logic
							return buffer_a.modified > buffer_b.modified
						end]]
      sort_by = "id"
      --highlights = {
      --    fill = {
      --        bg = {
      --            attribute = "fg",
      --            highlight = "Pmenu"
      --        }
      --    }
      --},
    }
  }
end

local keymap = function()
  local keymap = vim.keymap.set
  local opts = {
    silent = true,
    noremap = false
  }

  keymap("n", "<Leader>q", "<CMD>bdelete %<CR>", opts)
  keymap("n", "<Leader>qa", function()
    for _, e in ipairs(bufferline.get_elements().elements) do
      print(e)
      print(e.id)
      vim.schedule(function()
        vim.cmd("bd " .. e.id)
      end)
    end
    vim.cmd("Dashboard")
  end, opts)
  keymap("n", "<Leader>qo", "<CMD>BufferLineCloseLeft<CR><CMD>BufferLineCloseRight<CR>", opts)
  keymap("n", "<Leader>ql", "<CMD>BufferLineCloseLeft<CR>", opts)
  keymap("n", "<Leader>qr", "<CMD>BufferLineCloseRight<CR>", opts)
  keymap("n", "<Leader>qp", "<CMD>BufferLinePickClose<CR>", opts)

  keymap("n", "b]", "<CMD>BufferLineCycleNext<CR>", opts)
  keymap("n", "b[", "<CMD>BufferLineCyclePrev<CR>", opts)
  keymap("n", "bse", "<CMD>BufferLineSortByExtension<CR>", opts)
  keymap("n", "bsd", "<CMD>BufferLineSortByDirectory<CR>", opts)

  keymap("n", "<Leader>1", function() bufferline.go_to_buffer(1, true) end, opts)
  keymap("n", "<Leader>2", function() bufferline.go_to_buffer(2, true) end, opts)
  keymap("n", "<Leader>3", function() bufferline.go_to_buffer(3, true) end, opts)
  keymap("n", "<Leader>4", function() bufferline.go_to_buffer(4, true) end, opts)
  keymap("n", "<Leader>5", function() bufferline.go_to_buffer(5, true) end, opts)
  keymap("n", "<Leader>6", function() bufferline.go_to_buffer(6, true) end, opts)
  keymap("n", "<Leader>7", function() bufferline.go_to_buffer(7, true) end, opts)
  keymap("n", "<Leader>8", function() bufferline.go_to_buffer(8, true) end, opts)
  keymap("n", "<Leader>9", function() bufferline.go_to_buffer(9, true) end, opts)
  keymap("n", "<Leader>$", function() bufferline.go_to_buffer(-1, true) end, opts)
end

M.plugin = bufferline
M.setup = setup_bufferline
M.keymap = keymap

return M
