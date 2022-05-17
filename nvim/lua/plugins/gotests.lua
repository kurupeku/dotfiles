require('gotests').setup()

vim.api.nvim_set_keymap('n', '<leader>tg', [[:GoTests]], { noremap = true, silent = true })
