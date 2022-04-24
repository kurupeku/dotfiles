local api = vim.api

local vars = {
  ['fern#default_hidden'] = 1,
  ['fern#default_exclude'] = [[^\%(\.git\|\.byebug\|\.DS_Store\|\.idea\|*\.iml\|\.vscode\)$]]
}

for k, v in pairs(vars) do
  api.nvim_set_var(k, v)
end

api.nvim_set_keymap(
  'n',
  '<C-n>',
  '<cmd>Fern . -reveal=%<CR>',
  { noremap = false, silent = true }
)
