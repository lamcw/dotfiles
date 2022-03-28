vim.o.tags = '.tags;'
vim.api.nvim_set_keymap(
  'n',
  '<F8>',
  ':TagbarToggle<CR>',
  { noremap = true, silent = true }
)
vim.g.tagbar_type_make = { kinds = { 'm:macros', 't:targets' } }
