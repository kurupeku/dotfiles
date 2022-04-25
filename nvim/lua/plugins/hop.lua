require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

local api = vim.api
api.nvim_set_keymap('n', '<leader><leader>', [[<cmd> lua require'hop'.hint_words()<cr>]], {})
api.nvim_set_keymap('v', '<leader><leader>', [[<cmd> lua require'hop'.hint_words()<cr>]], {})
api.nvim_set_keymap('o', '<leader><leader>', [[<cmd> lua require'hop'.hint_words()<cr>]], {})
api.nvim_set_keymap('n', '<leader>/', [[<cmd> lua require'hop'.hint_lines()<cr>]], {})
api.nvim_set_keymap('v', '<leader>/', [[<cmd> lua require'hop'.hint_lines()<cr>]], {})
api.nvim_set_keymap('o', '<leader>/', [[<cmd> lua require'hop'.hint_lines()<cr>]], {})
