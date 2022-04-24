local api = vim.api
local opt = { noremap = true, silent = true }

api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opt)
api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opt)
api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opt)
api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opt)
api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opt)
api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opt)
