require 'hop'.setup {
  keys = 'etovxqpdygfblzhckisuran',
  multi_windows = true,
}

local api = vim.api
api.nvim_set_keymap('n', '<leader><leader>', [[<cmd> lua require'hop'.hint_char2()<cr>]], {})
api.nvim_set_keymap('v', '<leader><leader>', [[<cmd> lua require'hop'.hint_char2()<cr>]], {})
api.nvim_set_keymap('o', '<leader><leader>', [[<cmd> lua require'hop'.hint_char2()<cr>]], {})
api.nvim_set_keymap('n', '<leader>/', [[<cmd> lua require'hop'.hint_lines()<cr>]], {})
api.nvim_set_keymap('v', '<leader>/', [[<cmd> lua require'hop'.hint_lines()<cr>]], {})
api.nvim_set_keymap('o', '<leader>/', [[<cmd> lua require'hop'.hint_lines()<cr>]], {})
