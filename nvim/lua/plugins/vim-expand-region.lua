local set_map = vim.api.nvim_set_keymap

set_map('v', 'v', '<Plug>(expand_region_expand)', { noremap = false, silent = true })
set_map('v', '<C-v>', '<Plug>(expand_region_shrink)', { noremap = false, silent = true })
