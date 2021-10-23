-- run PackerCompile automatically whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- load all plugins
require('plugins')

vim.o.termguicolors = true
-- Switch syntax highlighting on, when the terminal has colors
if (tonumber(vim.bo.t_Co) > 2 or vim.fn.has('gui_running')) and
    not vim.fn.exists('syntax_on') then
  vim.cmd('syntax on')
end

-- use F2 to toggle paste mode
vim.o.pastetoggle='<F2>'

-- no sound on errors
vim.o.errorbells = false
vim.o.visualbell = false

-- buffer redraw
vim.o.lazyredraw = true

-- file update delay
vim.o.updatetime = 250

-- vim cmd history
vim.o.history = 50

-- auto-read when file is changed
vim.o.autoread = true

vim.o.grepprg = 'rg --vimgrep'

-- searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.nu = true
vim.o.rnu = true

vim.cmd('filetype plugin indent on')
vim.o.modelines = 1
vim.o.smartindent = true

-- natural splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- line limit bar
vim.o.colorcolumn = '80'
-- don't render syntax highlighting beyond 200 characters
vim.o.synmaxcol = 200

-- keymaps
vim.api.nvim_set_keymap(
  'n',
  '<Space>',
  ':nohlsearch<Bar>:echo<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

mode_prefix_keys = {
  { mode = 't', pre = '<C-\\><C-N><C-w>' },
  { mode = 'i', pre = '<C-\\><C-N><C-w>' },
  { mode = 'n', pre = '<C-w>' },
}
direction_keys = {'h', 'j', 'k', 'l'}
split_adjust_keys = {'<', '+', '-', '>'} 

-- use ctrl+{h,j,k,l} to navigate windows from any mode
for _, mode_keys in ipairs(mode_prefix_keys) do
  mode = mode_keys['mode']
  pre = mode_keys['pre']
  for _, key in ipairs(direction_keys) do
    vim.api.nvim_set_keymap(
      mode,
      string.format('<C-%s>', key),
      pre .. key,
      { noremap = true }
    )
  end
end

-- use shift+{h,j,k,l} to adjust window size
for i, direction_key in ipairs(direction_keys) do
  split_key = split_adjust_keys[i]
  vim.api.nvim_set_keymap(
    '',
    string.format('<S-%s>', direction_key),
    string.format('<C-W>%s', split_key),
    { silent = true }
  )
end
