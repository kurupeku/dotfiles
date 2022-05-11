vim.api.nvim_set_keymap(
  'o', 'm', [[:<C-U>lua require('tsht').nodes()<cr>]], { noremap = false, silent = true }
)

vim.api.nvim_set_keymap(
  'v', 'm', [[:lua require('tsht').nodes()<cr>]], { noremap = true, silent = true }
)
