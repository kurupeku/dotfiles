vim.api.nvim_set_var('comfortable_motion_scroll_down_key', 'j')
vim.api.nvim_set_var('comfortable_motion_scroll_up_key', 'k')

vim.api.nvim_set_keymap('n', '<ScrollWheelDown>', ':call comfortable_motion#flick(40)<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<ScrollWheelUp>', ':call comfortable_motion#flick(-40)<cr>', {noremap = true, silent = true})

