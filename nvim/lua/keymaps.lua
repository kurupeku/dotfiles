vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap

-- Keymaps

local noremaps = {
  ['*'] = [[*zz]],
  ['#'] = [[#zz]],
  ['n'] = [[nzz]],
  ['N'] = [[Nzz]],
}

local nnoremaps = {
  ["<Esc><Esc>"] = ":nohl<CR>",
  k = "gk",
  j = "gj",
  H = "^",
  L = "$",
}

local inoremaps_silent = {
  jj = "<Esc>",
}

local vnoremaps = {
  x = [["_x]],
  s = [["_s]],
  H = "^",
  L = "$",
}

for k, v in pairs(noremaps) do
  map("", k, v, { noremap = true, silent = false })
end

for k, v in pairs(nnoremaps) do
  map("n", k, v, { noremap = true, silent = false })
end

for k, v in pairs(inoremaps_silent) do
  map("i", k, v, { noremap = true, silent = true })
end

for k, v in pairs(vnoremaps) do
  map("v", k, v, { noremap = true, silent = false })
end
