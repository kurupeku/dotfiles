require 'lspsaga'.init_lsp_saga {
  max_preview_lines = 30
}

--- In lsp attach function
local map = vim.api.nvim_set_keymap
-- map("n", "<leader>r", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true })
map("n", "<leader>a", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })
-- scroll down hover doc or scroll in definition preview
map('n', '<C-j>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]], { noremap = true, silent = true })
-- scroll up hover doc
map('n', '<C-k>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]], { noremap = true, silent = true })
-- map("n", "<leader>x", "<cmd>Lspsaga show_line_diagnostics<cr>", { silent = true, noremap = true })
map("n", "<leader>v", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
map("n", "<leader>V", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
