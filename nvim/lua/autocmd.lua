vim.cmd [[
  augroup golang
    autocmd!
    au FileType go setlocal sw=4 ts=4 sts=4 noet
  augroup END
]]
