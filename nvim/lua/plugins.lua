local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "plugins.nvim_tree"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons"
  },
  { 
    "williamboman/mason.nvim", 
    config = function()
      require "plugins.mason"
    end
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require "plugins.none_ls"
    end
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require "plugins.mason_null_ls"
    end
  },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup()
      vim.cmd("colorscheme github_dark")
    end
  }
})
