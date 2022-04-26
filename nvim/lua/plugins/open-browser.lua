local set_map = vim.api.nvim_set_keymap

set_map('n', '?', '<Plug>(openbrowser-open)', { noremap = true, silent = true })
set_map('v', '?', '<Plug>(openbrowser-open)', { noremap = true, silent = true })
