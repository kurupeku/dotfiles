local fn = vim.fn
local api = vim.api

-- packer.nvimがインストールされていない際のbootstrap
local install_dir = fn.stdpath('data') .. '/site/pack/packer/opt/'
local install_path = install_dir .. 'packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'mkdir', '-p', install_dir }
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  }
end
api.nvim_command 'packadd packer.nvim'

-- このファイルに変更があった際にPackerSyncとPackerCompileを実行する
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local packer = require 'packer'
local util = require 'packer.util'
return packer.startup {
  function(use)
    -- 自身も管理対象に追加
    use { 'wbthomason/packer.nvim', opt = true }

    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = util.float,
    }
  }
}
