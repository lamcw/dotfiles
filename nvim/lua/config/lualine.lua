local function lualine_readonly()
  return (vim.bo.readonly and vim.bo.filetype ~= 'help') and '' or ''
end

local function lualine_gina_branch()
  local branch = vim.fn['gina#component#repo#branch']()
  return branch ~= '' and ' ' .. branch or ''
end

local function treesitter_statusline()
  return vim.fn['nvim_treesitter#statusline']({
    indicator_size = 40,
    separator = ' → '
  })
end

require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'challenger_deep',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  tabline = {
    lualine_a = { 'tabs' },
    lualine_b = { treesitter_statusline },
    lualine_z = { 'buffers' },
  },
  sections = {
    lualine_b = {
      lualine_readonly,
      lualine_gina_branch,
      { 'diagnostics', sources = { 'nvim_diagnostic' } }
    },
  },
  extensions = { 'fzf' }
}

