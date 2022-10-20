require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = { 'phpdoc' },
  yati = { enable = true },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}
