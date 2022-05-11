require 'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
    show_modified_status = true,
  },
  sections = {
    -- lualine_a = { 'mode' },
    -- lualine_b = { 'branch', 'diff', 'diagnostics' },
    -- lualine_c = { 'filename' },
    -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
    -- lualine_y = { 'progress' },
    -- lualine_z = { 'location' }
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch', 'diagnostics' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'encoding', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    -- lualine_a = {},
    -- lualine_b = {},
    -- lualine_c = { 'filename' },
    -- lualine_x = { 'location' },
    -- lualine_y = {},
    -- lualine_z = {}
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {}
}
