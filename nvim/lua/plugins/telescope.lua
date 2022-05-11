require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "^%.git/", "^%.tmp/", "%.cache/", "%.DS_Store", "%.idea", ".iml", "%.vscode"
    },
  },
  pickers = {},
  extensions = {
    -- telescope-frecency.nvimの設定
    frecency = {
      default_workspace = "CWD",
      ignore_patterns = { "^%.git/", "^%.tmp/", "%.cache/", "%.DS_Store", "%.idea", ".iml", "%.vscode" },
    }
  }
}

local maps = {
  ff = [[<cmd>lua require('telescope').extensions.frecency.frecency()<cr>]],
  fg = [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
  fb = [[<cmd>lua require('telescope.builtin').buffers()<cr>]],
  fh = [[<cmd>lua require('telescope.builtin').help_tags()<cr>]]
}

for k, v in pairs(maps) do
  vim.api.nvim_set_keymap('n', k, v, { noremap = true, silent = true })
end
