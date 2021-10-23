-- bootstrap packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system(
    {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
  )
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'lamcw/challenger-deep-vim',
    as = 'challenger-deep',
    config = [[vim.cmd('colorscheme challenger_deep')]]
  }

  use { 'nvim-lualine/lualine.nvim', config = [[require('config.lualine')]] }

  -- LSP
  use { 'neovim/nvim-lspconfig', config = [[require('config.lsp')]] }

  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
    event = 'InsertEnter *',
    config = [[require('config.cmp')]]
  }

  -- Syntax highlighting
  use { 'NLKNguyen/c-syntax.vim', ft = { 'c' } }

  -- Tools
  use {
    'majutsushi/tagbar',
    cmd = 'TagbarToggle',
    setup = [[require('config.tagbar')]]
  }

  use 'lambdalisue/gina.vim'

  use {
    'tpope/vim-surround',
    keys = { { 'n', 'cs' }, { 'n', 'ds' }, { 'n', 'ys' }, { 'x', 'S' } }
  }

  use { 'tpope/vim-commentary', keys = { 'n', 'gc' } }

  use {
    'airblade/vim-gitgutter',
    event = 'BufWinEnter',
    setup = [[
      vim.g.gitgutter_sign_added = '│'
      vim.g.gitgutter_sign_modified = '│'
      vim.g.gitgutter_sign_removed = '│'
      vim.g.gitgutter_sign_removed_first_line = '│'
      vim.g.gitgutter_sign_modified_removed = '│'
      vim.api.nvim_set_keymap('n', ']h', '<Plug>(GitGutterNextHunk)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[h', '<Plug>(GitGutterPrevHunk)', { noremap = true, silent = true })
    ]],
    config = [[vim.cmd('GitGutterEnable')]]
  }

  use {
    'junegunn/fzf.vim',
    event = 'VimEnter',
    setup = [[require('config.fzf')]]
  }

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
