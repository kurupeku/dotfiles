local maps = {
  ['*']   = '<Plug>(asterisk-*)',
  ['#']   = '<Plug>(asterisk-#)',
  ['g*']  = '<Plug>(asterisk-g*)',
  ['g#']  = '<Plug>(asterisk-g#)',
  ['z*']  = '<Plug>(asterisk-z*)',
  ['gz*'] = '<Plug>(asterisk-gz*)',
  ['z#']  = '<Plug>(asterisk-z#)',
  ['gz#'] = '<Plug>(asterisk-gz#)',
}

for k, v in pairs(maps) do
  vim.api.nvim_set_keymap('', k, v, { noremap = true, silent = true })
end
