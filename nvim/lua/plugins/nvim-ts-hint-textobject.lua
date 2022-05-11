vim.api.nvim_set_keymap('o', 'm', [[<cmd><C-U>lua require('tsht').nodes()<cr>]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', 'm', [[<cmd>lua require('tsht').nodes()<cr>]], { noremap = true, silent = true })
