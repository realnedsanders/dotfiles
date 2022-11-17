local g = vim.g
local opt = vim.opt

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local silent_noremap = {
    noremap = true,
    silent = true
}

local function nsnoremap(lhs, rhs)
    vim.api.nvim_set_keymap('n', lhs, rhs, silent_noremap)
end

-- Bufferline
---[[
require('bufferline').setup {
    animation = false,
    auto_hide = false,
    tabpages = true,
    closable = true,
    clickable = true,
    exclude_ft = {},
    exclude_name = {},
    icons = true,
    icon_custom_colors = false,
    icon_separator_active = '▎',
    icon_separator_inactive = '▎',
    icon_close_tab = '',
    icon_close_tab_modified = '●',
    icon_pinned = '車',
    insert_at_start = false,
    insert_at_end = true,
    maximum_padding = 1,
    maximum_length = 30,
    semantic_letters = true,
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    -- no_name_title = nil,
}

nsnoremap("<Tab>", "<CMD>BufferNext<CR>")
nsnoremap("<F2>", "<CMD>BufferPrevious<CR>")
nsnoremap("<F3>", "<CMD>BufferClose<CR>")


local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
  end
})
--]]

-- Colorizer
---[[
require('colorizer').setup {}
--]]

-- Indent
---[[
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
--]]

-- Lualine
---[[
local function spell_mode_on()
    local smo = vim.o.spell
    if (smo == true) then
        return "暈"
    else
        return ""
    end
end

local function total_visual_words()
    local vwc = vim.api.nvim_eval("wordcount()")["visual_words"]
    if (vwc ~= nil) then
        return "wc:" .. vwc
    else
        return ""
    end
end

local navic = require('nvim-navic')

require('lualine').setup {
    options = {
        theme = 'solarized_dark',
        section_separators = {},
        component_separators = { left = '|', right = '|' },
    },
    extensions = {},
    sections = {
        lualine_a = {
            { 'mode', lower = true },
            { spell_mode_on },
        },
        lualine_b = {
            'branch',
            'diff',
        },
        lualine_c = {
            'filename',
            { navic.get_location, cond = navic.is_available },
        },
        lualine_x = {
            'encoding',
            'fileformat',
            'filetype',
        },
        lualine_y = {
            'progress',
        },
        lualine_z = {
            { total_visual_words },
            'location',
        },
    },
}
--]]

-- nvim-tree
-- [[
local lib = require("nvim-tree.lib")

local git_add = function()
  local node = lib.get_node_at_cursor()
  local gs = node.git_status

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)

  -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  lib.refresh_tree()
end

require("nvim-tree").setup({
  open_on_setup = true,
  open_on_setup_file = true,
  ignore_buffer_on_setup = true,
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "<", action = "dir_up" },
        { key = ">", action = "cd" },
        { key = "ga", action = "git_add", action_cb = git_add },
      },
    },
  },
})

--]]

-- ToggleTerm
---[[
require('toggleterm').setup {
  size = function(term)
      if term.direction == "horizontal" then
          return 20
      elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
      end
  end,
  open_mapping = [[\\]],
  insert_mappings = false,
  terminal_mappings = true,
  -- on_open = fun(t: Terminal), -- function to run when the terminal opens
  -- on_close = fun(t: Terminal), -- function to run when the terminal closes
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1',
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true,
  shell = vim.o.shell,
}
local Terminal  = require('toggleterm.terminal').Terminal
--]]

-- gitcomm
---[[
local gitcomm = Terminal:new({
  cmd = "gitcomm",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})
function _gitcomm_toggle()
  gitcomm:toggle()
end

vim.api.nvim_set_keymap("n", "<Leader>a", "<cmd>lua _gitcomm_toggle()<CR>", {noremap = true, silent = true})
--]]

-- htop
---[[
local htop = Terminal:new({
  cmd = "htop",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})
function _htop_toggle()
  htop:toggle()
end

vim.api.nvim_set_keymap("n", "<Leader>h", "<cmd>lua _htop_toggle()<CR>", {noremap = true, silent = true})
--]]

-- LazyGit
---[[
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})
function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<Leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
--]]

-- Treesitter
---[[
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    ignore_install = {
        'phpdoc',
    },
    highlight = {
        enable = true,
        disable = { 'vimwiki' },
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = false },
    matchup = { enable = true },
    markid = { enable = true },
}

require('treesitter-context').setup {
    enable = true,
}
--]]
