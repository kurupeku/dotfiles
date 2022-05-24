require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}

local opt = vim.opt
opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")
