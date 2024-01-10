require("nvim-tree").setup()

vim.keymap.set("n", "<C-m>", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<CR>", { silent = true, noremap = true })
