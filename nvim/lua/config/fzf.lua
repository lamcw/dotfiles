-- [Buffers] Jump to the existing window if possible
vim.g.fzf_buffers_jump = 1
vim.g.fzf_tags_command = 'ctags'

vim.g.fzf_colors = {
  fg = { 'fg', 'Normal' },
  bg = { 'bg', 'Normal' },
  hl = { 'fg', 'Comment' },
  ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
  ['hl+'] = { 'fg', 'Statement' },
  info = {'fg', 'PreProc' },
  border = {'fg', 'Ignore ' },
  prompt = {'fg', 'Conditional' },
  pointer = {'fg', 'Exception' },
  marker = {'fg', 'Keyword' },
  spinner = {'fg', 'Label' },
  header = {'fg', 'Comment' }
}

vim.api.nvim_set_keymap(
  'n',
  '<C-p>',
  ':Files<CR>',
  { noremap = true, silent = true }
)

-- hide status line
vim.cmd([[
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
]])
