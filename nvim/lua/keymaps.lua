vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap

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
  map("", k, v, { noremap = true, silent = false })
end

for k, v in pairs(nmaps) do
  map("n", k, v, { noremap = false, silent = false })
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

if vim.fn.exists([[g:vscode]]) == 1 then
  local n_caller = function(key, cmd)
    map('n', key, "<Cmd>call VSCodeNotify('" .. cmd .. "')<CR>", { noremap = true })
  end

  local code_map = {
    ['<leader>f'] = 'editor.action.formatDocument',
    ['<leader>r'] = 'editor.action.rename',
    ['<leader>]'] = 'workbench.action.nextEditor',
    ['<leader>['] = 'workbench.action.previousEditor',
    ['<leader>a'] = 'keyboard-quickfix.openQuickFix',
    ['<leader>x'] = 'workbench.actions.view.problems',
    ['<leader>v'] = 'editor.action.marker.nextInFiles',
    ['<leader>V'] = 'editor.action.marker.prevInFiles',
    ['<leader>g'] = 'workbench.scm.focus',
    ['<C-o>'] = 'workbench.action.navigateBack',
    ['<C-n>'] = 'workbench.view.explorer',
    ['<C-/>'] = 'workbench.action.showCommands',
    ['ff'] = 'workbench.action.quickOpen',
    ['fg'] = 'workbench.view.search.focus',
    ['gd'] = 'editor.action.revealDefinition',
    ['gr'] = 'editor.action.goToReferences',
    ['gi'] = 'editor.action.goToImplementation',
  }

  for k, v in pairs(code_map) do
    n_caller(k, v)
  end

  map('n', 'z=', "<Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>", { noremap = true })
end
