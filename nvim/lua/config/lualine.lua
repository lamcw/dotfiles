local function lualine_readonly()
  return (vim.bo.readonly and vim.bo.filetype ~= 'help') and '' or ''
end

local function lualine_gina_branch()
  local branch = vim.fn['gina#component#repo#branch']()
  return branch ~= '' and ' ' .. branch or ''
end

require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'challenger_deep',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_b = {
      lualine_readonly,
      lualine_gina_branch,
      { 'diagnostics', sources={ 'nvim_lsp' } }
    },
  },
  extensions = { 'fzf' }
}

