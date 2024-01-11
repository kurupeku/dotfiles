vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap

-- Keymaps

local noremaps = {
  ["*"] = [[*zz]],
  ["#"] = [[#zz]],
  n = [[nzz]],
  N = [[Nzz]],
}

local nnoremaps = {
  ["<Esc><Esc>"] = ":nohl<CR>",
  k = "gk",
  j = "gj",
  H = "^",
  L = "$",
  x = [["_x]],
  s = [["_s]],
  ["&lt;Tab&gt;"] = "%",
  ["<leader>]"] = ":bnext<CR>",
  ["<leader>["] = ":bprev<CR>",
}

local inoremaps = {
  jj = "<Esc>",
}

local vnoremaps = {
  x = [["_x]],
  s = [["_s]],
  H = "^",
  L = "$",
  ["&lt;Tab&gt;"] = "%",
}

for k, v in pairs(noremaps) do
  map("", k, v, { noremap = true, silent = true })
end

for k, v in pairs(nnoremaps) do
  map("n", k, v, { noremap = true, silent = true })
end

for k, v in pairs(inoremaps) do
  map("i", k, v, { noremap = true, silent = true })
end

for k, v in pairs(vnoremaps) do
  map("v", k, v, { noremap = true, silent = true })
end
