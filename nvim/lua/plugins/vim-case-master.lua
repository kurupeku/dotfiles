local map = vim.api.nvim_set_keymap

map('n', '<leader>cc', [[:<C-u>CaseMasterRotateCase<CR>]], { silent = true, noremap = true })
map('v', '<leader>cc', [[:<C-u>CaseMasterRotateCaseVisual<CR>]], { silent = true, noremap = true })
