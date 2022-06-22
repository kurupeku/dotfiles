local not_code = function()
  return vim.fn.exists('g:vscode') == 0
end

require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = not_code(),
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  yati = { enable = not_code() },
  autotag = {
    enable = not_code(),
  }
}
