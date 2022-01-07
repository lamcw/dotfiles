vim.o.foldmethod = 'expr'
vim.o.foldexpr = vim.fn['nvim_treesitter#foldexpr']()

require'nvim-treesitter.configs'.setup {
  ensure_installer = "maintained",
  highlight = {
    enable = true
  },
  indent = {
    enable = false
  }
}
