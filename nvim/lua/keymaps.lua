vim.g.mapleader = ' '

local api = vim.api

-- Keymaps

local noremaps = {
  ['\"+y'] = [["*y]],
  ['\"+Y'] = [["*Y]],
  ['\"+p'] = [["*p]],
  ['\"+P'] = [["*P]],
  ['<C-S-c>'] = [["*y]],
  ['<C-S-v>'] = [["*P]],
  ['*'] = [[*zz]],
  ['#'] = [[#zz]],
  ['n'] = [[nzz]],
}

local nmaps = {
  ["<Esc><Esc>"] = ":nohl<CR><Esc>",
}

local nnoremaps = {
  k = "gk",
  j = "gj",
}

local inoremaps_silent = {
  jj = "<Esc>"
}

local vnoremaps = {
  x = [["_x]],
}

for k, v in pairs(noremaps) do
  api.nvim_set_keymap("", k, v, { noremap = true, silent = false })
end

for k, v in pairs(nmaps) do
  api.nvim_set_keymap("n", k, v, { noremap = false, silent = false })
end

for k, v in pairs(nnoremaps) do
  api.nvim_set_keymap("n", k, v, { noremap = true, silent = false })
end

for k, v in pairs(inoremaps_silent) do
  api.nvim_set_keymap("i", k, v, { noremap = true, silent = true })
end

for k, v in pairs(vnoremaps) do
  api.nvim_set_keymap("v", k, v, { noremap = true, silent = false })
end

if vim.fn.exists([[g:vscode]]) == 1 then
  api.nvim_set_keymap('n', 'z=', "<Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>", { noremap = true })
end
